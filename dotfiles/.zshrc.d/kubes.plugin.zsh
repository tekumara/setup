# just the minimal set I actually use
# see also:
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/kubectl/kubectl.plugin.zsh
# https://github.com/ahmetb/kubectl-aliases
alias k='kubectl'
alias kc='kubectx'
alias kd='kubectl describe'
alias kdd='kubectl describe deployment'
alias kdj='kubectl describe job'
alias kdn='kubectl describe node'
alias kdp='kubectl describe pod'
alias kg='kubectl get'
alias kgd='kubectl get deployment'
alias kgda='kubectl get deployment --all-namespaces'
alias kgj='kubectl get job'
alias kgn='kubectl get node'
alias kgp='kubectl get pod'
alias kgpa='kubectl get pod --all-namespaces'
alias kgs='kubectl get service'
alias kgsa='kubectl get service --all-namespaces'
alias kge='kubectl get events --sort-by='{.lastTimestamp}''
alias kcomp='type __kubectl_compgen  > /dev/null || source <(kubectl completion zsh)'

keb() {
  kubectl exec -i -t "$@" -- /bin/bash
}
kes() {
  kubectl exec -i -t "$@" -- /bin/sh
}
krb() {
  [[ "$#" -ne 2 ]] && echo -e "Usage: $0 podname imagename" >&2 && return 42
  kubectl run "$1" -it --image="$2" --command -- /bin/bash
}
krs() {
  [[ "$#" -ne 2 ]] && echo -e "Usage: $0 podname imagename" >&2 && return 42
  kubectl run "$1" -it --image="$2" --command -- /bin/sh
}

# unset is needed becuase we are appending values below and
# it may already have been set by the  parent process (eg: vscode)
unset KUBECONFIG

files=($HOME/.kube/*.yaml(N) $HOME/.k3d/kubeconfig*.yaml(N))
for file in $files; do
  KUBECONFIG+="${KUBECONFIG+:}${file}"
done

# kube context per shell https://github.com/ahmetb/kubectx/issues/12#issuecomment-557852519
file="$(mktemp -t "kubectx.XXXXXX")"
export KUBECONFIG="${file}:${KUBECONFIG}"
cat <<EOF >"${file}"
apiVersion: v1
kind: Config
current-context: ""
EOF
