#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# iterm2 settings
# ---------------

# specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${PWD}/defaults/"
# use the custom preferences directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
# when prefs have changed, don't show the preferences have changed window on exit
defaults write com.googlecode.iterm2.plist NoSyncNeverRemindPrefsChangesLostForFile -bool true
# when prefs have changed, copy them to the custom folder
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

# Podcasts settings
# -----------------

# disable automatic downloads when following to save disk space
defaults write com.apple.podcasts MTPodcastAutoDownloadStateDefaultKey -bool false

# Set default applications for file types
duti install/defaults.duti
