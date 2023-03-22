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
# and used in .python-version. We use the brew-installed versions because they are optimised,
# don't require building from source, and will receive patch upgrades, unlike versions
# installed via pyenv install
pyenv_install_brew_version() {
    "$(brew --prefix)/bin/virtualenv" -p "$(brew --prefix)/bin/python${1}" "$HOME/.pyenv/versions/${1}"
    # remove pyvenv.cfg so pip install fails with "Could not find an activated virtualenv" and avoids
    # unintentional installation into global site packages
    # this also removes .pyenv/versions/X.Y/lib/pythonX.Y/site-packages from sys.path
    # therefore sys.path is the same as when running $(brew --prefix)/bin/pythonX.Y
    rm "$HOME/.pyenv/versions/${1}/pyvenv.cfg"
}

pyenv_install_brew_version 3.9
pyenv_install_brew_version 3.10
pyenv_install_brew_version 3.11

pyenv global $default_python_version

# because we are using tekumara/zsh-pyenv-virtualenvwrapper-lazy
# run pyenv virtualenvwrapper upfront so it pip installs virtualenvwrapper
# must allow unbound variables for pyenv virtualenvwrapper
set +u
eval "$(pyenv init -)" && pyenv virtualenvwrapper

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
