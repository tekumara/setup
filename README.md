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

## why antibody?

antibody is a fast and minimal plugin manager.

It makes it easy to load plugins from github repos, and can update them.
It's faster than zgen by ~90ms, and the plugin script it generates is much simpler to read.

## bench

[zsh-bench](https://github.com/romkatv/zsh-bench):

```
==> benchmarking login shell of user tekumara ...
creates_tty=0
has_compsys=1
has_syntax_highlighting=1
has_autosuggestions=1
has_git_prompt=0
first_prompt_lag_ms=149.188
first_command_lag_ms=780.334
command_lag_ms=25.075
input_lag_ms=7.178
exit_time_ms=473.716
```
