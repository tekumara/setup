#!/usr/bin/env bash

set -euo pipefail

set -x

if [[ "$OSTYPE" == "darwin"* ]]; then
    # install python3 from brew, this is used by other brew packages (eg: awscli) and becomes the system version
    # of python, overriding what's installed by Mac OS
    {
        brew install python

        # point python -> python3, by default this is pointing at python2
        ln -sf python3 /usr/local/bin/python
        ln -sf python3-config /usr/local/bin/python-config

        # point pip -> pip3 to mirror Linux, as python3 from brew only has pip3
        ln -sf pip3 /usr/local/bin/pip
    }

    # install python build dependencies to be used by pyenv
    {
        brew install zlib

        # allow compiler to find sqlite3 and zlib
        export CPPFLAGS="-I/usr/local/opt/zlib/include"
        export CFLAGS="-I$(brew --prefix sqlite3)/include"
        export LDFLAGS="-L/usr/local/opt/zlib/lib -L$(brew --prefix sqlite3)/include"
    }

    # install pyenv
    brew install pyenv
else
    # on linux, the system version of python is whatever the distro has already installed for us

    # install python build dependencies to be used by pyenv see https://github.com/pyenv/pyenv/wiki/common-build-problems
    {
        source /etc/os-release

        if [[ "$ID" == "ubuntu" ]]; then
            sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev
        fi

        if [[ "$ID" == "amzn" ]]; then
            sudo yum -y install make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel xz xz-devel libffi-devel findutils openssl
        fi
    }

    # install pyenv
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    # shellcheck disable=SC2016
    echo -e '\nexport PATH="$HOME/.pyenv/bin:$PATH"\neval "$(pyenv init -)"' >> ~/.bashrc
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
fi

# install python via pyenv
# we use pyenv to install a specific version of python, and make it the global default,
# rather than relying on whatever the distro gives us (which can change underneath us)
pyenv install 3.6.8
pyenv global 3.6.8

pip install --upgrade pip==19.0.1

# enable tab autocompletion in the python shell
cat << EOF >> ~/.pythonrc
import rlcompleter, readline
readline.parse_and_bind('tab:complete')
EOF
echo "export PYTHONSTARTUP=~/.pythonrc" >> ~/.bashrc