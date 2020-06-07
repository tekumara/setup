# scmpuff adds the following aliases with nice colours and number shortcuts next to changed files:
# alias gs='git status'
# alias ga='git add'
# alias gco='git checkout'
eval "$(scmpuff init -s)"

# taken from scm breeze https://github.com/scmbreeze/scm_breeze/blob/master/lib/git/aliases.sh
alias gc='git commit'
alias gcm='git commit --amend'
alias gb='git branch'
alias gpl='git pull'
alias gps='git push'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gla='gl --all'
alias grs='git reset' # ie: unstage
alias gdc='git diff --cached'
alias grb='git rebase'
alias grbi='git rebase -i'

# other 
alias gdh='git diff "HEAD^" HEAD'