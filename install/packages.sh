#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# install brew
if ! hash brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
        # Homebrew installs into /opt/homebrew/bin on Apple Silicion (M1 Mac) so
        # additional steps are needed to add it to the path
        # On an Intel Mac homebrew chowns /usr/local/bin, so we need to do that
        # too so we can install kubectl
        echo "Adding Homebrew to your PATH in .zprofile"
        set -x
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME"/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"

        sudo chown "$(whoami)" /usr/local/bin
        set +x
    fi

elif [[ "${SKIP_BREW_UPDATE:-}" == "" ]]; then
    echo brew update ...
    brew update
fi

# install packages in Brewfile
brew bundle install --verbose --no-lock --file install/Brewfile

# specific kubectl version, should be within +/- 1 version of the server
v=v1.21.12

if [[ -f /usr/local/bin/kubectl && "$(stat -f '%u' /usr/local/bin/kubectl)" == "0" ]]; then
    # installed as root by Docker so use sudo to remove
    set -x
    sudo rm -f /usr/local/bin/kubectl
    set +x
else
    # installed as current user by brew or doesn't exist
    rm -f /usr/local/bin/kubectl
fi

if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
    # Apple Silicon (M1 Mac)
    curl -fsSLo /usr/local/bin/kubectl "https://dl.k8s.io/release/$v/bin/darwin/arm64/kubectl"
    echo "d518a7642874d7c6ca863b12bb2ce591840c1798b460f1f97b1eea7fbb41b9c9  /usr/local/bin/kubectl"  | shasum --check
else
    curl -fsSLo /usr/local/bin/kubectl "https://dl.k8s.io/release/$v/bin/darwin/amd64/kubectl"
    echo "014d92af39ea8d3e57f01581c9ce44ea2b107c55d8cdeb838494014d034a6c17  /usr/local/bin/kubectl"  | shasum --check
fi
chmod a+x /usr/local/bin/kubectl

# rehash shims in case we've just upgraded pyenv via brew
pyenv rehash

# install fzf key bindings & fuzzy completion and update zshrc
"$(brew --prefix)"/opt/fzf/install --all --no-bash

# golang tools
go install github.com/go-delve/delve/cmd/dlv@latest

# for formatting markdown, json and javascript
npm install -g prettier
