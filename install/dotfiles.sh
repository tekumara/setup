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

# run zsh to start antidote and p10k for the first time so they initialise
# and download any needed plugins
#
# use script to run an interactive shell with a prompt (nb: zsh -ic has no prompt)
# this is needed to trigger p10k initialisation
# also, we switch to $HOME first so zsh starts there like it would with an interactive login
(cd "$HOME" && echo exit | script -q zsh)
