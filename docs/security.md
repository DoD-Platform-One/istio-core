# Istio Security 

One of the main features of Istio is its baked in security features which applications are able to utilize without any additional instrumentation. This enables application developers to focus more on application features and offload security to Istio.  

Security implementation is made possible using the envoy sidecar proxy and the implemenation is done both at the edge of the mesh ( using the ingress gateway), or at the service layer within the cluster. 

# Authentication 

Istio has two main types of authentication it implements. 
* [Peer authentication](https://istio.io/latest/docs/concepts/security/#peer-authentication) which applies to workloads (services)  and manages MTLS settings.
  

* [Request authentication](https://istio.io/latest/docs/concepts/security/#request-authentication) which applies to JWTs. 

To get more information on how to configure them , refer to this [link](https://istio.io/latest/docs/tasks/security/authentication/authn-policy/).

# Authorization 
 Istio is able to provide various levels of access control within the mesh. The levels include mesh wide , namespace wide and a more targeted workload policy. It is able to do this using an [Authorization Policy](https://istio.io/latest/docs/reference/config/security/authorization-policy/). 

 More information on features and configuration of authorization policies is located [here](https://istio.io/latest/docs/tasks/security/authorization/). 


# Additional resources

The following are additional resources for learning about istio security. 

* [Improving security with Istio](https://www.youtube.com/watch?v=E0h1rS2D86k)
* [Istio Auto mTLS and JWT](https://www.youtube.com/watch?v=7_O58efytvM&t=422s)
