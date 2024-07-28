#!/usr/bin/env zsh

# Misc
# ----

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

# enable double char quoting, eg: 'don''t' = don't
setopt rcquotes

# enable spell correction
setopt correct

# allow comments on the command line
# must be set before zdharma/fast-syntax-highlighting for comments to be coloured
setopt interactivecomments

# hyphen and dot shouldn't be consider part of a word
# see "4.3.4: Words, regions and marks" of http://zsh.sourceforge.net/Guide/zshguide04.html
WORDCHARS=''

if [[ "$VENDOR" == "ubuntu" ]]; then
    # default /etc/zsh/zshrc on Ubuntu puts the terminal into application mode
    # some terminals (eg: cloud9) don't play well with application mode (eg: scroll is broken)
    # see https://github.com/c9/core/issues/436#issuecomment-731917131
    # so we override the Ubuntu installed functions
    zle-line-init() {}
    zle-line-finish() {}
fi

# Aliases
# -------

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

# Bindkeys
# --------

# edit the command line in vim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# History
# -------
#
# see "2.5.5 History options" in http://zsh.sourceforge.net/Guide/zshguide02.html
# and "16.2.4 History" in http://zsh.sourceforge.net/Doc/Release/Options.html

# save history
[ -z "$HISTFILE" ] && HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY             # record ':start:elapsed;command' in history file
setopt HIST_FIND_NO_DUPS            # don't show duplicates when searching history
setopt HIST_IGNORE_ALL_DUPS         # don't write duplicates to the history file (drops the older event)
setopt HIST_IGNORE_SPACE            # ignore commands that start with space
setopt SHARE_HISTORY                # share history across all zsh sessions (implies INC_APPEND_HISTORY)

# Completions
# -----------
#
# see http://zsh.sourceforge.net/Doc/Release/Completion-System.html
# adapted from https://raw.githubusercontent.com/sorin-ionescu/prezto/ff91c8d/modules/completion/init.zsh

# Configure
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

# shift-tab goes to previous menu item
bindkey '^[[Z' reverse-menu-complete

# call this after all plugins with completions have loaded
_load_compinit() {
    autoload -Uz compinit

    # if dump exists and < 20 hours old
    if [[ $_comp_dumpfile(#qNmh-20) ]]; then
        # load existing dump without checks (-C)
        compinit -C
    else
        # ~/.zcompdump doesn't exist or is stale
        # will be created if it doesn't exist or differs from $fpath
        compinit -w
    fi
}
