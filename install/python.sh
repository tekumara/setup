#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# install and pin the default uv Python version
uv python pin --global 3.14

# For agents that expect `python` on PATH.
mkdir -p "$HOME/.local/bin"
python3_bin="$(command -v python3)"
ln -sfh "$python3_bin" "$HOME/.local/bin/python"
