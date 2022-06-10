#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

install/softwareupdate.sh
install/packages.sh
install/kubectl.sh
install/python.sh
install/vscode.sh
install/defaults.sh
install/dotfiles.sh
