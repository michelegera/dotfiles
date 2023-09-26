#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Applications\n\n"

brew_install "1Password" "1password"
brew_install "A Better Finder Rename" "a-better-finder-rename"
brew_install "AppCleaner" "appcleaner"
brew_install "Arq" "arq"
brew_install "balenaEtcher" "balenaetcher"
brew_install "Catch" "catch"
brew_install "Google Drive" "google-drive"
brew_install "Install Disk Creator" "install-disk-creator"
brew_install "NordVPN" "nordvpn"
brew_install "NTFS for Mac" "paragon-ntfs"
brew_install "OrbStack" "orbstack"
brew_install "Raycast" "raycast"
brew_install "Spotify" "spotify"
brew_install "Stats" "stats"
brew_install "Steam" "steam"
brew_install "The Unarchiver" "the-unarchiver"
brew_install "Transmission" "transmission"
brew_install "Transmit" "transmit"
brew_install "VLC" "vlc"
brew_install "WezTerm" "wezterm"
