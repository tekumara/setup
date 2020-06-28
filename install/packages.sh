#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -uoe pipefail

# install brew
if ! which -s brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# install packages in Brewfile
brew bundle install --verbose --no-lock

# install fzf key bindings & fuzzy completion and update zshrc
"$(brew --prefix)"/opt/fzf/install --all --no-bash

# install docker zsh completions
etc=/Applications/Docker.app/Contents/Resources/etc
ln -fs "$etc"/docker.zsh-completion /usr/local/share/zsh/site-functions/_docker

# golang tools
go get -u github.com/go-delve/delve/cmd/dlv