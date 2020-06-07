# enable profiling
zmodload zsh/zprof

# Generate new ~/.zsh_plugins.sh if it does not exist or ~/.zshrc is newer
if [[ ! -f ~/.zsh_plugins.sh ]] || [[ ~/.zshrc -nt ~/.zsh_plugins.sh ]]; then
  echo "antibody bundle"
  antibody bundle <<- EOF > ~/.zsh_plugins.sh
    sorin-ionescu/prezto
    tekumara/prezto-tweaks

    agkozak/zsh-z
    peterhurford/git-it-on.zsh

    zdharma/fast-syntax-highlighting
    zsh-users/zsh-history-substring-search
EOF
fi

source ~/.zsh_plugins.sh

# TODO: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/kubectl
# TODO: https://github.com/zsh-users/zsh-autosuggestions

source "$HOME/.zshrc.d/awsweb.plugin.zsh"
source "$HOME/.zshrc.d/docker.plugin.zsh"
source "$HOME/.zshrc.d/git.plugin.zsh"
source "$HOME/.zshrc.d/golang.plugin.zsh"
source "$HOME/.zshrc.d/java.plugin.zsh"
source "$HOME/.zshrc.d/rust.plugin.zsh"
source "$HOME/.zshrc.d/python.plugin.zsh"
source "$HOME/Dropbox/Slack/functions.zsh"

# create zcompdump only if the existing one is older than 24 hours (or doesn't exist)
autoload -Uz compinit
# shellcheck disable=SC1073,SC1036,SC1072
if [[ -n "${ZDOTDIR:-$HOME}"/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

# increase history size
HISTSIZE=50000

# fzf keybindings (CTRL-T, CTRL-R) must be loaded after the prezto editor module
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh