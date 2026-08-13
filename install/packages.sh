#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# make sure homebrew ARM binaries are on the path if already installed
# this handles reruns within the same terminal of the very first install
# and avoids updating .zprofile again
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv bash)"
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
        echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> "$HOME"/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv bash)"
        set +x
    fi

elif [[ "${SKIP_BREW_UPDATE:-}" == "" ]]; then
    echo brew update ...
    brew update
fi

# install packages in Brewfile
brew bundle install --verbose --file install/Brewfile

# install fzf key bindings & fuzzy completion and update zshrc
"$(brew --prefix)"/opt/fzf/install --all --no-bash

# update antidote plugins if any
if [[ -d "$HOME/Library/Caches/antidote" ]]; then
    zsh -fc "source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh && antidote update"
fi

# install/upgrade tools from this repo's mise config
# (~/.config/mise/config.toml is only created later by stow)
MISE_GLOBAL_CONFIG_FILE="$PWD/dotfiles/.config/mise/config.toml" mise upgrade
