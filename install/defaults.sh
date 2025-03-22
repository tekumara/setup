#!/usr/bin/env bash

# every instruction is idempotent so this script can be rerun multiple times

set -euo pipefail

# iterm2
# ------

# specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${PWD}/defaults/"
# use the custom preferences directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
# when prefs have changed, don't show the preferences have changed window on exit
defaults write com.googlecode.iterm2.plist NoSyncNeverRemindPrefsChangesLostForFile -bool true
# when prefs have changed, copy them to the custom folder
defaults write com.googlecode.iterm2.plist NoSyncNeverRemindPrefsChangesLostForFile_selection -bool false

# Finder
# ------
# (requires logging in/out to take effect)

# Save screenshots to Downloads
defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, use the previous search scope
defaults write com.apple.finder FXDefaultSearchScope -string "SCsp"

# Keyboard shortcuts
# ------------------
# (requires logging in/out to take effect)

# Use F1, F2, etc. keys as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# Podcasts
# --------

# disable automatic downloads when following to save disk space
defaults write com.apple.podcasts MTPodcastAutoDownloadStateDefaultKey -bool false

# Dock
# ----

# auto-hide dock
defaults write com.apple.dock autohide -bool true

# show dock instantly https://macos-defaults.com/dock/autohide-delay.html
defaults write com.apple.dock autohide-delay -float 0

# Mission Control
# ---------------

# do not automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Group windows by application
defaults write com.apple.dock expose-group-apps -bool true

# Windows & Apps
# --------------

# enable Stage Manager
defaults write com.apple.WindowManager GloballyEnabled -bool true

# Stage Manager - Show windows from an application - One at a Time
# All at Once required for TWS
defaults write com.apple.WindowManager AppWindowGroupingBehavior -bool false

# restart Dock for its settings to take effect
killall Dock

# Hot corners
# -----------

# top right: lock screen
defaults write com.apple.dock wvous-tr-corner -integer 13

# Default applications
# --------------------
duti install/defaults.duti
