# enable profiling
#zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Generate new ~/.zsh_plugins.sh if it does not exist or ~/.zshrc is newer
if [[ ! -f ~/.zsh_plugins.sh ]] || [[ ~/.zshrc -nt ~/.zsh_plugins.sh ]]; then
  echo "antibody bundle"
  antibody bundle <<- EOF > ~/.zsh_plugins.sh
    #tekumara/history.zsh

    ajeetdsouza/zoxide
    wfxr/forgit

    romkatv/powerlevel10k

    zdharma-continuum/fast-syntax-highlighting
    #zsh-users/zsh-history-substring-search
    zsh-users/zsh-autosuggestions

    tekumara/zsh-pyenv-virtualenvwrapper-lazy
EOF
fi

# minimal.zsh must run before zdharma/fast-syntax-highlighting
source "$HOME/.zshrc.d/minimal.zsh"

# setup forgit aliases manually in git.plugin.zsh
FORGIT_NO_ALIASES=true

source ~/.zsh_plugins.sh

#source "$HOME/.zshrc.d/aws.plugin.zsh"
source "$HOME/.zshrc.d/docker.plugin.zsh"
#source "$HOME/.zshrc.d/git.plugin.zsh"
source "$HOME/.zshrc.d/golang.plugin.zsh"
#source "$HOME/.zshrc.d/java.plugin.zsh"
source "$HOME/.zshrc.d/kubes.plugin.zsh"
source "$HOME/.zshrc.d/node.plugin.zsh"
#source "$HOME/.zshrc.d/python.plugin.zsh"
source "$HOME/.zshrc.d/ripgrep.plugin.zsh"
source "$HOME/.zshrc.d/rust.plugin.zsh"
if [[ -f "$HOME/Dropbox/Slack/functions.zsh" ]]; then
  source "$HOME/Dropbox/Slack/functions.zsh"
fi

# add fzf to path, and load fzf completion & keybindings (CTRL-T, CTRL-R)
source ~/.fzf.zsh

# same order as git log
FORGIT_FZF_DEFAULT_OPTS="--reverse $FORGIT_FZF_DEFAULT_OPTS"

#setup-mac start
source "$HOME/.zshrc.d/aws-doctor.plugin.zsh"
source "$HOME/.zshrc.d/aws.plugin.zsh"
source "$HOME/.zshrc.d/functions.plugin.zsh"
source "$HOME/.zshrc.d/git-doctor.plugin.zsh"
source "$HOME/.zshrc.d/git.plugin.zsh"
source "$HOME/.zshrc.d/java.plugin.zsh"
source "$HOME/.zshrc.d/python.plugin.zsh"
source "$HOME/.zshrc.d/setup.plugin.zsh"

#setup-mac end

# add brew package completions
FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"
# load all completions
_load_compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable direnv last, so that any env vars overwritten will
# record their prior value if set above (eg: KUBECONFIG)
eval "$(direnv hook zsh)"
