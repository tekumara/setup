# scmpuff adds the following aliases with nice colours and number shortcuts next to changed files:
# alias gs='scmpuff_status'
# alias ga='git add'
# alias gd='git diff'
# alias gl='git log'
# alias gco='git checkout'
# alias grs='git reset' # ie: unstage
eval "$(scmpuff init -s)"

# adapted from scm breeze https://github.com/scmbreeze/scm_breeze/blob/master/lib/git/aliases.sh
alias gc='git commit'
alias gb='git branch'
alias gpl='git pull'
alias gps='git push'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gla='gl --all'
alias gdc='git diff --cached'
alias grb='git rebase'
alias gcb='git checkout -b'
alias gsh='git show'

# forgit
alias grbi='forgit::rebase'
# disabled see https://github.com/wfxr/forgit/issues/280
#alias ga=forgit::add
alias gdf=forgit::diff
alias glf=forgit::log
alias gcf=forgit::fixup

# other
alias gca='git commit --amend'
gcm() {
    git commit -m "${1-.}"
}
alias gpa='gaa && gcm && gps'
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
# fetch main/master whilst remaining on the currently checked out branch. also updates local tracking branch
alias gfom='if git show-ref --verify --quiet refs/heads/main; then git fetch origin main:main; else git fetch origin master:master; fi'
# merge main/master into the current branch
alias gmm='if git show-ref --verify --quiet refs/heads/main; then git merge main; else git merge master; fi'

# delete branch locally and on origin
gbd() {
    git branch -D "$1"
    git push -d origin "$1"
}

# delete tag locally and on origin
gtd() {
    git tag -d "$1"
    git push -d origin "$1"
}

# github cli
hb() {
    gh browse --branch "${1:-$(git rev-parse HEAD)}"
}
# create pr for the current branch
alias hprc='gh pr create --fill -w'
# view pr for the current branch
alias hprv='gh pr view --web'
