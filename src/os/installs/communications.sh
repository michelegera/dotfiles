#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Communications\n\n"

brew_install "Slack" "slack" "--cask"
brew_install "Telegram Desktop" "telegram-desktop" "--cask"
brew_install "Tweetbot" "tweetbot" "--cask"
brew_install "WhatsApp" "whatsapp" "--cask"
brew_install "Zoom" "zoom" "--cask"
