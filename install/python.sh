#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# install python
python_version=3.7.9
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
