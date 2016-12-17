#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_alfred_preferences() {

  execute 'defaults write com.runningwithcrayons.Alfred-Preferences-3 syncfolder "$HOME/.alfred"' \
    'Set sync folder'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  print_in_purple '  Alfred\n\n'
  set_alfred_preferences

  killall 'Alfred 3' &> /dev/null
  killall 'Alfred Preferences' &> /dev/null

}

main
