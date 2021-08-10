# use the login keychain for aws-vault so we don't need a separate password
export AWS_VAULT_KEYCHAIN_NAME=login

# print AWS env vars as export statements
aws_vault_export() {
   aws-vault exec "$1" -- env | grep AWS | sed -e 's/^/export\ /'
}

ae() {
   if [[ "$1" == "--unset" ]]; then
      # unset AWS_* vars, ie: unassume any roles (zsh only)
      unset $(print -rC1 - $parameters[(I)AWS*] | egrep -v 'AWS_PAGER|AWS_VAULT')
   else
      # eval AWS env vars in current shell
      # ignore AWS_PAGER because it has spaces
      # ignore AWS_VAULT so we can switch to other roles in the same shell
      eval $(aws_vault_export "$1" | egrep -v 'AWS_PAGER|AWS_VAULT')
   fi
}

ab() {
   aws-vault login "$1"
}

alias awsid='aws sts get-caller-identity'

alias ec2='COLUMNS=$COLUMNS aec ec2'
alias ami='COLUMNS=$COLUMNS aec ami'
alias ssm='COLUMNS=$COLUMNS aec ssm'
