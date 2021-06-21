# scmpuff adds the following aliases with nice colours and number shortcuts next to changed files:
# alias gs='scmpuff_status'
# alias ga='git add'
# alias gd='git diff'
# alias gl='git log'
# alias gco='git checkout'
# alias grs='git reset' # ie: unstage
eval "$(scmpuff init -s)"

# taken from scm breeze https://github.com/scmbreeze/scm_breeze/blob/master/lib/git/aliases.sh
alias gc='git commit'
alias gcm='git commit --amend'
alias gb='git branch'
alias gpl='git pull'
alias gps='git push'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gla='gl --all'
alias gdc='git diff --cached'
alias grb='git rebase'
alias grbi='git rebase -i'
alias gcb='git checkout -b'
alias gsh='git show'


# other

alias gdh='git diff "HEAD^" HEAD'
# show both staged and unstaged changes
alias gda='git diff HEAD'
# add everything except untracked files
alias gaa='git add -u'
alias ginit='git init && git commit -m "root commit" --allow-empty'
# set tracking information for current branch to same named branch on origin
alias gbu='current=$(git rev-parse --abbrev-ref HEAD) && git branch --set-upstream-to="origin/$current" "$current"'
# if a main branch exists, checkout main, else checkout master
alias gcom='if git show-ref --verify --quiet refs/heads/main; then git checkout main; else git checkout master; fi'

# hub
alias hb='hub browse'
alias hbpr='hub pull-request'

# forgit aliases take precedence over anything above
alias ga=forgit::add
alias gdf=forgit::diff
alias glf=forgit::log
