# use a stable python3 path instead of the default brew path so
# pipx packages aren't broken when brew upgrades python
export PIPX_DEFAULT_PYTHON=$(pyenv which python)

# activate virtualenv in .venv/ or venv/
alias venv='{[[ -d .venv ]] && . .venv/bin/activate} || {[[ -d venv ]] && . venv/bin/activate} || echo "Missing .venv/"'
# create venv
alias mkvenv='python3 -m venv --clear .venv'

# prevent pip from installing globally
export PIP_REQUIRE_VIRTUALENV=true
