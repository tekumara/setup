# run image
alias dr='docker run --rm -it'
alias drb='docker run --rm -it --entrypoint /bin/bash'
alias drv='docker run --rm -it -v "$(pwd)":/app -w /app'
alias drvk='docker run -it -v "$(pwd)":/app -w /app'

# existing containers
alias ds='docker start -i'
deb() { docker exec -it "$1" bash }
