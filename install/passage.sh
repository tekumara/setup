#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# install passage
if ! hash passage 2> /dev/null; then
    tmpdir=$(mktemp -d)
    git clone git@github.com:FiloSottile/passage.git "$tmpdir"
    cd "$tmpdir"
    make install PREFIX="$(brew --cellar)/passage/$(git describe --tags)"
    brew link passage
fi
