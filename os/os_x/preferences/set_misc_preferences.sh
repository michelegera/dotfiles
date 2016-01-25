#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_misc_preferences() {

  execute 'defaults write com.apple.ImageCapture disableHotPlug -bool true' \
    'Prevent ImageCapture from opening automatically'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple '\n  Misc\n\n'
    set_misc_preferences

}

main
