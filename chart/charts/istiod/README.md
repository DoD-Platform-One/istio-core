<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# istiod

![Version: 1.25.1-bb.1](https://img.shields.io/badge/Version-1.25.1--bb.1-informational?style=flat-square) ![AppVersion: 1.25.1](https://img.shields.io/badge/AppVersion-1.25.1-informational?style=flat-square) ![Maintenance Track: unknown](https://img.shields.io/badge/Maintenance_Track-unknown-red?style=flat-square)

Helm chart for istio control plane

## Upstream References

- <https://github.com/istio/istio>

## Upstream Release Notes

- [Find our upstream chart's CHANGELOG here](https://istio.io/latest/news/releases/1.25.x/announcing-1.25)

## Learn More

- [Application Overview](docs/overview.md)
- [Other Documentation](docs/)

## Pre-Requisites

- Kubernetes Cluster deployed
- Kubernetes config installed in `~/.kube/config`
- Helm installed

Install Helm

https://helm.sh/docs/intro/install/

## Deployment

- Clone down the repository
- cd into directory

```bash
helm install istiod chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| _internal_defaults_do_not_set.autoscaleEnabled | bool | `true` |  |
| _internal_defaults_do_not_set.autoscaleMin | int | `1` |  |
| _internal_defaults_do_not_set.autoscaleMax | int | `5` |  |
| _internal_defaults_do_not_set.autoscaleBehavior | object | `{}` |  |
| _internal_defaults_do_not_set.replicaCount | int | `1` |  |
| _internal_defaults_do_not_set.rollingMaxSurge | string | `"100%"` |  |
| _internal_defaults_do_not_set.rollingMaxUnavailable | string | `"25%"` |  |
| _internal_defaults_do_not_set.hub | string | `""` |  |
| _internal_defaults_do_not_set.tag | string | `""` |  |
| _internal_defaults_do_not_set.variant | string | `""` |  |
| _internal_defaults_do_not_set.image | string | `"pilot"` |  |
| _internal_defaults_do_not_set.traceSampling | float | `1` |  |
| _internal_defaults_do_not_set.resources.requests.cpu | string | `"500m"` |  |
| _internal_defaults_do_not_set.resources.requests.memory | string | `"2048Mi"` |  |
| _internal_defaults_do_not_set.seccompProfile | object | `{}` |  |
| _internal_defaults_do_not_set.cni.enabled | bool | `false` |  |
| _internal_defaults_do_not_set.cni.provider | string | `"default"` |  |
| _internal_defaults_do_not_set.extraContainerArgs | list | `[]` |  |
| _internal_defaults_do_not_set.env | object | `{}` |  |
| _internal_defaults_do_not_set.taint.enabled | bool | `false` |  |
| _internal_defaults_do_not_set.taint.namespace | string | `""` |  |
| _internal_defaults_do_not_set.affinity | object | `{}` |  |
| _internal_defaults_do_not_set.tolerations | list | `[]` |  |
| _internal_defaults_do_not_set.cpu.targetAverageUtilization | int | `80` |  |
| _internal_defaults_do_not_set.memory | object | `{}` |  |
| _internal_defaults_do_not_set.volumeMounts | list | `[]` |  |
| _internal_defaults_do_not_set.volumes | list | `[]` |  |
| _internal_defaults_do_not_set.initContainers | list | `[]` |  |
| _internal_defaults_do_not_set.nodeSelector | object | `{}` |  |
| _internal_defaults_do_not_set.podAnnotations | object | `{}` |  |
| _internal_defaults_do_not_set.serviceAnnotations | object | `{}` |  |
| _internal_defaults_do_not_set.serviceAccountAnnotations | object | `{}` |  |
| _internal_defaults_do_not_set.sidecarInjectorWebhookAnnotations | object | `{}` |  |
| _internal_defaults_do_not_set.topologySpreadConstraints | list | `[]` |  |
| _internal_defaults_do_not_set.jwksResolverExtraRootCA | string | `""` |  |
| _internal_defaults_do_not_set.keepaliveMaxServerConnectionAge | string | `"30m"` |  |
| _internal_defaults_do_not_set.deploymentLabels | object | `{}` |  |
| _internal_defaults_do_not_set.configMap | bool | `true` |  |
| _internal_defaults_do_not_set.podLabels | object | `{}` |  |
| _internal_defaults_do_not_set.ipFamilyPolicy | string | `""` |  |
| _internal_defaults_do_not_set.ipFamilies | list | `[]` |  |
| _internal_defaults_do_not_set.trustedZtunnelNamespace | string | `""` |  |
| _internal_defaults_do_not_set.sidecarInjectorWebhook.neverInjectSelector | list | `[]` |  |
| _internal_defaults_do_not_set.sidecarInjectorWebhook.alwaysInjectSelector | list | `[]` |  |
| _internal_defaults_do_not_set.sidecarInjectorWebhook.injectedAnnotations | object | `{}` |  |
| _internal_defaults_do_not_set.sidecarInjectorWebhook.enableNamespacesByDefault | bool | `false` |  |
| _internal_defaults_do_not_set.sidecarInjectorWebhook.reinvocationPolicy | string | `"Never"` |  |
| _internal_defaults_do_not_set.sidecarInjectorWebhook.rewriteAppHTTPProbe | bool | `true` |  |
| _internal_defaults_do_not_set.sidecarInjectorWebhook.templates | object | `{}` |  |
| _internal_defaults_do_not_set.sidecarInjectorWebhook.defaultTemplates | list | `[]` |  |
| _internal_defaults_do_not_set.istiodRemote.enabled | bool | `false` |  |
| _internal_defaults_do_not_set.istiodRemote.injectionURL | string | `""` |  |
| _internal_defaults_do_not_set.istiodRemote.injectionPath | string | `"/inject"` |  |
| _internal_defaults_do_not_set.istiodRemote.injectionCABundle | string | `""` |  |
| _internal_defaults_do_not_set.telemetry.enabled | bool | `true` |  |
| _internal_defaults_do_not_set.telemetry.v2.enabled | bool | `true` |  |
| _internal_defaults_do_not_set.telemetry.v2.prometheus.enabled | bool | `true` |  |
| _internal_defaults_do_not_set.telemetry.v2.stackdriver.enabled | bool | `false` |  |
| _internal_defaults_do_not_set.revision | string | `""` |  |
| _internal_defaults_do_not_set.revisionTags | list | `[]` |  |
| _internal_defaults_do_not_set.ownerName | string | `""` |  |
| _internal_defaults_do_not_set.meshConfig.enablePrometheusMerge | bool | `true` |  |
| _internal_defaults_do_not_set.meshConfig.accessLogFile | string | `"/dev/stdout"` |  |
| _internal_defaults_do_not_set.meshConfig.meshMTLS.minProtocolVersion | string | `"TLSV1_2"` |  |
| _internal_defaults_do_not_set.experimental.stableValidationPolicy | bool | `false` |  |
| _internal_defaults_do_not_set.global.istioNamespace | string | `"istio-system"` |  |
| _internal_defaults_do_not_set.global.certSigners | list | `[]` |  |
| _internal_defaults_do_not_set.global.defaultPodDisruptionBudget.enabled | bool | `true` |  |
| _internal_defaults_do_not_set.global.defaultResources.requests.cpu | string | `"10m"` |  |
| _internal_defaults_do_not_set.global.hub | string | `"registry1.dso.mil/ironbank/opensource/istio"` |  |
| _internal_defaults_do_not_set.global.tag | string | `"1.25.1"` |  |
| _internal_defaults_do_not_set.global.variant | string | `""` |  |
| _internal_defaults_do_not_set.global.imagePullPolicy | string | `""` |  |
| _internal_defaults_do_not_set.global.imagePullSecrets[0] | string | `"private-registry"` |  |
| _internal_defaults_do_not_set.global.istiod.enableAnalysis | bool | `false` |  |
| _internal_defaults_do_not_set.global.logAsJson | bool | `false` |  |
| _internal_defaults_do_not_set.global.logging.level | string | `"default:info"` |  |
| _internal_defaults_do_not_set.global.omitSidecarInjectorConfigMap | bool | `false` |  |
| _internal_defaults_do_not_set.global.operatorManageWebhooks | bool | `false` |  |
| _internal_defaults_do_not_set.global.priorityClassName | string | `""` |  |
| _internal_defaults_do_not_set.global.proxy.image | string | `"proxyv2"` |  |
| _internal_defaults_do_not_set.global.proxy.autoInject | string | `"enabled"` |  |
| _internal_defaults_do_not_set.global.proxy.clusterDomain | string | `"cluster.local"` |  |
| _internal_defaults_do_not_set.global.proxy.componentLogLevel | string | `"misc:error"` |  |
| _internal_defaults_do_not_set.global.proxy.excludeInboundPorts | string | `""` |  |
| _internal_defaults_do_not_set.global.proxy.includeInboundPorts | string | `"*"` |  |
| _internal_defaults_do_not_set.global.proxy.includeIPRanges | string | `"*"` |  |
| _internal_defaults_do_not_set.global.proxy.excludeIPRanges | string | `""` |  |
| _internal_defaults_do_not_set.global.proxy.includeOutboundPorts | string | `""` |  |
| _internal_defaults_do_not_set.global.proxy.excludeOutboundPorts | string | `""` |  |
| _internal_defaults_do_not_set.global.proxy.logLevel | string | `"warning"` |  |
| _internal_defaults_do_not_set.global.proxy.outlierLogPath | string | `""` |  |
| _internal_defaults_do_not_set.global.proxy.privileged | bool | `false` |  |
| _internal_defaults_do_not_set.global.proxy.readinessFailureThreshold | int | `4` |  |
| _internal_defaults_do_not_set.global.proxy.readinessInitialDelaySeconds | int | `0` |  |
| _internal_defaults_do_not_set.global.proxy.readinessPeriodSeconds | int | `15` |  |
| _internal_defaults_do_not_set.global.proxy.startupProbe.enabled | bool | `true` |  |
| _internal_defaults_do_not_set.global.proxy.startupProbe.failureThreshold | int | `600` |  |
| _internal_defaults_do_not_set.global.proxy.resources.requests.cpu | string | `"100m"` |  |
| _internal_defaults_do_not_set.global.proxy.resources.requests.memory | string | `"128Mi"` |  |
| _internal_defaults_do_not_set.global.proxy.resources.limits.cpu | string | `"2000m"` |  |
| _internal_defaults_do_not_set.global.proxy.resources.limits.memory | string | `"1024Mi"` |  |
| _internal_defaults_do_not_set.global.proxy.statusPort | int | `15020` |  |
| _internal_defaults_do_not_set.global.proxy.tracer | string | `"none"` |  |
| _internal_defaults_do_not_set.global.proxy_init.image | string | `"proxyv2"` |  |
| _internal_defaults_do_not_set.global.proxy_init.forceApplyIptables | bool | `false` |  |
| _internal_defaults_do_not_set.global.remotePilotAddress | string | `""` |  |
| _internal_defaults_do_not_set.global.caAddress | string | `""` |  |
| _internal_defaults_do_not_set.global.externalIstiod | bool | `false` |  |
| _internal_defaults_do_not_set.global.configCluster | bool | `false` |  |
| _internal_defaults_do_not_set.global.configValidation | bool | `true` |  |
| _internal_defaults_do_not_set.global.meshID | string | `""` |  |
| _internal_defaults_do_not_set.global.meshNetworks | object | `{}` |  |
| _internal_defaults_do_not_set.global.mountMtlsCerts | bool | `false` |  |
| _internal_defaults_do_not_set.global.multiCluster.enabled | bool | `false` |  |
| _internal_defaults_do_not_set.global.multiCluster.clusterName | string | `""` |  |
| _internal_defaults_do_not_set.global.network | string | `""` |  |
| _internal_defaults_do_not_set.global.pilotCertProvider | string | `"istiod"` |  |
| _internal_defaults_do_not_set.global.sds.token.aud | string | `"istio-ca"` |  |
| _internal_defaults_do_not_set.global.sts.servicePort | int | `0` |  |
| _internal_defaults_do_not_set.global.caName | string | `""` |  |
| _internal_defaults_do_not_set.global.waypoint.resources.requests.cpu | string | `"100m"` |  |
| _internal_defaults_do_not_set.global.waypoint.resources.requests.memory | string | `"128Mi"` |  |
| _internal_defaults_do_not_set.global.waypoint.resources.limits.cpu | string | `"2"` |  |
| _internal_defaults_do_not_set.global.waypoint.resources.limits.memory | string | `"1Gi"` |  |
| _internal_defaults_do_not_set.global.waypoint.affinity | object | `{}` |  |
| _internal_defaults_do_not_set.global.waypoint.topologySpreadConstraints | list | `[]` |  |
| _internal_defaults_do_not_set.global.waypoint.nodeSelector | object | `{}` |  |
| _internal_defaults_do_not_set.global.waypoint.tolerations | list | `[]` |  |
| _internal_defaults_do_not_set.base.enableIstioConfigCRDs | bool | `true` |  |
| _internal_defaults_do_not_set.gateways.securityContext | object | `{}` |  |
| _internal_defaults_do_not_set.gateways.seccompProfile | object | `{}` |  |
| mtls.mode | string | `"STRICT"` |  |
| networkPolicies.enabled | bool | `false` |  |
| networkPolicies.additionalPolicies | list | `[]` |  |
| monitoring.enabled | bool | `false` |  |
| pilot.env.ENABLE_NATIVE_SIDECARS | string | `"true"` |  |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

