# prevent pip from installing globally
export PIP_REQUIRE_VIRTUALENV=true

# activate virtualenv in .venv/ or venv/
alias venv='{[[ -d .venv ]] && . .venv/bin/activate} || {[[ -d venv ]] && . venv/bin/activate} || echo "Missing .venv/"'
# create .venv with uv's default python and activate
alias mkvenv='uv venv --seed .venv && . .venv/bin/activate'

# create temp venv with uv's default python and activate
mktmpenv() {
    local venv="$(mktemp -d)"
    uv venv --seed "$venv"
    . $venv/bin/activate
}

# vscode debugger
debugpy() {
    local port=62888
    if [[ -z $VIRTUAL_ENV ]]; then
        echo "Activate your virtualenv first to avoid module import errors."
    else
        local debugpy=$(ls -dtr ~/.vscode/extensions/ms-python.debugpy-*/bundled/libs/debugpy | head -n 1)
        # enable global qualifier syntax ie:(#q...) see https://zsh.sourceforge.io/Doc/Release/Expansion.html#Glob-Qualifiers
        # this is set locally for this function only
        setopt localoptions extendedglob
        # use glob qualifier N (ie: null_glob) so that if the glob has no matches we don't die
        [[ -d $~debugpy(#qN) ]] || { echo "vscode python extension not installed" && return }
        echo "Attach vscode debugger to port $port" >&2
        python $~debugpy --listen "$port" --wait-for-client "$@"
    fi
}

pyright() {
  if [[ -e .venv/lib/*/site-packages/pyright/dist/index.js(#qN) ]]; then
    # installed via pypi
    node .venv/lib/*/site-packages/pyright/dist/index.js "$@"
  else
    # installed via npm
    node_modules/.bin/pyright "$@"
  fi
}
