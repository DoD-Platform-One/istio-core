<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# base

![Version: 1.25.1-bb.1](https://img.shields.io/badge/Version-1.25.1--bb.1-informational?style=flat-square) ![AppVersion: 1.25.1](https://img.shields.io/badge/AppVersion-1.25.1-informational?style=flat-square) ![Maintenance Track: unknown](https://img.shields.io/badge/Maintenance_Track-unknown-red?style=flat-square)

Helm chart for deploying Istio cluster resources and CRDs

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
helm install base chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| _internal_defaults_do_not_set.global.imagePullSecrets | list | `[]` |  |
| _internal_defaults_do_not_set.global.istioNamespace | string | `"istio-system"` |  |
| _internal_defaults_do_not_set.global.defaultSecurityHeaders.enabled | bool | `true` |  |
| _internal_defaults_do_not_set.base.excludedCRDs | list | `[]` |  |
| _internal_defaults_do_not_set.base.enableCRDTemplates | bool | `true` |  |
| _internal_defaults_do_not_set.base.validationURL | string | `""` |  |
| _internal_defaults_do_not_set.base.validationCABundle | string | `""` |  |
| _internal_defaults_do_not_set.base.enableIstioConfigCRDs | bool | `true` |  |
| _internal_defaults_do_not_set.defaultRevision | string | `"default"` |  |
| _internal_defaults_do_not_set.experimental.stableValidationPolicy | bool | `false` |  |
| _internal_defaults_do_not_set.envoyFilters | list | `[]` | Custom EnvoyFilters. https://istio.io/latest/docs/reference/config/networking/envoy-filter/ |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

