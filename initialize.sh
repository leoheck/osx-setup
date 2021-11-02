#!/bin/bash

# Initialize computer with barely minium required stuff to use the command line.

# Install brew
/bin/bash -c "sudo $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Github
brew install git

# Clone osx-setup scripts
rm -rf ~/Documents/osx-setup
git clone https://github.com/leoheck/osx-setup.git ~/Documents/osx-setup
cd ~/Documents/osx-setup

# Clean the shitty dock
brew install dockutil

# Remove garbage from the dock
dockutil --remove "Calendar"
dockutil --remove "Contacts"
dockutil --remove "FaceTime"
dockutil --remove "Mail"
dockutil --remove "Maps"
dockutil --remove "Messages"
dockutil --remove "Music"
dockutil --remove "News"
dockutil --remove "Notes"
dockutil --remove "Photos"
dockutil --remove "Podcasts"
dockutil --remove "Reminders"
dockutil --remove "TV"

# Add some apps in the dock
dockutil --add /System/Applications/Utilities/Terminal.app
dockutil --add /System/Applications/TextEdit.app

# Set hostname with the serial number
./set-hostname.sh

# Launch system settings to enable shit that cannot be enabled by script
open -a /System/Applications/System\ Preferences.app

# Enable Tap to Click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
sudo defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Set the default picture
sudo dscl . delete /Users/${USER} JPEGPhoto
sudo dscl . create /Users/${USER} Picture "/Library/User Pictures/Animals/Zebra.tif"

# Set the default picture for Poa Office
# https://apple.stackexchange.com/questions/117530/setting-account-picture-jpegphoto-with-dscl-in-terminal
sudo ./userpic.sh ${USER} ./poaoffice.png

# Install OH-MY-ZSH (colors)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Update things (hopefully)
sudo AssetCacheManagerUtil reloadSettings

echo
echo "DONE, Reboot to reload things!"
echo
