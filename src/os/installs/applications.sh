#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# Each entry below is independent and reports its own result, so a single
# failure must not abort the rest of the list.

set +e

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Applications\n\n"

brew_install "1Password" "1password"
brew_install "A Better Finder Rename" "a-better-finder-rename"
brew_install "AppCleaner" "appcleaner"
brew_install "Arq" "arq"
brew_install "BetterDisplay" "betterdisplay"
brew_install "Catch" "catch"
brew_install "CoconutBattery" "coconutbattery"
brew_install "Ghostty" "ghostty"
brew_install "Gifox" "gifox"
brew_install "Google Drive" "google-drive"
brew_install "Handy" "handy"
brew_install "IINA" "iina"
brew_install "Mullvad VPN" "mullvad-vpn"
brew_install "NetNewsWire" "netnewswire"
brew_install "NTFS for Mac" "paragon-ntfs"
brew_install "Raycast" "raycast"
brew_install "Shottr" "shottr"
brew_install "Spark" "readdle-spark"
brew_install "Spotify" "spotify"
brew_install "Steam" "steam"
brew_install "The Unarchiver" "the-unarchiver"
brew_install "Transmission" "transmission" "--cask"
brew_install "Transmit" "transmit"
