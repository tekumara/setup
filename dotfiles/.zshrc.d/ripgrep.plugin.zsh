export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# search filenames
rgf() {
    # $1 = regex, $2 = path (optional)
    rg --files --hidden ${2:-} | rg "$1"
}

# search
rgpc() {
    rg --glob "*.py" "$@" ~/code/
}
