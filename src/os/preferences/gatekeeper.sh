#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Gatekeeper\n\n"

execute "sudo spctl --master-disable" \
    "Enable 'Anywhere' option for Gatekeeper"

execute "defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool false" \
    "Prevent Gatekeeper from re-enabling itself after 30 days"
