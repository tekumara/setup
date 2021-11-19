#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# install dotfile symlinks
if [[ -s ~/.zshrc ]]; then
    mv ~/.zshrc ~/.zshrc-pre-setup."$(date +%s)"
fi

stow -vv dotfiles -t ~
if [[ -d ~/Dropbox/secret/dotfiles ]]; then
    stow -vv dotfiles -d ~/Dropbox/secret -t ~
fi

## vim settings
if [[ ! -d ~/.vim_runtime ]]; then
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_basic_vimrc.sh
fi

# run zsh to start antibody for the first time to download plugins
zsh -c "set -e; source ~/.zshrc"
