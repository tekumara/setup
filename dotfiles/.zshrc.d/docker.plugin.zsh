alias dr='docker run --rm -it'
alias drb='docker run --rm -it --entrypoint /bin/bash'
alias drbv='docker run -it --entrypoint /bin/bash  -v "$(pwd)":/app -w /app'
alias ds='docker start -i'
deb() { docker exec -it "$1" bash }