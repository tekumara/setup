#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# set default python version
default_python_version=3.9
pip="$(brew --prefix)/bin/pip${default_python_version}"

# upgrade pip since installed
PIP_REQUIRE_VIRTUALENV=false $pip install --upgrade pip

# upgrade virtualenv (also used by virtualenvwrapper) to ensure venvs
# created by mkvenv/mktmpenv are seeded with the latest version of pip
PIP_REQUIRE_VIRTUALENV=false $pip install --upgrade virtualenv

# create pyenv versions for system-installed versions, so they can be selected with pyenv
# and used in .python-version. We use the brew-installed versions because they are optimised
# and don't require building from source, unlike versions installed via pyenv install
"$(brew --prefix)/bin/virtualenv" -p "$(brew --prefix)/bin/python3.9" --system-site-packages "$HOME/.pyenv/versions/3.9"
"$(brew --prefix)/bin/virtualenv" -p "$(brew --prefix)/bin/python3.10" --system-site-packages "$HOME/.pyenv/versions/3.10"
"$(brew --prefix)/bin/virtualenv" -p "$(brew --prefix)/bin/python3.11" --system-site-packages "$HOME/.pyenv/versions/3.11"

pyenv global $default_python_version

# install virtualenvwrapper upfront into pyenv global version
pip install virtualenvwrapper

# use a stable pyenv path instead of brew's pythonX.Y.Z path
# so pipx packages aren't broken when brew upgrades python
PIPX_DEFAULT_PYTHON=$(pyenv which python)
export PIPX_DEFAULT_PYTHON

pipx_upgrade() {
	# install or upgrade pipx package
	pipx_venvs=${PIPX_HOME:-$HOME/.local/pipx}/venvs

    if [[ -d "$pipx_venvs/$1" ]]; then
        pipx upgrade "$1"
    else
        pipx install "$1"
    fi
}

pipx_upgrade aec-cli
