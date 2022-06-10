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

# remove versions installed prior
if [[ -f /usr/local/bin/kubectl && "$(stat -f '%u' /usr/local/bin/kubectl)" == "0" ]]; then
    # installed as root by Docker so use sudo to remove
    set -x
    sudo rm -f /usr/local/bin/kubectl
    set +x
else
    # installed as current user by brew or doesn't exist
    rm -f /usr/local/bin/kubectl
fi

# specific kubectl version, should be within +/- 1 version of the server
v=v1.21.12

if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
    # Apple Silicon (M1 Mac)
    curl -fsSLo /usr/local/bin/kubectl "https://dl.k8s.io/release/$v/bin/darwin/arm64/kubectl"
    echo "d518a7642874d7c6ca863b12bb2ce591840c1798b460f1f97b1eea7fbb41b9c9  /usr/local/bin/kubectl"  | shasum --check
else
    curl -fsSLo /usr/local/bin/kubectl "https://dl.k8s.io/release/$v/bin/darwin/amd64/kubectl"
    echo "014d92af39ea8d3e57f01581c9ce44ea2b107c55d8cdeb838494014d034a6c17  /usr/local/bin/kubectl"  | shasum --check
fi
chmod a+x /usr/local/bin/kubectl
