# enable profiling
zmodload zsh/zprof

# Generate new ~/.zsh_plugins.sh if it does not exist or ~/.zshrc is newer
if [[ ! -f ~/.zsh_plugins.sh ]] || [[ ~/.zshrc -nt ~/.zsh_plugins.sh ]]; then
  echo "antibody bundle"
  antibody bundle <<- EOF > ~/.zsh_plugins.sh
    sorin-ionescu/prezto
    tekumara/prezto-tweaks

    agkozak/zsh-z

    # zsh-async is needed by pure
    mafredri/zsh-async
    sindresorhus/pure

    zdharma/fast-syntax-highlighting
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-autosuggestions
EOF
fi

source ~/.zsh_plugins.sh

source "$HOME/.zshrc.d/awsweb.plugin.zsh"
source "$HOME/.zshrc.d/docker.plugin.zsh"
source "$HOME/.zshrc.d/git.plugin.zsh"
source "$HOME/.zshrc.d/golang.plugin.zsh"
source "$HOME/.zshrc.d/java.plugin.zsh"
source "$HOME/.zshrc.d/kubectl.plugin.zsh"
source "$HOME/.zshrc.d/python.plugin.zsh"
source "$HOME/.zshrc.d/rust.plugin.zsh"
source "$HOME/Dropbox/Slack/functions.zsh"

# increase history size
HISTSIZE=50000
SAVEHIST=50000

# fzf keybindings (CTRL-T, CTRL-R) must be loaded after the prezto editor module
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh