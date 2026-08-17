#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# install global skills in agents.toml
mise exec -- dotagents install
