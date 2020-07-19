#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -uoe pipefail

# install python
python_version=3.6.11
pyenv install -s "$python_version"

# set default python version
# don't rely on the system/brew installed python as the global default 
# because virtualenvs using it will break when brew performs major upgrades
pyenv global "$python_version"

# needed on first install so pip can be found
eval "$(pyenv init -)"

pip install --upgrade pip