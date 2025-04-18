#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# Replace ~ with actual home path and install as crontab
sed "s|~|$HOME|g" "$(dirname "$0")/crontab" | crontab -

echo "Crontab installed"
