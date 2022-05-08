# enable profiling
zmodload zsh/zprof

# Generate new ~/.zsh_plugins.sh if it does not exist or ~/.zshrc is newer
if [[ ! -f ~/.zsh_plugins.sh ]] || [[ ~/.zshrc -nt ~/.zsh_plugins.sh ]]; then
  echo "antibody bundle"
  antibody bundle <<- EOF > ~/.zsh_plugins.sh
    #sorin-ionescu/prezto
    #tekumara/prezto-tweaks

    #yous/vanilli.sh
    #tekumara/history.zsh

    ajeetdsouza/zoxide
    wfxr/forgit

    # zsh-async is needed by pure
    mafredri/zsh-async
    sindresorhus/pure

    zdharma-continuum/fast-syntax-highlighting
    #zsh-users/zsh-history-substring-search
    zsh-users/zsh-autosuggestions
    #zsh-users/zsh-completions

    tekumara/zsh-pyenv-virtualenvwrapper-lazy
EOF
fi

# minimal.zsh must run before zdharma/fast-syntax-highlighting
source "$HOME/.zshrc.d/minimal.zsh"

source ~/.zsh_plugins.sh

source "$HOME/.zshrc.d/aws.plugin.zsh"
source "$HOME/.zshrc.d/docker.plugin.zsh"
source "$HOME/.zshrc.d/git.plugin.zsh"
source "$HOME/.zshrc.d/golang.plugin.zsh"
source "$HOME/.zshrc.d/java.plugin.zsh"
source "$HOME/.zshrc.d/kubes.plugin.zsh"
source "$HOME/.zshrc.d/node.plugin.zsh"
source "$HOME/.zshrc.d/python.plugin.zsh"
source "$HOME/.zshrc.d/ripgrep.plugin.zsh"
source "$HOME/.zshrc.d/rust.plugin.zsh"
if [[ -f "$HOME/Dropbox/Slack/functions.zsh" ]]; then
  source "$HOME/Dropbox/Slack/functions.zsh"
fi
if [[ -f "$HOME/.zshrc.d/aws-doctor.plugin.zsh" ]]; then
  source "$HOME/.zshrc.d/aws-doctor.plugin.zsh"
fi

# add fzf to path, and load fzf completion & keybindings (CTRL-T, CTRL-R)
source ~/.fzf.zsh

# same order as git log
FORGIT_FZF_DEFAULT_OPTS="--reverse $FORGIT_FZF_DEFAULT_OPTS"

# load completion system
_load_compinit
