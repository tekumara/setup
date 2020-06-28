#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -uoe pipefail

# set zsh as default shell
if [[ "$SHELL" != "/bin/zsh" ]]; then
    chsh -s /bin/zsh
fi

install/packages.sh
install/python.sh
install/vscode.sh
install/defaults.sh
install/dotfiles.sh