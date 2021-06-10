#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Communications\n\n"

brew_install "Slack" "slack" "homebrew/cask" "cask"
brew_install "Telegram Desktop" "telegram-desktop" "homebrew/cask" "cask"
brew_install "Tweetbot" "tweetbot" "homebrew/cask" "cask"
brew_install "WhatsApp" "whatsapp" "homebrew/cask" "cask"
brew_install "Zoom" "zoom" "homebrew/cask" "cask"
