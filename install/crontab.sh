#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# Replace ~ with actual home path and install as crontab
sed "s|~|$HOME|g" "$(dirname "$0")/crontab" | crontab -

mkdir -p "$HOME/.zsh_history_backup"

echo "Crontab installed"
