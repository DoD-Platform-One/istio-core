# Istio Control Plan Ingress Configuration

## Default

Without changes to this template, the following ingress will be created:

- One ingress gateway
  - Name: `istio-ingressgateway`
  - Type: load balancer
  - Listening ports: 80 (HTTP), 443 (HTTPS), 15021 (Istio Status), and 15443 (Istio SNI)
- One gateway
  - Name: `main`
  - Ingress Gateway: `istio-ingressgateway`
  - Hosts: `*.{domain}`
  - HTTP redirect to HTTPS
  - TLS termination on HTTPS
  - No TLS certificate

At a minimum, a secret holding the wildcard TLS certificate for the domain needs to be provided for the default setup to function.  In addition, Virtual Services should be created for applications to create a complete ingress to an endpoint.

## Additional Ingress Gateways

To create additional ingress gateways (or replace the default), the following `values.yaml` configuration can be used.  Under the `k8s` section, any parameters listed in the [Istio Operator documentation](https://istio.io/latest/docs/reference/config/istio.operator.v1alpha1/#KubernetesResourcesSpec) can be added.

> To remove the default ingress gateway, set `istio-ingressgateway: null` in your `values.yaml`

```yaml
ingressGateways:
  # Complete example of an additional ingressgateway defined below
  private-ingressgateway:  # This becomes the name
    extraLabels: {} # Automatic labels: 'app: {ingress gateway name}'
    k8s: # Set any value from https://istio.io/latest/docs/reference/config/istio.operator.v1alpha1/#KubernetesResourcesSpec
      # hpaSpec:  By default, HPA is set from 1-5 instances with a target average utilization of 80%
      resources: {}
        # requests:
        #   cpu: 500m
        #   memory: 1Gi
        # limits:
        #   cpu: 1.5
        #   memory: 3Gi
      service:
        type: "LoadBalancer" # or "NodePort"
        # ports: By default ports 15021 (status), 80, 443, and 15443 (SNI Routing) are setup
      podAnnotations: {} # https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/
      serviceAnnotations: {} # https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/
      nodeSelector: {} # https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#nodeselector
      affinity: {} # https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity
      tolerations: [] # https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
```

## Additional Gateways

Additional gateways can be added to Istio by using the following configuration in your `values.yaml`.

- `selector` should be used to select which `IngressGateway` to use
- HTTP redirect is automatically included in every gateway
- The TLS credentials must be created separately in a secret and referenced in the `tls.credentialName` field
- Hosts should not overlap between Gateways unless the Ingress Gateways are completely isolated (e.g. different IPs or different Ports)

> To remove the default gateway, set `main: null` in your `values.yaml`

```yaml
# See https://istio.io/latest/docs/reference/config/networking/gateway/#Gateway for spec
gateways:
  private:
    selector:
      app: "private-istio-ingressgateway"
    servers:
    - hosts:
      - "mypackage.{{ .Values.domain }}"
      port:
        name: http2
        number: 8443
        protocol: HTTPS
      tls:
        credentialName: "some-secret"
        mode: "SIMPLE"
  ```

## Advanced Scenarios

While the above configurations will give you an additional gateway using basic HTTPS and default redirect on HTTP to force all traffic to HTTPS, there may be scenarios where you need more granular control over the ingress and gateway creation.  Below are two such examples of more advanced ingress and gateway configurations.

### Additional Ingress and Gateway for TCP Service

In this scenario we need an ingress and gateway that works for a specific TCP service (Twistlock in this example) as opposed to a standard HTTP/HTTPS configuration.

#### Ingress Gateway Configuration

```yaml
ingressGateways:
  twistlock-ingressgateway:
    type: "LoadBalancer"
    k8s:
      service:
        ports: # Manually specify all ports on the load balancer
          - name: tcp-health-status # This name needs to match in the gateway configuration
            port: 15021 # This is specifc to AWS load balancer health checks
            targetPort: 15021 
            nodePort: 30200 # Port that will be used on each Kubernetes node
          - name: tcp-twistlock-wss
            port: 8084 # Port that is listening on the actual load balancer
            targetPort: 8084 # Port that is listening on the gateway
            nodePort: 30201
```

#### Gateway Configuration

- Creating a port on the gateway for the health check on port 15021 is not necessary as it is only used as a health check

```yaml
gateways:
  twistlock:
    autoHttpRedirect:
      enabled: false # Explicity disable autoHttpRedirect as this configuration is not valid for a TCP gateway
    selector:
      app: "twistlock-ingressgateway"
    servers:
      - hosts:
        - "*" # Hosts should be wildcard for TCP gateways in order to function properly 
        port:
          name: tcp-twistlock-wss # name matching the name on the ingressGateway
          number: 8084 # port matching the targetPort from the ingressGateway
          protocol: TCP # protocol to be used
```

### Manually Configured Ingress and Gateway for HTTP and HTTPS Traffic

In this scenario we want full control of all aspects of the ingress gateway and gateway.  We will have an HTTP redirect to HTTPS that we manually configure as well as an additional port that will be HTTP only listening on port 8000.

#### Ingress Gateway Configuration

```yaml
ingressGateways:
  additional-ingressgateway:
    type: "LoadBalancer"
    k8s:
      service:
        ports:
          - name: tcp-health-status
            port: 15021 # AWS Load balancer health check port
            targetPort: 15021
            nodePort: 30300
          - name: http-redirect
            port: 80 # port listening on AWS load balancer
            targetPort: 8080 # port listening on gateway
            nodePort: 30301
          - name: https
            port: 443
            targetPort: 8443
            nodePort: 30302
          - name: http-custom
            port: 8000
            targetPort: 8000
            nodePort: 30303
```

#### Gateway Configuration

```yaml
gateways:
  additional:
    autoHttpRedirect:
      enabled: false # Explicitly disable autoHttpRedirect to give us more granular control over all settings
    selector:
      app: "additional-ingressgateway"
    servers:
      - hosts:
        - "anotherpackage.{{ .Values.domain }}"
        port:
          name: http-custom
          number: 8000 # this port is purely HTTP with no redirect to HTTPS
          protocol: HTTP
      - hosts:
        - "anotherpackage.{{ .Values.domain }}"
        port:
          name: http-redirect
          number: 8080
          protocol: HTTP
        tls:
          httpsRedirect: true # Manually specifying that this port should redirect all traffic to the HTTPS endpoint
      - hosts:
        - "anotherpackage.{{ .Values.domain }}"
        port:
          name: https
          number: 8443
          protocol: HTTPS
        tls:
          mode: PASSTHROUGH # Do not terminate TLS on the Istio gateway, pass it through instead
```