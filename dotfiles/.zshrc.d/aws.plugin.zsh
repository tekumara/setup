alias ab='awsweb browser'

awsenv() {
  eval $(awsweb env "$@")
}

alias ae='awsenv'

alias ec2='COLUMNS=$COLUMNS aec ec2'
alias ami='COLUMNS=$COLUMNS aec ami'
alias ssm='COLUMNS=$COLUMNS aec ssm'
