# default less to smart case insensitive searching + displaying ANSI colours
export LESS="-iR"

# awscli: don't page if output will fit on one screen
export AWS_PAGER="less -F -X"

# .local/bin is for pipx installed entrypoints
export PATH="$PATH:$HOME/.local/bin"

export EDITOR=nvim

# zsh selects the zle editing mode based on $EDITOR
# but we still want to use emacs bindings (the default) for the command line
set -o emacs
