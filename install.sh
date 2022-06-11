#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

install/softwareupdate.sh
install/packages.sh

# make sure homebrew ARM binaries are on the path during the first install
# so we can find them in the scripts that follow
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

install/kubectl.sh
install/python.sh
install/vscode.sh
install/defaults.sh
install/dotfiles.sh
