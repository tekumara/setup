# default less to smart case insensitive searching + displaying ANSI colours
export LESS="-iR"

# awscli: don't page if output will fit on one screen
export AWS_PAGER="less -F -X"

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# added by pipx
export PATH="$PATH:$HOME/.local/bin"

# use a stable python3 path instead of the default brew path so
# pipx packages aren't broken when brew upgrades python
export PIPX_DEFAULT_PYTHON=$(pyenv which python)

# prevent pip from installing globally
export PIP_REQUIRE_VIRTUALENV=true
