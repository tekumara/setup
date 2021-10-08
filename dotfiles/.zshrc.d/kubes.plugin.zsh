# just the minimal set I actually use
# see also:
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/kubectl/kubectl.plugin.zsh
# https://github.com/ahmetb/kubectl-aliases
alias k='kubectl'
alias kge='kubectl get events --sort-by='{.lastTimestamp}''
keb() {
    kubectl exec -i -t "$1" -- /bin/bash
}

export KUBECONFIG=$HOME/.kube/config:$HOME/.flyte/k3s/k3s.yaml:$HOME/.k3d/kubeconfig-gha.yaml

# kube context per shell https://github.com/ahmetb/kubectx/issues/12#issuecomment-557852519
file="$(mktemp -t "kubectx.XXXXXX")"
export KUBECONFIG="${file}:${KUBECONFIG}"
cat <<EOF >"${file}"
apiVersion: v1
kind: Config
current-context: ""
EOF
