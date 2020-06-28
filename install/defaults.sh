#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -uoe pipefail

# iterm2 settings
# ---------------

# specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${HOME}/Dropbox/Mackup/Library/Preferences"
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

# Set default applications for file types
duti defaults.duti