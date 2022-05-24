#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Dock\n\n"

execute "defaults write com.apple.dock 'mineffect' -string 'scale'" \
    "Set window minimization animation to 'scale'"

execute "defaults write com.apple.dock expose-animation-duration -float 0.1" \
    "Speed up Mission Control animations"

execute "defaults write com.apple.dock expose-group-by-app -bool false" \
    "Do not group windows by application in Mission Control"

execute "defaults write com.apple.dock mru-spaces -bool false" \
    "Do not automatically rearrange spaces based on most recent use"

execute "defaults write com.apple.dock persistent-apps -array && \
         defaults write com.apple.dock persistent-others -array" \
    "Wipe all app icons"

execute "defaults write com.apple.dock show-recents -bool false" \
    "Do not show recent applications"

execute "defaults write com.apple.dock tilesize -int 40" \
    "Set icon size"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set hot corners

#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

execute "defaults write com.apple.dock wvous-tr-corner -int 2 && \
         defaults write com.apple.dock wvous-tr-modifier -int 0" \
    "Top right screen corner → Mission Control"

execute "defaults write com.apple.dock wvous-br-corner -int 4 && \
         defaults write com.apple.dock wvous-br-modifier -int 0" \
    "Bottom right screen corner → Desktop"

execute "defaults write com.apple.dock wvous-bl-corner -int 5 && \
         defaults write com.apple.dock wvous-bl-modifier -int 0" \
    "Bottom left screen corner → Start screen saver"

killall "Dock" &> /dev/null
