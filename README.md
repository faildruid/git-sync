# gitsync Helm Chart

[![Helm CI](https://github.com/faildruid/git-sync/actions/workflows/helm-ci.yaml/badge.svg)](https://github.com/faildruid/git-sync/actions/workflows/helm-ci.yaml)

This chart deploys a Kubernetes CronJob that runs a small `gitsync` container every 12 hours.
It mounts:

- SSH private keys from a Secret as files
- A directories list from a ConfigMap as a file
- Non-secret env vars from `values.yaml`
- Secret env vars (e.g., `GITHUB_TOKEN`) from a Kubernetes Secret

## Requirements

- Helm 3
- [helm-unittest](https://github.com/quintush/helm-unittest) plugin for unit tests

Install plugin:

```bash
helm plugin install https://github.com/quintush/helm-unittest.git
```

## Usage

Install / upgrade the chart:

```bash
helm upgrade --install gitsync .
```

To load private keys and GitHub token from local files and environment:

```bash
helm upgrade --install gitsync . \
  --set-file sshKeys.toolsKey=/path/to/id_rsa_tools \
  --set-file sshKeys.wdfKey=/path/to/id_rsa_wdf \
  --set secretEnv.vars.GITHUB_TOKEN="$GITHUB_TOKEN"
```

## Makefile targets

- `make lint` – run `helm lint`
- `make test` – run `helm unittest`
- `make template` – render manifests
- `make package` – create a packaged chart in `dist/`

## GitHub Actions CI

A sample workflow is provided at `.github/workflows/helm-ci.yaml` which:

1. Checks out the repo
2. Installs Helm
3. Installs `helm-unittest`
4. Runs `helm lint` and `helm unittest`
