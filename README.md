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
first_prompt_lag_ms=80.679
first_command_lag_ms=557.900
command_lag_ms=41.683
input_lag_ms=6.921
exit_time_ms=371.420
```
