#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# install and pin the default uv Python version
uv python pin --global 3.10
