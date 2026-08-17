# Ensure ssh sessions use a terminal profile compatible with Ghostty.
# TODO: remove with Ghostty 1.4 is released which introduces a better version of this fix
# See https://ghostty.org/docs/features/ssh
alias ssh='TERM=xterm-256color ssh'
