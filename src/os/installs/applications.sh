#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Applications\n\n"

# The following apps will have to be installed manually as they are not (and
# might never be) in homebrew/cask
#
# - Affinity Designer
# - Affinity Photo
# - Affinity Publisher

brew_install "1Password" "1password" "homebrew/cask" "cask"
brew_install "A Better Finder Rename" "a-better-finder-rename" "homebrew/cask" "cask"
brew_install "Alacritty" "alacritty" "homebrew/cask" "cask"
brew_install "AppCleaner" "appcleaner" "homebrew/cask" "cask"
brew_install "Arq" "arq" "homebrew/cask" "cask"
brew_install "Backup and Sync from Google" "google-backup-and-sync" "homebrew/cask" "cask"
brew_install "balenaEtcher" "balenaetcher" "homebrew/cask" "cask"
brew_install "Catch" "catch" "homebrew/cask" "cask"
brew_install "Garmin Express" "garmin-express" "homebrew/cask-drivers" "cask"
brew_install "Google Drive" "google-drive" "homebrew/cask" "cask"
brew_install "Install Disk Creator" "install-disk-creator" "homebrew/cask" "cask"
brew_install "Microsoft Office" "microsoft-office" "homebrew/cask" "cask"
brew_install "NordVPN" "nordvpn" "homebrew/cask" "cask"
brew_install "NTFS for Mac" "paragon-ntfs" "homebrew/cask" "cask"
brew_install "Raycast" "raycast" "homebrew/cask" "cask"
brew_install "Spotify" "spotify" "homebrew/cask" "cask"
brew_install "The Unarchiver" "the-unarchiver" "homebrew/cask" "cask"
brew_install "Transmission" "transmission" "homebrew/cask" "cask"
brew_install "Transmit" "transmit" "homebrew/cask" "cask"
brew_install "VLC" "vlc" "homebrew/cask" "cask"
