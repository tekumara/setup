# prevent pip from installing globally
export PIP_REQUIRE_VIRTUALENV=true

# use a stable python3 path instead of the default brew path so
# pipx packages aren't broken when brew upgrades python
# NB: we don't use `pyenv which python` here because it's slooow (200ms)
PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/$(cat ~/.pyenv/version)/bin/python"
export PIPX_DEFAULT_PYTHON

# activate virtualenv in .venv/ or venv/
alias venv='{[[ -d .venv ]] && . .venv/bin/activate} || {[[ -d venv ]] && . venv/bin/activate} || echo "Missing .venv/"'
# create venv and activate
alias mkvenv='virtualenv --clear .venv && . .venv/bin/activate'

# vscode debugger
debugpy() {
    local port=62888
    if [[ -z $VIRTUAL_ENV ]]; then
        echo Could not find an activated virtualenv
    else
        [[ -d $VIRTUAL_ENV/lib/python*/site-packages/debugpy(#q) ]] || (echo "Installing debugpy" && pip install debugpy)
        echo "Attach vscode debugger to port $port" >&2
        python -m debugpy --listen "$port" --wait-for-client "$@"
    fi
}

alias pyright=node_modules/.bin/pyright
