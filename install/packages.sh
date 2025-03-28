#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# make sure homebrew ARM binaries are on the path if already installed
# this handles reruns within the same terminal of the very first install
# and avoids updating .zprofile again
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# install brew
if ! hash brew 2> /dev/null; then
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
        # Homebrew installs into /opt/homebrew/bin on ARM (M1 Mac) so
        # additional steps are needed to add it to the path
        echo "Adding Homebrew to your PATH in .zprofile"
        set -x
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME"/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
        set +x
    fi

elif [[ "${SKIP_BREW_UPDATE:-}" == "" ]]; then
    echo brew update ...
    brew update
fi

# install packages in Brewfile
brew bundle install --verbose --file install/Brewfile

# rehash shims in case we've just upgraded pyenv via brew
pyenv rehash

# install fzf key bindings & fuzzy completion and update zshrc
"$(brew --prefix)"/opt/fzf/install --all --no-bash

# golang tools
go install github.com/go-delve/delve/cmd/dlv@latest

# update antidote plugins if any
if [[ -d "$HOME/Library/Caches/antidote" ]]; then
    zsh -ic "source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh && antidote update"
fi

# rust
# use rustup because brew doesn't include clippy
# use --no-modify-path because we add ~/.cargo/bin to the path ourselves in rust.plugin.zsh
if ! hash rustup 2> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
else
    rustup update
fi
