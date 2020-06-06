#!/usr/bin/env bash

antibody bundle <<- EOF > ~/.zsh_plugins.sh
  sorin-ionescu/prezto
  sorin-ionescu/prezto path:modules/environment
  sorin-ionescu/prezto path:modules/terminal
  sorin-ionescu/prezto path:modules/editor
  sorin-ionescu/prezto path:modules/history
  sorin-ionescu/prezto path:modules/directory
  sorin-ionescu/prezto path:modules/spectrum
  sorin-ionescu/prezto path:modules/utility

  zsh-users/zsh-completions
  agkozak/zsh-z
  peterhurford/git-it-on.zsh

  # zsh-async is needed by pure
  mafredri/zsh-async
  sindresorhus/pure

  zdharma/fast-syntax-highlighting
  zsh-users/zsh-history-substring-search
EOF