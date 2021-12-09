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

brew_install "1Password" "1password" "--cask"
brew_install "A Better Finder Rename" "a-better-finder-rename" "--cask"
brew_install "Alacritty" "alacritty" "--cask"
brew_install "AppCleaner" "appcleaner" "--cask"
brew_install "Arq" "arq" "--cask"
brew_install "Asana" "asana" "--cask"
brew_install "balenaEtcher" "balenaetcher" "--cask"
brew_install "Catch" "catch" "--cask"
brew_install "Garmin Express" "garmin-express" "--cask" "homebrew/cask-drivers"
brew_install "Google Drive" "google-drive" "--cask"
brew_install "Install Disk Creator" "install-disk-creator" "--cask"
brew_install "Microsoft Office" "microsoft-office" "--cask"
brew_install "NordVPN" "nordvpn" "--cask"
brew_install "NTFS for Mac" "paragon-ntfs" "--cask"
brew_install "Raycast" "raycast" "--cask"
brew_install "Spotify" "spotify" "--cask"
brew_install "The Unarchiver" "the-unarchiver" "--cask"
brew_install "Transmission" "transmission" "--cask"
brew_install "Transmit" "transmit" "--cask"
brew_install "VLC" "vlc" "--cask"
