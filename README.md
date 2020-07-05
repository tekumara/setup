# setup

Contains installation scripts, .zshrc and dotfiles for a minimal, fast (130ms startup) zsh experience.

Run `./install.sh` to install and configure a fresh mac. Run it again to upgrade to the latest versions.

## why antibody?

antibody is a fast and minimal plugin manager.

It makes it easy to load plugins from github repos, and can update them.
It's faster than zgen by ~90ms, and the plugin script it generates is much simpler to read.

## why prezto?

At least 100ms faster start up times and more lightweight than ohmyzsh

## bench

```
hyperfine --warmup 3 'zsh -i -c exit;'
```