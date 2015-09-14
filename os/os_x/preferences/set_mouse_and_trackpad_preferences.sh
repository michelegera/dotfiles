#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_mouse_and_trackpad_preferences() {

  execute 'defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true &&
           defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 &&
           defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1' \
    'Enable "Tap to click"'

  execute 'defaults write NSGlobalDomain com.apple.trackpad.scaling -int 5' \
    'Increase trackpad tracking speed'

  execute 'defaults write NSGlobalDomain com.apple.mouse.scaling -float 5' \
    'Increase mouse tracking speed'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple '\n  Mouse & Trackpad\n\n'
    set_mouse_and_trackpad_preferences

}

main
