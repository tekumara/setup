#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

do_install() {
    local url=$1
    local dest=$2
    local sha256=$3

    # check sha of any existing binary first, and skip if already installed
    # if the url is an archive, this will always fail and we'll download
    if ! [[ -f "$dest" ]] || ! echo "$sha256  $dest"  | shasum -s --check; then
        download=/tmp/$(basename "$url")
        echo "Downloading $url"
        curl -fsSLO --output-dir /tmp "$url"
        echo "$sha256  $download"  | shasum --check

        case "$download" in
            # if download is a tar archive, then assume $(basename "$dest") is the desired file within the archive
            *.tar.gz) tar -zxf "$download" -C /tmp && file=/tmp/$(basename "$dest") ;;
            *)        file=$download ;;
        esac

        echo "Installing $file -> $dest"
        install "$file" "$dest"
    fi
}

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

# install specific kubectl version, should be within +/- 1 version of the server
case "$(uname -sm)" in
    "Darwin arm64")  sha256=d518a7642874d7c6ca863b12bb2ce591840c1798b460f1f97b1eea7fbb41b9c9 && arch=darwin/arm64 ;;
    "Darwin x86_64") sha256=014d92af39ea8d3e57f01581c9ce44ea2b107c55d8cdeb838494014d034a6c17 && arch=darwin/amd64 ;;
    *) echo "error: unknown arch $(uname -sm)" && exit 42;;
esac

do_install "https://dl.k8s.io/release/v1.21.12/bin/$arch/kubectl" /usr/local/bin/kubectl $sha256

# install eks-iam-cache, saves 0.5 secs on each kubectl command
case "$(uname -sm)" in
    "Darwin arm64")  sha256=d794bc2970840390ababaa20abe258f4d1d8b55fa4323e03255c243cdc69f258 && arch=darwin_arm64 ;;
    "Darwin x86_64") sha256=f97402a8dc3f51b2073ba1d11f3f854caf4bde03035e88c1c242ca28312da589 && arch=darwin_amd64 ;;
    *) echo "error: unknown arch $(uname -sm)" && exit 42;;
esac

do_install url="https://github.com/sparebank1utvikling/eks-iam-cache/releases/download/v0.0.1/eks-iam-cache_0.0.1_$arch.tar.gz" \
    /usr/local/bin/eks-iam-cache $sha256
