# default less to smart case insensitive searching + displaying ANSI colours
export LESS="-iR"

# awscli: don't page if output will fit on one screen
export AWS_PAGER="less -F -X"

# .local/bin is for pipx installed entrypoints
export PATH="$PATH:$HOME/.local/bin"
