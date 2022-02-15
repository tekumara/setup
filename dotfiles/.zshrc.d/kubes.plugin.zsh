# just the minimal set I actually use
# see also:
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/kubectl/kubectl.plugin.zsh
# https://github.com/ahmetb/kubectl-aliases
alias k='kubectl'
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods --all-namespaces'
alias kgd='kubectl get deployment'
alias kgda='kubectl get deployment --all-namespaces'
alias kgs='kubectl get service'
alias kgsa='kubectl get service --all-namespaces'
alias kge='kubectl get events --sort-by='{.lastTimestamp}''
keb() {
    kubectl exec -i -t "$@" -- /bin/bash
}
kes() {
    kubectl exec -i -t "$@" -- /bin/sh
}

unset KUBECONFIG
files=($HOME/.kube/*.yaml(N) $HOME/.k3d/kubeconfig*.yaml(N))
for file in $files; do
  KUBECONFIG+="${KUBECONFIG+:}${file}"
done

export KUBECONFIG

# kube context per shell https://github.com/ahmetb/kubectx/issues/12#issuecomment-557852519
file="$(mktemp -t "kubectx.XXXXXX")"
export KUBECONFIG="${file}:${KUBECONFIG}"
cat <<EOF >"${file}"
apiVersion: v1
kind: Config
current-context: ""
EOF
