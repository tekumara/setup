# setup

[![Build](https://github.com/tekumara/setup/actions/workflows/ci.yml/badge.svg)](https://github.com/tekumara/setup/actions/workflows/ci.yml)

Contains installation scripts, .zshrc and dotfiles for a minimal, fast (120ms startup) zsh experience.

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

```
hyperfine --warmup 3 'zsh -i -c exit;'
```
