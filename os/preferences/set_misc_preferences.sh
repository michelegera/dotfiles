#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_misc_preferences() {

  execute 'defaults write com.apple.ImageCapture disableHotPlug -bool true' \
    'Prevent ImageCapture from opening automatically'

  execute 'defaults write com.apple.AppleFileServer guestAccess -bool false;
           defaults write com.apple.smb.server AllowGuestAccess -bool false' \
    'Disable guest access'

  execute 'sudo systemsetup -setremotelogin on' \
    'Enable remote login'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple '\n  Misc\n\n'
    set_misc_preferences

}

main
