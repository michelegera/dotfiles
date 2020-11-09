#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Applications\n\n"

brew_install "1Password" "1password" "homebrew/cask" "cask"
brew_install "A Better Finder Rename" "a-better-finder-rename" "homebrew/cask" "cask"
brew_install "Adobe Creative Cloud" "adobe-creative-cloud" "homebrew/cask" "cask"
brew_install "Alfred" "alfred" "homebrew/cask" "cask"
brew_install "AppCleaner" "appcleaner" "homebrew/cask" "cask"
brew_install "Garmin Express" "garmin-express" "homebrew/cask-drivers" "cask"
brew_install "Google Backup & Sync" "google-backup-and-sync" "homebrew/cask" "cask"
brew_install "Google Drive File Stream" "google-drive-file-stream" "homebrew/cask" "cask"
brew_install "Hyper" "hyper" "homebrew/cask" "cask"
brew_install "Install Disk Creator" "install-disk-creator" "homebrew/cask" "cask"
brew_install "Microsoft Office" "microsoft-office" "homebrew/cask" "cask"
brew_install "NordVPN" "nordvpn" "homebrew/cask" "cask"
brew_install "NTFS for Mac" "paragon-ntfs" "homebrew/cask" "cask"
brew_install "OpenJDK 8" "adoptopenjdk/openjdk/adoptopenjdk8" "adoptopenjdk/openjdk" "cask"
brew_install "Paw" "paw" "homebrew/cask" "cask"
brew_install "Sequel Pro (Nightly)" "sequel-pro-nightly" "homebrew/cask" "cask"
brew_install "Slack" "slack" "homebrew/cask" "cask"
brew_install "Spotify" "spotify" "homebrew/cask" "cask"
brew_install "Telegram Desktop" "telegram-desktop" "homebrew/cask" "cask"
brew_install "The Unarchiver" "the-unarchiver" "homebrew/cask" "cask"
brew_install "Tower" "tower" "homebrew/cask" "cask"
brew_install "Transmission" "transmission" "homebrew/cask" "cask"
brew_install "Transmit" "transmit" "homebrew/cask" "cask"
brew_install "VLC" "vlc" "homebrew/cask" "cask"
brew_install "WhatsApp" "whatsapp" "homebrew/cask" "cask"
brew_install "Zoom.us" "zoomus" "homebrew/cask" "cask"
