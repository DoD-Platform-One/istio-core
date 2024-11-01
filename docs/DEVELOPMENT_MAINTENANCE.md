# How to upgrade the Istio ControlPlane Package chart

1. Checkout the branch that renovate created. This branch will have the image tag updates and typically some other necessary version changes that you will want. You can either work off of this branch or branch off of it.
1. Update via `kpt`:
    ```bash
    # update to VERSION of the upstream charts auto-merging in changes
    kpt pkg update base@1.23.2 --strategy alpha-git-patch
    kpt pkg update istiod@1.23.2 --strategy alpha-git-patch
    ```
    Or if you'd like to pull down upstream to a fresh `DIR` and manually merge in the changes yourself:
    ```bash
    # get a fresh VERSION of the upstream chart to DIR
    VERSION=1.23.2
    DIR=./fresh
    kpt pkg get "https://github.com/istio/istio.git/manifests/charts/base@$VERSION" "$DIR/base"
    kpt pkg get "https://github.com/istio/istio.git/manifests/charts/istio-control/istio-discovery@$VERSION" "$DIR/istiod"
    ```
1. Update version references for the Chart. `version` should be `<version>-bb.0` (ex: `1.14.3-bb.0`) and `appVersion` should be `<version>` (ex: `1.14.3`). Also validate that the BB annotation for the main Istio version is updated (leave the Tetrate version as-is unless you are updating those images).
1. Verify that chart/values.yaml `tag` and `tidTAG` have been updated to the new version.
1. Add a changelog entry for the update. At minimum mention updating the image versions.
1. Update the readme following the [steps in Gluon](https://repo1.dso.mil/platform-one/big-bang/apps/library-charts/gluon/-/blob/master/docs/bb-package-readme.md).
1. Open MR (or check the one that Renovate created for you) and validate that the pipeline is successful. Also follow the testing steps below for some manual confirmations.

# Testing new Istio ControlPlane version

Generally the controlplane update should be tested alongside the new operator version. Follow the steps below for testing both. You should perform these steps on both a clean install and an upgrade from BB master.

## Branch/Tag Config

If you'd like to install from a specific branch or tag, then the code block under istio needs to be uncommented and used to target your changes.

For example, this would target the `renovate/ironbank` branch.

```
istio:
  <other config/labels>
  ...
  ...

  # Add git branch or tag information to test against a specific branch or tag instead of using `main`
  # Must set the unused label to null
  git:
    tag: null
    branch: "renovate/ironbank"
```

The istioOperator also needs to be updated.

```
istioOperator:
  <other config/labels>
  ...
  ...

  # Add git branch or tag information to test against a specific branch or tag instead of using `main`
  # Must set the unused label to null
  git:
    tag: null
    branch: "renovate/ironbank"
```

## Cluster setup

⚠️ Always make sure your local bigbang repo is current before deploying.

1. Export your Ironbank/Harbor credentials (this can be done in your `~/.bashrc` or `~/.zshrc` file if desired). These specific variables are expected by the `k3d-dev.sh` script when deploying metallb, and are referenced in other commands for consistency:
    ```
    export REGISTRY_USERNAME='<your_username>'
    export REGISTRY_PASSWORD='<your_password>'
    ```
1. Export the path to your local bigbang repo (without a trailing `/`):

  	⚠️ Note that wrapping your file path in quotes when exporting will break expansion of `~`.
    ```
    export BIGBANG_REPO_DIR=<absolute_path_to_local_bigbang_repo>
    ```
    e.g.
    ```
    export BIGBANG_REPO_DIR=~/repos/bigbang
    ```
1. Run the [k3d_dev.sh](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/docs/assets/scripts/developer/k3d-dev.sh) script to deploy a dev cluster (`-a` flag required if deploying a local Keycloak):

    For `login.dso.mil` Keycloak:

    ```
    "${BIGBANG_REPO_DIR}/docs/assets/scripts/developer/k3d-dev.sh"
    ```

    For local `keycloak.dev.bigbang.mil` Keycloak (`-a` deploys instance with a second public IP and metallb):

    ```
    "${BIGBANG_REPO_DIR}/docs/assets/scripts/developer/k3d-dev.sh -a"
    ```
1. Export your kubeconfig:

    ```
    export KUBECONFIG=~/.kube/<your_kubeconfig_file>
    ```
    e.g.
    ```
    export KUBECONFIG=~/.kube/Sam.Sarnowski-dev-config
    ```
1. [Deploy flux to your cluster](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/scripts/install_flux.sh):
    ```
    "${BIGBANG_REPO_DIR}/scripts/install_flux.sh -u ${REGISTRY_USERNAME} -p ${REGISTRY_PASSWORD}"
    ```

## Deploy Bigbang
From the root of this repo, run one of the following deploy commands depending on which Keycloak you wish to reference:

For `login.dso.mil` Keycloak:
  ```
  helm upgrade -i bigbang ${BIGBANG_REPO_DIR}/chart/ -n bigbang --create-namespace \
  --set registryCredentials.username=${REGISTRY_USERNAME} --set registryCredentials.password=${REGISTRY_PASSWORD} \
  -f https://repo1.dso.mil/big-bang/bigbang/-/raw/master/tests/test-values.yaml \
  -f https://repo1.dso.mil/big-bang/bigbang/-/raw/master/chart/ingress-certs.yaml \
  -f https://repo1.dso.mil/big-bang/bigbang/-/raw/master/docs/assets/configs/example/dev-sso-values.yaml \
  -f docs/dev-overrides/minimal.yaml \
  -f docs/dev-overrides/istio-testing.yaml
  ```

For local `keycloak.dev.bigbang.mil` Keycloak:
  ```
  helm upgrade -i bigbang ${BIGBANG_REPO_DIR}/chart/ -n bigbang --create-namespace \
  --set registryCredentials.username=${REGISTRY_USERNAME} --set registryCredentials.password=${REGISTRY_PASSWORD} \
  -f https://repo1.dso.mil/big-bang/bigbang/-/raw/master/tests/test-values.yaml \
  -f https://repo1.dso.mil/big-bang/bigbang/-/raw/master/chart/ingress-certs.yaml \
  -f docs/dev-overrides/minimal.yaml \
  -f docs/dev-overrides/istio-testing-local-keycloak.yaml
  ```

This will deploy the following apps for testing:

- Istio, Istio operator and Authservice
- Jaeger, Kiali and Monitoring (including Grafana), all with SSO enabled
- Optionally Keycloak

## Validation/Testing Steps

⚠️ For testing with a local Keycloak instance, you will need to manually register or create an account as an admin before proceeding with the below tests. For more info please reference the Keycloak [DEVELOPMENT_MAINTENANCE.md](https://repo1.dso.mil/big-bang/product/packages/keycloak/-/blob/main/docs/DEVELOPMENT_MAINTENANCE.md).

1. Navigate to Jaeger (https://tracing.dev.bigbang.mil/) and validate you are prompted to login with SSO and that the login is successful. This verifies that Authservice is working as an Istio extension.
1. Navigate to Prometheus (also uses Authservice) and validate that the Istio targets are up (under Status -> Targets). There should be targets for [istio-envoy](https://prometheus.dev.bigbang.mil/targets?search=&scrapePool=podMonitor%2Fmonitoring%2Fmonitoring-monitoring-kube-istio-envoy%2F0), [istio-operator](https://prometheus.dev.bigbang.mil/targets?search=&scrapePool=serviceMonitor%2Fmonitoring%2Fmonitoring-monitoring-kube-istio-operator%2F0) and [istio-pilot](https://prometheus.dev.bigbang.mil/targets?search=&scrapePool=serviceMonitor%2Fmonitoring%2Fmonitoring-monitoring-kube-istio-pilot%2F0).
1. Navigate to Grafana (https://grafana.dev.bigbang.mil/) and validate that the Istio dashboards are present and show some data. You may need to alter filters to pick a workload that has information showing.
1. Since Kiali (https://kiali.dev.bigbang.mil/) interfaces with Istio for most of its information it is a good idea to validate its functionality. To do this, perform the test steps [here](https://repo1.dso.mil/big-bang/product/packages/kiali/-/blob/main/docs/DEVELOPMENT_MAINTENANCE.md?ref_type=heads#manual-testing-steps).
1. Once you've confirmed that the package tests above pass, also test your branches against Big Bang per the steps in [this document](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/docs/developer/test-package-against-bb.md).

## Files That Require Integration Testing

Some things aren't tested by the package pipeline, but are tested by the BigBang pipeline. These need to be tested independently if updated:

- Ingress Gateways
  - Passthrough Ingress Gateway specifically is already in BigBang, but not in the package pipeline.
- Egress Gateways
- ./chart/templates/bigbang/istio/authorizationPolicies/allow-ingress-authz-policy.yaml
- ./chart/templates/bigbang/istio/authorizationPolicies/allow-nothing-policy.yaml
- ./chart/templates/bigbang/istio/authorizationPolicies/template.yaml
- ./chart/templates/bigbang/peerAuthentication.yaml

### Istio Operator

- ./chart/templates/bigbang/istio-operator-rolebinding-openshift-scc.yaml
- ./chart/templates/bigbang/networkpolicies/additional-networkpolicies.yaml
- ./chart/templates/bigbang/networkpolicies/default-deny.yaml
- ./chart/templates/bigbang/networkpolicies/egress-kube-api.yaml
- ./chart/templates/bigbang/networkpolicies/ingress-scraping.yaml
- ./chart/templates/bigbang/openshift-cr-crb-istio-operator.yaml

## Instructions for Integration Testing

See the [Big Bang Doc](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/docs/developer/test-package-against-bb.md?ref_type=heads)
