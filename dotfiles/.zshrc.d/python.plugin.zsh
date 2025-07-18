# pyenv can't be lazy loaded because if a virtualenv is activated before
# pyenv loads (eg: by an IDE terminal) it will break the virtualenv
eval "$(pyenv init - --no-rehash zsh)"

# prevent pip from installing globally
export PIP_REQUIRE_VIRTUALENV=true

# use a stable pyenv path instead of brew's pythonX.Y.Z path
# so pipx packages aren't broken when brew upgrades python
# NB: we don't use `pyenv which python` here because it's slooow (200ms)
PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/$(cat ~/.pyenv/version)/bin/python"
export PIPX_DEFAULT_PYTHON

# activate virtualenv in .venv/ or venv/
alias venv='{[[ -d .venv ]] && . .venv/bin/activate} || {[[ -d venv ]] && . venv/bin/activate} || echo "Missing .venv/"'
# create .venv, using python version set by pyenv, and activate
alias mkvenv='virtualenv --python $(pyenv which python) .venv && . .venv/bin/activate'

# create temp venv, using python version set by pyenv, and activate
mktmpenv() {
    local venv="$(mktemp -d)"
    virtualenv --python $(pyenv which python) $venv
    . $venv/bin/activate
}

# vscode debugger
debugpy() {
    local port=62888
    if [[ -z $VIRTUAL_ENV ]]; then
        echo "Activate your virtualenv first to avoid module import errors."
    else
        local debugpy=$(ls -dtr ~/.vscode/extensions/ms-python.debugpy-*/bundled/libs/debugpy | head -n 1)
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
