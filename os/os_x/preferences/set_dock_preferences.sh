#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_dock_preferences() {
  execute 'defaults write com.apple.dock expose-animation-duration -float 0.2' \
    'Speed up Mission Control animations'

  execute 'defaults write com.apple.dock mineffect -string "scale"' \
    'Change minimize/maximize window effect'

  execute 'defaults write com.apple.dock mru-spaces -bool false' \
    'Do not automatically rearrange spaces based on most recent use'

  execute 'defaults write com.apple.dock persistent-apps -array "" &&
           defaults write com.apple.dock persistent-others -array ""' \
    'Wipe all app icons'

  execute 'defaults write com.apple.dock tilesize -int 40' \
    'Set icon size'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  print_in_purple '\n  Dock\n\n'
  set_dock_preferences

  killall 'Dock' &> /dev/null

}

main
