#!/usr/bin/env zsh

## Completions see http://zsh.sourceforge.net/Doc/Release/Completion-System.html
##
## Adapted from https://raw.githubusercontent.com/sorin-ionescu/prezto/ff91c8d/modules/completion/init.zsh

#
# Load/initialize the completion system
#
autoload -Uz compinit

# if dump exists and > 20 hours old
if [[ $_comp_path(#qNmh-20) ]]; then
  # load existing dump and don't recreate (-C)
  compinit -C
else
  # zcompdump doesn't exist or is stale so create it
  compinit
fi

#
# Configure
#

setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt PATH_DIRS           # Perform path search even on command names with slashes.
setopt AUTO_MENU           # Show completion menu on a successive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB       # Needed for file modification glob modifiers with compinit
unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.

# Enable the caching functions for completions that use them, eg: package managers and docker
# Completions will be stored in ~/.zcompcache
zstyle ':completion::complete:*' use-cache on

# Try matching smart-case completion, then case-insensitive, then partial-word, and then
# substring completion.
# See http://zsh.sourceforge.net/Doc/Release/Completion-Widgets.html#Completion-Matching-Control
zstyle ':completion:*' matcher-list  'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# enable menu selection to highlight the selected completion
zstyle ':completion:*:*:*:*:*' menu select

# separate matches into groups
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''

# show descriptions for options
zstyle ':completion:*' verbose yes
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# prettier messages
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'

# Directory completions - use the same colours in the completion menu as ls

if [ -x /usr/bin/dircolors ]; then
  # GNU - set LS_COLORS to the default colors
  eval "$(dircolors -b)"
else
  # BSD - ls uses LSCOLORS which defaults to LSCOLORS='exfxcxdxbxegedabagacad'
  # set LS_COLORS to the equivalent set of colors
  # to interpret these color strings see https://geoff.greer.fm/lscolors/
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
fi

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
