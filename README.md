# setup

[![Build](https://github.com/tekumara/setup/actions/workflows/ci.yml/badge.svg)](https://github.com/tekumara/setup/actions/workflows/ci.yml)

Contains installation scripts, .zshrc and dotfiles for a minimal, fast (120ms startup) zsh experience.

Run `./install.sh` to install and configure a fresh mac. Run it again to upgrade to the latest versions.

## why antibody?

antibody is a fast and minimal plugin manager.

It makes it easy to load plugins from github repos, and can update them.
It's faster than zgen by ~90ms, and the plugin script it generates is much simpler to read.

## bench

```
hyperfine --warmup 3 'zsh -i -c exit;'
```
