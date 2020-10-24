alias ab='awsweb browser'

awsenv() {
  eval $(awsweb env "$@")
}

alias ae='awsenv'

alias ec2='COLUMNS=$COLUMNS aec ec2'
