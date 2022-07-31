#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# install python
python_version=3.9.13
pyenv install -s "$python_version"

# set default python version
# don't rely on the system/brew installed python as the global default
# because virtualenvs using it will break when brew performs major upgrades
pyenv global "$python_version"

# needed on first install so pip can be found
export PATH="${HOME}/.pyenv/shims:${PATH}" && eval "$(pyenv init -)"

# run pyenv virtualenvwrapper upfront so it downloads and installs itself
# must allow unbound variables for virtualenvwrapper
set +u
pyenv virtualenvwrapper

PIP_REQUIRE_VIRTUALENV=false && pip install --upgrade pip

# upgrade virtualenv (installed by virtualenvwrapper) to ensure venvs
# created by mkvenv/mktmpenv are seeded with the latest version of pip
PIP_REQUIRE_VIRTUALENV=false && pip install --upgrade virtualenv

# python tools
# use a stable python3 path instead of the default brew path so
# pipx packages aren't broken when brew upgrades python
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
