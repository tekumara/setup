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

        if [[ -d $file ]]; then
            # handle case when archive extracts into a directory
            file="$file"/$(basename "$file")
        fi

        echo "Installing $file -> $dest"
        install "$file" "$dest"
    fi
}

# install age-plugin-yubikey
case "$(uname -sm)" in
    "Darwin arm64")  sha256=dfbfbe2d4e2113fc9995d2488244cfa169228749 && arch=arm64-darwin ;;
    "Darwin x86_64") sha256=9fb593158c38f8d51cdaf799a74916be8f1fc5e2 && arch=x86_64-darwin ;;
    *) echo "error: unknown arch $(uname -sm)" && exit 42;;
esac

do_install "https://github.com/str4d/age-plugin-yubikey/releases/download/v0.3.2/age-plugin-yubikey-v0.3.2-$arch.tar.gz" \
    /usr/local/bin/age-plugin-yubikey "$sha256"

# install passage
if ! hash passage 2> /dev/null; then
    tmpdir=$(mktemp -d)
    git clone git@github.com:FiloSottile/passage.git "$tmpdir"
    cd "$tmpdir"
    make install PREFIX="$(brew --cellar)/passage/$(git describe --tags)"
    brew link passage
fi
