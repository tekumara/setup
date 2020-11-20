# use a stable python3 path instead of the default brew path so
# pipx packages aren't broken when brew upgrades python
export PIPX_DEFAULT_PYTHON=$(pyenv which python)

# activate virtualenv in ./venv/
alias venv='. venv/bin/activate'

# prevent pip from installing globally
export PIP_REQUIRE_VIRTUALENV=true
