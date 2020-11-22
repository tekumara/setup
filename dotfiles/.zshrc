# enable profiling
zmodload zsh/zprof

# Generate new ~/.zsh_plugins.sh if it does not exist or ~/.zshrc is newer
if [[ ! -f ~/.zsh_plugins.sh ]] || [[ ~/.zshrc -nt ~/.zsh_plugins.sh ]]; then
  echo "antibody bundle"
  antibody bundle <<- EOF > ~/.zsh_plugins.sh
    sorin-ionescu/prezto
    #yous/vanilli.sh
    tekumara/prezto-tweaks
    tekumara/history.zsh

    ajeetdsouza/zoxide
    wfxr/forgit

    # zsh-async is needed by pure
    mafredri/zsh-async
    sindresorhus/pure

    zdharma/fast-syntax-highlighting
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-autosuggestions
    #zsh-users/zsh-completions

    tekumara/zsh-pyenv-virtualenvwrapper-lazy
EOF
fi

# init must run first
source "$HOME/.zshrc.d/init.plugin.zsh"

source ~/.zsh_plugins.sh

# completion runs after plugins have been loaded and added their completions to fpath
source "$HOME/.zshrc.d/completion.plugin.zsh"
source "$HOME/.zshrc.d/aws.plugin.zsh"
source "$HOME/.zshrc.d/docker.plugin.zsh"
source "$HOME/.zshrc.d/git.plugin.zsh"
source "$HOME/.zshrc.d/golang.plugin.zsh"
source "$HOME/.zshrc.d/java.plugin.zsh"
source "$HOME/.zshrc.d/kubectl.plugin.zsh"
source "$HOME/.zshrc.d/node.plugin.zsh"
source "$HOME/.zshrc.d/python.plugin.zsh"
source "$HOME/.zshrc.d/rust.plugin.zsh"
source "$HOME/Dropbox/Slack/functions.zsh"


# fzf keybindings (CTRL-T, CTRL-R) must be loaded after the prezto editor module
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# same order as git log
FORGIT_FZF_DEFAULT_OPTS="--reverse $FORGIT_FZF_DEFAULT_OPTS"
