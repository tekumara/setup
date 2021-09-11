#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -uoe pipefail

# install extensions
code \
    --install-extension ms-python.python                            \
    --install-extension ms-python.vscode-pylance                    \
    --install-extension kddejong.vscode-cfn-lint                    \
    --install-extension streetsidesoftware.code-spell-checker       \
    --install-extension fwcd.kotlin                                 \
    --install-extension foxundermoon.shell-format                   \
    --install-extension timonwong.shellcheck                        \
    --install-extension redhat.vscode-yaml                          \
    --install-extension davidanson.vscode-markdownlint              \
    --install-extension mhutchie.git-graph                          \
    --install-extension esbenp.prettier-vscode                      \
    --install-extension njpwerner.autodocstring                     \
    --install-extension ziyasal.vscode-open-in-github               \
    --install-extension tomoyukim.vscode-mermaid-editor             \
    --install-extension exiasr.hadolint
