#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

cd "$HOME"
ln -sfh Library/CloudStorage/Dropbox Dropbox
ln -sfh Library/CloudStorage/GoogleDrive-* "Google Drive"
ln -sfh "Google Drive/My Drive/.passage" .passage
ln -sfh /tmp tmp
