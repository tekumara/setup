#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# install python
python_version=3.7.11
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

# python tools
# use a stable python3 path instead of the default brew path so
# pipx packages aren't broken when brew upgrades python
PIPX_DEFAULT_PYTHON=$(pyenv which python)
export PIPX_DEFAULT_PYTHON

pipx install --force py-spy
