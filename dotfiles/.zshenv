# default less to smart case insensitive searching + displaying ANSI colours
export LESS="-iR"

# awscli: don't page if output will fit on one screen
export AWS_PAGER="less -F -X"

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# added by pipx
export PATH="$PATH:$HOME/.local/bin"

# prevent pip from installing globally
export PIP_REQUIRE_VIRTUALENV=true
