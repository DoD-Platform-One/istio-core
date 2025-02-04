<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# istio3

![Version: 1.23.3-bb.2](https://img.shields.io/badge/Version-1.23.3--bb.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.23.3](https://img.shields.io/badge/AppVersion-1.23.3-informational?style=flat-square) ![Maintenance Track: bb_integrated](https://img.shields.io/badge/Maintenance_Track-bb_integrated-green?style=flat-square)

Helm umbrella chart for istio

## Upstream Release Notes

This package has no upstream release note links on file. Please add some to [chart/Chart.yaml](chart/Chart.yaml) under `annotations.bigbang.dev/upstreamReleaseNotesMarkdown`.
Example:
```yaml
annotations:
  bigbang.dev/upstreamReleaseNotesMarkdown: |
    - [Find our upstream chart's CHANGELOG here](https://link-goes-here/CHANGELOG.md)
    - [and our upstream application release notes here](https://another-link-here/RELEASE_NOTES.md)
```

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
helm install istio3 chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.variant | string | `""` |  |
| global.tag | string | `"1.23.3"` |  |
| global.hub | string | `"registry1.dso.mil/ironbank/opensource/istio"` |  |
| global.imagePullSecrets[0] | string | `"private-registry"` |  |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

