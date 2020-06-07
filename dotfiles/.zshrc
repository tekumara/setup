# enable profiling
zmodload zsh/zprof

zstyle ':prezto:*:*' 'color' 'yes'

autoload -Uz compinit && compinit -C

# Generate new ~/.zsh_plugins.sh if it does not exist or ~/.zshrc is newer
if [[ ! -f ~/.zsh_plugins.sh ]] || [[ ~/.zshrc -nt ~/.zsh_plugins.sh ]]; then
  echo "antibody bundle"
  antibody bundle <<- EOF > ~/.zsh_plugins.sh
    ohmyzsh/ohmyzsh path:lib 
    ohmyzsh/ohmyzsh path:themes/robbyrussell.zsh-theme
EOF
fi

source ~/.zsh_plugins.sh

  # zgen oh-my-zsh
  # zgen oh-my-zsh plugins/kubectl
  # zgen oh-my-zsh plugins/git
  # zgen oh-my-zsh themes/robbyrussell

  # zgen load zsh-users/zsh-autosuggestions
  # zgen load zsh-users/zsh-syntax-highlighting

  #TODO: turn this into a prezto module
  #zgen load junegunn/fzf shell
  #if [[ -f ~/.fzf.zsh ]]; then
  #zgen load ~/.fzf.zsh
  #fi

source "$HOME/.zshrc.d/awsweb.plugin.zsh"
source "$HOME/.zshrc.d/docker.plugin.zsh"
source "$HOME/.zshrc.d/golang.plugin.zsh"
source "$HOME/.zshrc.d/java.plugin.zsh"
source "$HOME/.zshrc.d/rust.plugin.zsh"
source "$HOME/.zshrc.d/git.plugin.zsh"
source "$HOME/Dropbox/Slack/functions.zsh"

# dynamically load anything in the work directory
# this won't be under source control 
for zshfile in "${ZDOTDIR:-$HOME}"/.zshrc.d/work/*.zsh; do
  echo "load $zshfile"
  source "$zshfile"
done

# create zcompdump only if the existing one is older than 24 hours (or doesn't exist)
autoload -Uz compinit
# shellcheck disable=SC1073,SC1036,SC1072
if [[ -n "${ZDOTDIR:-$HOME}"/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

# allow overwriting existing files
# (this is unset by the prezto directory module)
setopt CLOBBER

# use same definition as oh-my-zsh so hypen and dot aren't considered part of a word
WORDCHARS=''

# set prezto to use same history file as oh-my-zsh and the macOS default
HISTFILE="$HOME/.zsh_history"

HISTSIZE=50000

# fzf keybindings (CTRL-T, CTRL-R) must be loaded after the prezto editor module
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pyenv + virtualenvwrapper
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
pyenv virtualenvwrapper_lazy

