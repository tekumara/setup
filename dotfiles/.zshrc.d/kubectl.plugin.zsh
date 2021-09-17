# just the minimal set I actually use
# see also:
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/kubectl/kubectl.plugin.zsh
# https://github.com/ahmetb/kubectl-aliases
alias k='kubectl'

export KUBECONFIG=$HOME/.kube/config:$HOME/.flyte/k3s/k3s.yaml:$HOME/.k3d/kubeconfig-gha.yaml
