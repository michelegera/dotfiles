#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_alfred_preferences() {

  # 131072  → Shift
  # 262144  → Control
  # 524288  → Option
  # 1048576 → Command
  execute 'defaults write com.runningwithcrayons.Alfred-Preferences hotkey.default -dict key -int 49 mod -int 1048576 string Space' \
    'Set ⌘ + Space hotkey'

  execute 'defaults write com.runningwithcrayons.Alfred-Preferences "appearance.theme" "alfred.theme.yosemite"' \
    'Set OS X Yosemite theme'

  execute 'defaults write com.runningwithcrayons.Alfred-Preferences syncfolder "$HOME/.alfred"' \
    'Set sync folder'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  print_in_purple '  Alfred\n\n'
  set_alfred_preferences

  killall 'Alfred 2' &> /dev/null
  killall 'Alfred Preferences' &> /dev/null

}

main
