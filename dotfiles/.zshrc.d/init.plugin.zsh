#!/usr/bin/env zsh

# quote pasted URLs if they contain special chars like &
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Termcap - colorise man pages
export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.

# enable spell correction
setopt correct

# allow comments on the command line
# must be set before zdharma/fast-syntax-highlighting for comments to be coloured
setopt interactivecomments

# ls
if hash dircolors 2>/dev/null; then
  # GNU Core Utilities
  alias ls='ls --group-directories-first --color=auto'
else
  # BSD Core Utilities
  alias ls="ls -G"
fi

alias ll='ls -lh'                 # Lists human readable sizes.
alias la='ll -A'                  # Lists human readable sizes, hidden files.
alias grep="grep --color=auto"    # Coloured grep
