#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -uoe pipefail

# install dotfile symlinks
mv ~/.zshrc ~/.zshrc-pre-setup."$(date +%s)"
stow -vv dotfiles -t ~
if [[ -d ~/Dropbox/secret/dotfiles ]]; then
    stow -vv dotfiles -d ~/Dropbox/secret -t ~
fi

## vim settings
if [[ ! -d ~/.vim_runtime ]]; then
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
fi
