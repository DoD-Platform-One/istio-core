# Node Affinity & Anti-Affinity with Istio ControlPlane

Affinity is exposed through values options for this package. If you want to schedule your pods to deploy on specific nodes you can do that through the `nodeSelector` value and as needed the `affinity` value. Additional info is provided below as well to help in configuring this.

It is good to have a basic knowledge of node affinity and available options to you before customizing in this way - the upstream kubernetes documentation [has a good walkthrough of this](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity).

## Values for NodeSelector

The `nodeSelector` value can be set at the `istiod` and `ingressGateway` levels to do basic node selection for deployments. See the below example for an example to schedule pods to only nodes with the label `node-type` equal to `istio`:

```yaml
istiod:
  nodeSelector:
    node-type: istio
ingressGateway:
  nodeSelector:
    node-type: istio
# If using CNI / on Openshift you can also customize those values
cni:
  nodeSelector:
    node-type: istio
```

## Values for Affinity

The `affinity` value at the same levels should be used to specify affinity. The format to include follows what you'd specify at a pod/deployment level. See the example below for scheduling the operator pods only to nodes with the label `node-type` equal to `istio`:

```yaml
istiod:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: node-type
            operator: In
            values:
            - istio
ingressGateway:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: node-type
            operator: In
            values:
            - istio
# If using CNI / on Openshift you can also customize those values
cni:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: node-type
            operator: In
            values:
            - istio
```

## Values for Anti-Affinity

The `affinity` value at the same levels can be set in the same way to schedule pods based on anti-affinity. See the below example to schedule pods to not be present on the nodes that already have pods with the `dont-schedule-with: istio` label:

```yaml
istiod:
  affinity:
    podAntiAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        - topologyKey: "kubernetes.io/hostname"
          labelSelector:
            matchLabels:
              dont-schedule-with: istio
ingressGateway:
  affinity:
    podAntiAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        - topologyKey: "kubernetes.io/hostname"
          labelSelector:
            matchLabels:
              dont-schedule-with: istio
# If using CNI / on Openshift you can also customize those values
cni:
  affinity:
    podAntiAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        - topologyKey: "kubernetes.io/hostname"
          labelSelector:
            matchLabels:
              dont-schedule-with: istio
```
