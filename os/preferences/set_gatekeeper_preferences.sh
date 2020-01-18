#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_gatekeeper_preferences() {

  execute 'sudo spctl --master-disable' \
    'Enable “Anywhere” option for Gatekeeper'

  execute 'sudo defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool false' \
    'Prevent Gatekeeper from re-enabling itself after 30 days'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple '\n  Gatekeeper\n\n'
    set_gatekeeper_preferences

}

main
