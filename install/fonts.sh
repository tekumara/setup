#!/usr/bin/env zsh

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# download Meslo Nerd Font patched for Powerlevel10k
# see https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
#
# contents of this file were originally extracted from
# https://github.com/romkatv/powerlevel10k/blob/5ee7847/internal/wizard.zsh

function quit() {
    print -lr -- $funcfiletrace
    exit 1
}

function run_command() {
  local msg=$1
  shift
  [[ -n $msg ]] && print -nP -- "$msg ..."
  local err && err="$("$@" 2>&1)" || {
    print -P " %1FERROR%f"
    print -P ""
    print -nP "%BCommand:%b "
    print -r -- "${(@q)*}"
    if [[ -n $err ]]; then
      print -P ""
      print -r -- $err
    fi
    quit -c
  }
  [[ -n $msg ]] && print -P " %2FOK%f"
}

local -r font_base_url='https://github.com/romkatv/powerlevel10k-media/raw/master'

function install_font() {
      command mkdir -p -- ~/Library/Fonts || quit -c
      local style
      for style in Regular Bold Italic 'Bold Italic'; do
        local file="MesloLGS NF ${style}.ttf"
        if [[ ! -f ~/Library/Fonts/$file ]]; then
            run_command "Downloading %B$file%b" \
            curl -fsSL -o ~/Library/Fonts/$file.tmp "$font_base_url/${file// /%20}"
            command mv -f -- ~/Library/Fonts/$file{.tmp,} || quit -c
        fi
      done
}

install_font
