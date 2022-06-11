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
if ! softwareupdate --no-scan -l 2>&1 | grep "No new software available"; then
    # install recommended system updates (eg: xcode tools)
    softwareupdate -i -r --agree-to-license
fi
