#! /bin/bash

# every instruction is idempotent so this script can be rerun multiple times

set -uoe pipefail

# set zsh as default shell
chsh -s /bin/zsh

# install brew
if ! which -s brew; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# install cli tools
brew install ripgrep
brew install zsh
brew install wget
brew install jq
# nb: awscli also installs python3
brew install awscli

# dev tools
brew install shellcheck
brew cask install beyond-compare

# for vscode symbol generation
brew install ctags

# for building some python packages
brew install automake libtool

# for skywind3000/z.lua
brew install lua

# kubernetes
brew install kubernetes-helm

# install zgen
if [[ ! -d ~/.zgen ]]; then
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

# install dotfiles
brew install stow
mv ~/.zshrc ~/.zshrc-pre-setup
stow -vv dotfiles -t ~

# install zsh scripts
mkdir -p "$HOME/.zshrc.d"
stow -vv zshrc.d -t ~/.zshrc.d 

# install fzf + key bindings
brew install fzf
$(brew --prefix)/opt/fzf/install

# install python
brew install pyenv
pyenv install 3.6.9
brew install pyenv-virtualenvwrapper

# install java
brew tap AdoptOpenJDK/openjdk
brew cask install adoptopenjdk11
brew cask install adoptopenjdk8

# install mac apps
brew cask install visual-studio-code
brew cask install macbreakz
brew cask install dropbox
brew cask install spotify
brew cask install go2shell
brew cask install intellij-idea-ce
brew cask install docker
brew cask install firefox
brew cask install authy
brew cask install iterm2
brew cask install google-backup-and-sync
brew cask install calibre

if [[ ! -d "/Applications/VLC.app" ]]; then
    brew cask install vlc
fi

if [[ ! -d "/Applications/Google Chrome.app" ]]; then
    brew cask install google-chrome
fi

# install mac drivers
brew tap homebrew/cask-drivers
brew cask install evoluent-vertical-mouse-device-controller


## vim settings
if [[ ! -d ~/.vim_runtime ]]; then
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
fi

# iterm2 settings
# ---------------

# specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/Dropbox/Mackup/Library/Preferences"
# use the custom preferences directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
# save changes to the customer preferences directory
defaults write com.googlecode.iterm2.plist NoSyncNeverRemindPrefsChangesLostForFile_selection -bool false

# Finder settings
# ---------------

# Save screenshots to Downloads
defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, use the previous search scope
defaults write com.apple.finder FXDefaultSearchScope -string "SCsp"

# doesn't seem to work
# defaults write "Apple Global Domain" com.apple.keyboard.fnState -bool true
