#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# install brew
if ! hash brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo brew update ...
    brew update
fi

# install packages in Brewfile
brew bundle install --verbose --no-lock --file install/Brewfile

# rehash shims in case we've just upgraded pyenv via brew
pyenv rehash

# install fzf key bindings & fuzzy completion and update zshrc
"$(brew --prefix)"/opt/fzf/install --all --no-bash

# golang tools
go get -u github.com/go-delve/delve/cmd/dlv

# for formatting markdown, json and javascript
npm install -g prettier
