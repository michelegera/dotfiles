#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Communications\n\n"

brew_install "Discord" "discord"
brew_install "Notion" "notion"
brew_install "Slack" "slack"
brew_install "Telegram Desktop" "telegram-desktop"
brew_install "WhatsApp" "whatsapp"
