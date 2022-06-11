#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# make sure the current user owns /usr/local/bin so kubectl can be installed there
# homebrew already does chown /usr/local/bin on Intel Macs but not on ARM
if [[ "$(stat -f '%u' /usr/local/bin)" != "$(id -u)" ]]; then
    set -x
    sudo chown "$(whoami)" /usr/local/bin
    set +x
fi

if [[ -f /usr/local/bin/kubectl && "$(stat -f '%u' /usr/local/bin/kubectl)" == "0" ]]; then
    # previously installed as root by the docker cask so chown
    set -x
    sudo chown "$(whoami)" /usr/local/bin/kubectl
    set +x
fi

# specific kubectl version, should be within +/- 1 version of the server
v=v1.21.12

if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
    # Apple Silicon (M1 Mac)
    sha256=d518a7642874d7c6ca863b12bb2ce591840c1798b460f1f97b1eea7fbb41b9c9
    url="https://dl.k8s.io/release/$v/bin/darwin/arm64/kubectl"

else
    sha256=014d92af39ea8d3e57f01581c9ce44ea2b107c55d8cdeb838494014d034a6c17
    url="https://dl.k8s.io/release/$v/bin/darwin/amd64/kubectl"
fi

# check any existing binary first, so we can skip if the desired version is already installed
if ! [[ -f /usr/local/bin/kubectl ]] || ! echo "$sha256  /usr/local/bin/kubectl"  | shasum -s --check; then
    set -x
    # remove any existing version installed by brew (as a dependency of kubectx) or docker
    # NB: don't unlink because we want the man pages installed by brew
    rm -f /usr/local/bin/kubectl
    curl -fsSLo /usr/local/bin/kubectl $url
    echo "$sha256  /usr/local/bin/kubectl"  | shasum --check
    chmod a+x /usr/local/bin/kubectl
    set +x
fi
