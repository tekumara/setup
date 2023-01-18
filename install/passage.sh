#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# install passage
tmpdir=$(mktemp -d)
git clone https://github.com/FiloSottile/passage.git "$tmpdir"
cd "$tmpdir"
make install PREFIX="$(brew --cellar)/passage/$(git describe --tags)" WITH_ZSHCOMP=yes
brew link passage

