#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

if ${CI:-false}; then
    # avoid downloading new versions of macOS which takes ~20mins
    echo "Skipping system updates during CI"
    exit 0
fi

echo "Checking for system software updates"
# do a check with no-scan first for speed
update_list="$(softwareupdate --no-scan -l 2>&1)"
echo "$update_list"

if ! grep -q "No new software available" <<<"$update_list"; then
    if grep -qi "Action: restart" <<<"$update_list"; then
        echo "One or more available updates require a restart. Your Mac will restart automatically after installation."
    fi

    # install recommended system updates (eg: xcode tools)
    sudo softwareupdate -i -r --restart --agree-to-license
fi
