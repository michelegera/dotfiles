#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_iterm_preferences() {

  osascript <<EOD

  tell application "iTerm"

    (* Do stuff *)

  end tell

EOD
  print_result $? 'Set iTerm preferences'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  print_in_purple '\n  Terminal\n\n'
  set_iterm_preferences

}

main
