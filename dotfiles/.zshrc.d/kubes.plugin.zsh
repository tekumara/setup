# a minimal set of aliases adapted from
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/kubectl/kubectl.plugin.zsh
# https://github.com/ahmetb/kubectl-aliases
alias k='kubectl'
alias ka='kubectl attach -it'
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
alias kgss='kubectl get statefulset'
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

# create default config if it doesn't exist.
# kubectl writes the current-context to the first file in KUBECONFIG
# (see below). So we prefix this file with 00 so it appears first.
# This gives us a stable default that doesn't change when the
# alphanumeric order of the files in ~/.kube changes.
default_config="$HOME/.kube/00_default.yaml"

if [[ ! -f "$default_config" ]]; then
  mkdir -p $(dirname "$default_config")
  cat <<EOF >"${default_config}"
apiVersion: v1
kind: Config
current-context: ""
EOF
fi

# unset is needed because we are appending values below and
# it may already have been set by the parent process (eg: vscode)
unset KUBECONFIG

# set KUBECONFIG to all config files in the paths below, so
# we don't have to merge them into a single file
#
# use glob qualifier N (ie: null_glob) to prevent a "no matches found"
# error if the glob doesn't match any files
files=($HOME/.kube/*.yaml(N) $HOME/.k3d/kubeconfig*.yaml(N) $HOME/.kube/config)
for file in $files; do
  KUBECONFIG+="${KUBECONFIG+:}${file}"
done

# kube context per shell https://github.com/ahmetb/kubectx/issues/12#issuecomment-557852519
file="$(mktemp ${TMPDIR:-/tmp/}kubectx.XXXXXXXX)"
export KUBECONFIG="${file}:${KUBECONFIG}"
cat <<EOF >"${file}"
apiVersion: v1
kind: Config
current-context: ""
EOF

kc-default() {
  # set the kube context used when opening a new shell (aka the default context).
  # to do this, we make sure the default config is ahead of the per-shell context,
  # so the current-context setting is stored in the default config file
  KUBECONFIG="${default_config}:${KUBECONFIG}" kubectx
}

kpf() {
  # run in a subshell so that we can use exit in error handling
  # without affecting the parent shell
  ( _kpf "$@" )
}

_kpf() {
  set -euo pipefail

  [[ "$#" -eq 0 ]] && echo -e "Start/stop kubectl port-forward whilst running a command.\n\nUsage: $0 TYPE/NAME [LOCAL_PORT:]REMOTE_PORT command [args..]" >&2 && exit 42

  die() {
      echo -e ERROR: "$@" >&2
      cleanup 42
  }
  cleanup() {
      local exit_status="$?"
      kill "$kubectl_pid"
      wait "$kubectl_pid" 2> /dev/null || true
      echo "kubectl port-forward stopped" >&2
      exit "${exit_status}"
  }

  kubectl port-forward "$1" "$2" >&2 &
  kubectl_pid=$!
  echo kubectl port-forward "$1" "$2" >&2

  trap 'cleanup' ERR
  timeout 5 sh -c "until nc -z localhost ${2%:*} ; do sleep 0.1; done" || die "timed out"
  shift 2
  "$@"
  cleanup
}
