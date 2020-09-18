#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  if ! cmd_exists 'brew'; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" &> /dev/null
  fi

  print_result $? 'Homebrew'

}

main
