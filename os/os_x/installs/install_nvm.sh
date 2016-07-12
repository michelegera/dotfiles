#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  if ! cmd_exists 'nvm'; then
    curl -so- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash &> /dev/null
  fi

  print_result $? 'nvm'

}

main
