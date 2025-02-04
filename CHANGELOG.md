# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---
## [1.23.3-bb.2] - 2024-02-04

### Added

- Added required network policies per https://istio.io/latest/docs/ops/deployment/application-requirements/
- Updated values.yaml to support network policies and additional network policies (user-supplied)
- Updated dev maintenance documentation

## [1.23.3-bb.1] - 2024-12-31

### Changetype (<https://keepachangelog.com/en/1.0.0/#how>)

- Added missing meshConfig section to ensure logs are output to console
- Added missing peerAuthentication and associated section in values.yaml so mutual TLS will work

## [1.23.3-bb.0] - 2024-12-23

### Changetype (<https://keepachangelog.com/en/1.0.0/#how>)

- Updated Istiod and Base charts to 1.23.3


## [1.23.2-bb.0] - 2024-10-28

### Changetype (<https://keepachangelog.com/en/1.0.0/#how>)

- Initialized repo with charts istio-base and istiod
- Generated README.md
