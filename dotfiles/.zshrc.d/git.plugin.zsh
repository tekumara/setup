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
alias gm='git merge'
alias gdc='git diff --cached'
alias grb='git rebase'
alias gcob='git checkout -b'
alias gsh='git show'
alias gst='git stash'

# fancy git checkout
unalias gco

_dedup() {
    # dedup unordered inputs, preserves order by taking the first occurrence
    # whereas uniq expects the input to be sorted for deduping
    # eg:
    # ❯ echo "b\na\nb\na" | uniq | sort | paste -s -d, -
    # a,a,b,b
    # ❯ echo "b\na\nb\na" | _dedup | paste -s -d, -
    # b,a
    #
    # see https://unix.stackexchange.com/a/194790/2680
    cat -n | sort -k2 -k1n  | uniq -f1 | sort -nk1,1 | cut -f2-
}

gco() {
    if [ $# -eq 0 ]; then
        # use fzf to select branch to checkout
        # remote branches are shown without the remotes/origin prefix
        # therefore git checkout will check out the equivalent local tracking branch,
        # if it exists, otherwise it creates one
        local current_branch=$(git rev-parse --abbrev-ref HEAD)
        git branch --all | grep -Ev "remotes/origin/(HEAD|\Q$current_branch\E$)" | sed 's|remotes/origin/||' | _dedup | fzf | sed 's|\*||' | xargs git checkout
    else
        git checkout "$@"
    fi
}

# forgit
alias grbi='forgit::rebase'
# disabled see https://github.com/wfxr/forgit/issues/280
#alias ga=forgit::add
alias gdf=forgit::diff
alias glf=forgit::log
alias gcf=forgit::fixup
alias grvf=forgit::revert::commit
alias gcof=forgit::checkout::commit
alias gstf=forgit::stash::show

# other
alias gca='git commit --amend'
function gcm {
    git commit -m "${1-.}"
}
# add all unstaged changes, commit and push
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
# pull origin main/master into the current branch
alias gpom='if git show-ref --verify --quiet refs/heads/main; then git pull origin main; else git pull origin master; fi'
# merge main/master into the current branch
alias gmm='if git show-ref --verify --quiet refs/heads/main; then git merge main; else git merge master; fi'

# delete branch locally and on origin
function gbd {
    git branch -D "$1"
    git push -d origin "$1"
}

# delete tag locally and on origin
function gtd {
    git tag -d "$1"
    git push -d origin "$1"
}

# github cli

# open the current branch in the browser
hb() {
    gh browse --branch "${1:-$(git rev-parse HEAD)}"
}
alias hbm='if git show-ref --verify --quiet refs/heads/main; then gh browse --branch main; else gh browse --branch master; fi'
# list prs
alias hprl='gh pr list'
# checkout pr
hprco() {
    if [ $# -eq 0 ]; then
        gh pr list | fzf --delimiter='\t' --with-nth=1,2 | cut -f1 | xargs gh pr checkout
    else
        gh pr checkout "$@"
    fi
}
# create pr for the current branch
alias hprc='gh pr create --fill -w'
# show pr checks
alias hprch='gh pr checks'
# view pr for the current branch
alias hprv='gh pr view --web'
# view ci.yml workflow
alias hwv='gh workflow view ci.yml'
# view ci.yml workflow in the browser
alias hwvb='gh workflow view -w ci.yml'

wiggles() {
    # apply all rej files
    for rej in **/*.rej(DN); do
        base="${rej%.rej}"
        echo "Applying $rej to $base"
        wiggle --replace "$base" "$rej" && rm "$rej"
        # we can't use --no-backup here see https://github.com/neilbrown/wiggle/issues/25
        rm "$base.porig"
    done
}

