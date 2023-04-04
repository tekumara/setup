# a minimal set of aliases adapted from
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
alias kl='kubectl logs'
alias kcomp='type __kubectl_compgen  > /dev/null || source <(kubectl completion zsh)'

keb() {
  kubectl exec -i -t "$@" -- /bin/bash
}
kes() {
  kubectl exec -i -t "$@" -- /bin/sh
}
krb() {
  [[ "$#" -lt 2 ]] && echo -e "Usage: $0 podname imagename [options]" >&2 && return 42
  kubectl run "$1" -it --image="$2" $3 --command -- /bin/bash
}
krs() {
  [[ "$#" -ne 2 ]] && echo -e "Usage: $0 podname imagename" >&2 && return 42
  kubectl run "$1" -it --image="$2" --command -- /bin/sh
}

# unset is needed because we are appending values below and
# it may already have been set by the parent process (eg: vscode)
unset KUBECONFIG

# set KUBECONFIG to all config files in the paths below, so
# we don't have to merge them into a single file
#
# use glob qualifer N (ie: null_glob) to prevent a "no matches found"
# error if the glob doesn't match any files
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

kc-default() {
  [[ "$#" -ne 1 ]] && echo -e "Usage: $0 default-context\n\neg: $0 docker-desktop" >&2 && return 42
  # set default context by creating a file
  # that appears first when ~/.kube is listed (see above)
  # if no default is set then it will be the current-context as defined
  # in the first file sorted alphanumerically
  default_config="$HOME/.kube/00_config.yaml"
    echo "Set default context in $default_config"
    cat <<EOF >"${default_config}"
apiVersion: v1
kind: Config
current-context: "$1"
EOF
}
