#! /bin/bash

# every instruction is idempotent so this script can be rerun multiple times

set -uoe pipefail

# set zsh as default shell
chsh -s /bin/zsh

# install brew
if ! which -s brew; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# install packages in Brewfile
brew bundle install --verbose --no-lock

# install zgen
if [[ ! -d ~/.zgen ]]; then
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

# install dotfiles
mv ~/.zshrc ~/.zshrc-pre-setup
stow -vv dotfiles -t ~

# install zsh scripts
mkdir -p "$HOME/.zshrc.d"
stow -vv zshrc.d -t ~/.zshrc.d 

# install fzf key bindings
$(brew --prefix)/opt/fzf/install

# install python
pyenv install 3.6.9

# don't rely on system installed python as the global
# default, because it can change under us
pyenv global 3.6.9
pip install --user pipx

# install docker zsh completions
etc=/Applications/Docker.app/Contents/Resources/etc
ln -s $etc/docker.zsh-completion /usr/local/share/zsh/site-functions/_docker

## vim settings
#brew install vim --override-system-vim

if [[ ! -d ~/.vim_runtime ]]; then
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
fi

# golang tools
go get -u github.com/go-delve/delve/cmd/dlv

# iterm2 settings
# ---------------

# specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/Dropbox/Mackup/Library/Preferences"
# use the custom preferences directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
# save changes to the custom preferences directory
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

# Set default application file type assoications
duti defaults.duti