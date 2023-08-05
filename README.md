# setup

[![Build](https://github.com/tekumara/setup/actions/workflows/ci.yml/badge.svg)](https://github.com/tekumara/setup/actions/workflows/ci.yml)

Contains installation scripts, .zshrc and dotfiles for a minimal, fast zsh experience.

## install

On a fresh mac:

```
git clone https://github.com/tekumara/setup.git ~/code/setup
cd ~/code/setup && ./install.sh
```

Run it again to upgrade to the latest version.

## bench

[zsh-bench](https://github.com/romkatv/zsh-bench):

```
==> benchmarking login shell of user tekumara ...
creates_tty=0
has_compsys=1
has_syntax_highlighting=1
has_autosuggestions=1
has_git_prompt=1
first_prompt_lag_ms=51.291
first_command_lag_ms=416.695
command_lag_ms=26.295
input_lag_ms=6.631
exit_time_ms=279.434
```
