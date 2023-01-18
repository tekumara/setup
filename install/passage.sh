#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# install passage
tmpdir=$(mktemp -d)
git clone https://github.com/FiloSottile/passage.git "$tmpdir"
cd "$tmpdir"
make install PREFIX="$(brew --cellar)/passage/$(git describe --tags)" WITH_ZSHCOMP=yes
brew link passage

if [[ ! -e ~/.passage/identities ]]; then
    echo -e "Insert all yuibkeys and press any key to continue...\n"
    read -n1 -s -r

    tmpfile="$(mktemp -t "identities.XXXXXX")"
    age-plugin-yubikey -i > "$tmpfile"
    if [[ ! -s $tmpfile ]]; then
        echo -e ERROR: "No yubikey age identities, are your keys connected and configured?" >&2
        exit 42
    fi

    mv "$tmpfile" ~/.passage/identities

    echo -e "\nSaved to ~/.passage/identities"
fi
