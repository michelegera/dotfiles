#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_iterm_preferences() {

  execute 'defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder 1' \
    'Enable loading preferences from custom folder'

  execute 'defaults write com.googlecode.iterm2.plist PrefsCustomFolder "~/.iterm2"' \
    'Set preferences custom folder'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  print_in_purple '\n  iTerm\n\n'
  set_iterm_preferences

}

main
