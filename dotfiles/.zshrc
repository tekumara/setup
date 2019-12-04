ZGEN_RESET_ON_CHANGE=(${HOME}/.zshrc)

# Disable oh-my-zsh autoupdate, rely on zgen to update it
DISABLE_AUTO_UPDATE=true

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then
  echo "Creating a zgen save"

  # Automatically run zgen update and zgen selfupdate every 7 days.
  zgen load unixorn/autoupdate-zgen

  # load default modules
  zgen prezto

  # load additional modules
  zgen prezto git

  # theme
  zgen prezto prompt theme 'cloud'
  zgen prezto utility:ls color 'yes'
  #zgen prezto editor key-bindings 'emacs'

  #zgen prezto python

  #zgen oh-my-zsh
  #zgen oh-my-zsh plugins/git
  #zgen oh-my-zsh themes/robbyrussell

  zgen load skywind3000/z.lua
  # zgen load zsh-users/zsh-autosuggestions
  # zgen load zsh-users/zsh-syntax-highlighting

  #zgen load junegunn/fzf shell
  #if [[ -f ~/.fzf.zsh ]]; then
    #zgen load ~/.fzf.zsh
  #fi

  for zshfile in "${ZDOTDIR:-$HOME}"/.*.zsh; do
    echo "load $zshfile"
    zgen load "$zshfile"
  done

  # generate the init script for everything above
  zgen save
fi

# fzf keybindings (CTRL-T, CTRL-R) must be loaded after the prezto editor module
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pyenv + virtualenvwrapper
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
pyenv virtualenvwrapper_lazy

# added by pipx
export PATH="$PATH:$HOME/.local/bin"