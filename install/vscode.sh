#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -uoe pipefail

# install extensions
code \
    --install-extension ms-python.python                            \
    --install-extension ms-pyright.pyright                          \
    --install-extension kddejong.vscode-cfn-lint                    \
    --install-extension streetsidesoftware.code-spell-checker       \
    --install-extension fwcd.kotlin                                 \
    --install-extension foxundermoon.shell-format                   \
    --install-extension timonwong.shellcheck                        \
    --install-extension redhat.vscode-yaml                          \
    --install-extension davidanson.vscode-markdownlint