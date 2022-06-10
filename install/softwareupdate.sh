#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# do a check with no-scan first for speed
if ! softwareupdate --no-scan -l 2>&1 | grep "No new software available"; then
    # install recommended system updates (eg: xcode tools)
    softwareupdate -i -r --agree-to-license
fi
