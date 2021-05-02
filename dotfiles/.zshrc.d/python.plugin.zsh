# use a stable python3 path instead of the default brew path so
# pipx packages aren't broken when brew upgrades python
export PIPX_DEFAULT_PYTHON=$(pyenv which python)

# activate virtualenv in .venv/ or venv/
alias venv='{[[ -d .venv ]] && . .venv/bin/activate} || {[[ -d venv ]] && . venv/bin/activate} || echo "Missing .venv/"'
# create venv - if a venv is active pip won't be installed so check first
alias mkvenv='[[ -z "${VIRTUAL_ENV}" ]] && python3 -m venv --clear .venv || echo Deactivate active virtualenv first'

# prevent pip from installing globally
export PIP_REQUIRE_VIRTUALENV=true
