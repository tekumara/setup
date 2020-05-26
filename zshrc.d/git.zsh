# scmpuff git aliases
eval "$(scmpuff init -s)"

# taken from scm breeze https://github.com/scmbreeze/scm_breeze/blob/master/lib/git/aliases.sh
alias gc='git commit'
alias gcm='git commit --amend'
alias gb='git branch'
alias gpl='git pull'
alias gps='git push'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gla='gl --all'