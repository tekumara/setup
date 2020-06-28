#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -uoe pipefail

# set zsh as default shell
if [[ "$SHELL" != "/bin/zsh" ]]; then
    chsh -s /bin/zsh
fi

install/packages.sh
install/python.sh
install/defaults.sh

# install dotfile symlinks
mv ~/.zshrc ~/.zshrc-pre-setup
stow -vv dotfiles -t ~

# install zsh script symlinks
mkdir -p "$HOME/.zshrc.d"
stow -vv zshrc.d -t ~/.zshrc.d 

# install config
stow -vv config -t ~/.config

## vim settings
#brew install vim --override-system-vim

if [[ ! -d ~/.vim_runtime ]]; then
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
fi
