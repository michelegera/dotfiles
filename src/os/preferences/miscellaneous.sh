#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Miscellaneous\n\n"

 execute "defaults write com.apple.AppleFileServer guestAccess -bool false && \
          defaults write com.apple.smb.server AllowGuestAccess -bool false" \
    "Disable guest access"
