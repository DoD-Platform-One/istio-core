Istio traffic management revolves around handling north-south traffic ( traffic in and out of the mesh ) and east-west traffic ( traffic between services the mesh ).   Istio is able to auto detect  services endpoints in a cluster and in turn , populates a service registry. 

The following API resources enable the configuration and adoption of Istio’s traffic management

* [Virtual services](https://istio.io/latest/docs/reference/config/networking/virtual-service/) which provide routing configuration to services within the mesh. 
* [Destination rules](https://istio.io/latest/docs/reference/config/networking/destination-rule/)  which allow you to provide routing to a subset of services and are paired with virtualservices. 
* [Gateways](https://istio.io/latest/docs/reference/config/networking/gateway/) which are used to manage traffic entering or leaving the service mesh.
* [Service Entry](https://istio.io/latest/docs/reference/config/networking/service-entry/) which is used to  add  entries into the internal service registry.

Istio also has some advanced traffic management strategies like circuit breaking , mirroring and fault injection.  Examples and walkthroughs can be found [here](https://istio.io/latest/docs/tasks/traffic-management/).

# Additional resources 

The following  additional resources are helpful in understanding traffic management:

* [Istio in production - Traffic routing](https://www.youtube.com/watch?v=7cINRP0BFY8)
* [Istio traffic routing and resiliency ](https://www.youtube.com/watch?v=iLslUy2kTlw)
* [Istio ingress gateway](https://www.youtube.com/watch?v=ssqDgcEvdZ0&t=8s)
