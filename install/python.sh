#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# set default python version
default_python_version=3.10
# explicitly use brew's pip to avoid using xcode or pyenv-installed pip
# NB: xcode may have overwritten /usr/local/bin/pip so we use the
# version in the $(brew --prefix)/opt/ path
pip="$(brew --prefix)/opt/python@${default_python_version}/libexec/bin/pip"

# upgrade pip since installed to the latest
#
# we force a reinstall to overwrite $(brew --prefix)/pip{,3,3.10} in case they
# have been overwritten by an xcode cli tools upgrade .. this makes sure any
# binaries installed via $(brew --prefix)/pip{,3,3.10} use brew's python and
# land in $(brew --prefix)/bin rather than xcode's ~/Library/Python/3.10/bin/
# which isn't on the path
PIP_REQUIRE_VIRTUALENV=false $pip install --force-reinstall pip

# upgrade virtualenv to ensure venvs
# created by mkvenv/mktmpenv are seeded with the latest version of pip
#
# we force a reinstall in case virtualenv was previously
# installed into xcode's python directory (ie: ~/Library/Python/3.10/bin/).
# This directory is not on the path, and re-installing using brew's pip
# creates virtualenv in "$(brew --prefix)/bin" which is on the path
PIP_REQUIRE_VIRTUALENV=false $pip install --force-reinstall virtualenv

# create pyenv versions for system-installed versions, so they can be selected with pyenv
# and used in .python-version. We use the brew-installed versions because they are optimised,
# don't require building from source, and will receive patch upgrades, unlike versions
# installed via pyenv install
pyenv_install_brew_version() {
    virtualenv -p "$(brew --prefix)/bin/python${1}" "$HOME/.pyenv/versions/${1}"
    # remove pyvenv.cfg so pip install fails with "Could not find an activated virtualenv" and avoids
    # unintentional installation into global site packages
    # this also removes .pyenv/versions/X.Y/lib/pythonX.Y/site-packages from sys.path
    # therefore sys.path is the same as when running $(brew --prefix)/bin/pythonX.Y
    rm "$HOME/.pyenv/versions/${1}/pyvenv.cfg"
}

pyenv_install_brew_version 3.10
pyenv_install_brew_version 3.11
pyenv_install_brew_version 3.12

pyenv global $default_python_version

# initialise our pyenv
eval "$(pyenv init -)"

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

pipx_upgrade nbdime
pipx_upgrade aec-cli

