#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# set default python version
default_python_version=3.10
# explicitly use brew's pip to avoid using xcode-installed pip
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

# use brew's versioned python so pipx packages aren't broken when brew
# upgrades the unversioned python symlink
PIPX_DEFAULT_PYTHON="$(brew --prefix)/bin/python${default_python_version}"
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
