#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Trackpad & Mouse\n\n"

execute "defaults write -g com.apple.trackpad.scaling -int 5 && \
         defaults write -g com.apple.mouse.scaling -float 5" \
    "Increase tracking speed"

execute "defaults write com.apple.AppleMultitouchMouse MouseButtonMode -string TwoButton && \
         defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string TwoButton" \
    "Enable secondary mouse click"
