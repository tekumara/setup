#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

install/packages.sh
install/python.sh
install/vscode.sh
install/defaults.sh
install/dotfiles.sh
