# run image
alias dr='docker run --rm -it'
alias drb='docker run --rm -it --entrypoint /bin/bash'
alias drs='docker run --rm -it --entrypoint /bin/sh'
alias drv='docker run --rm -it -v "$(pwd)":/app -w /app'
alias drvk='docker run -it -v "$(pwd)":/app -w /app'

# existing containers
alias ds='docker start -i'
deb() { docker exec -it "$1" bash }
des() { docker exec -it "$1" sh }

# docker compose
alias dc='docker compose'
alias dcr='docker compose run --rm'
alias dce='docker compose exec'

