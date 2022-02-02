# use the login keychain for aws-vault so we don't need a separate password
export AWS_VAULT_KEYCHAIN_NAME=login

# set MFA token to last for 9 hours
export AWS_SESSION_TOKEN_TTL=9h
export AWS_CHAINED_SESSION_TOKEN_TTL=9h

alias ave='aws-vault exec'

# print AWS env vars as export statements
aws_vault_export() {
   aws-vault exec "$1" -- env | grep AWS | sed -e 's/^/export\ /'
}

ae() {
   if [[ "$AWS_SESSION_TOKEN" ]]; then
      # clear existing session and avoid nested sessions
      # by unsetting AWS_* vars (using zsh syntax)
      unset $(print -rC1 - $parameters[(I)AWS*] | egrep -v 'AWS_PAGER|AWS_VAULT|TOKEN_TTL')
   fi

   if [[ "$1" != "--unset" ]]; then
      # eval AWS env vars in current shell
      # ignore AWS_PAGER because it has spaces
      # ignore AWS_VAULT so we can switch to other roles in the same shell
      eval $(aws_vault_export "$1" | egrep -v 'AWS_PAGER|AWS_VAULT|TOKEN_TTL')
   fi
}

ab() {
   aws-vault login "$1"
}

alias awsid='aws sts get-caller-identity'
alias s3ls='aws s3 ls --summarize --human-readable'

alias ec2='COLUMNS=$COLUMNS aec ec2'
alias ami='COLUMNS=$COLUMNS aec ami'
alias ssm='COLUMNS=$COLUMNS aec ssm'
