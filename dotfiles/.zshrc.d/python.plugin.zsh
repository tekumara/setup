# prevent pip from installing globally
export PIP_REQUIRE_VIRTUALENV=true

# use a stable python3 path instead of the default brew path so
# pipx packages aren't broken when brew upgrades python
PIPX_DEFAULT_PYTHON=$(pyenv which python)
export PIPX_DEFAULT_PYTHON

# activate virtualenv in .venv/ or venv/
alias venv='{[[ -d .venv ]] && . .venv/bin/activate} || {[[ -d venv ]] && . venv/bin/activate} || echo "Missing .venv/"'
# create venv and activate
alias mkvenv='virtualenv --clear .venv && . .venv/bin/activate'

# vscode debugger
debugpy() {
    local port=62888
    echo "Attach vscode debugger to port $port" >&2
    python -m debugpy --listen "$port" --wait-for-client "$@"
}
