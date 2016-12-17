#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  if ! cmd_exists 'fisher'; then

    curl -LsSo ~/.config/fish/functions/fisher.fish \
      --create-dirs git.io/fisher

  fi

  print_result $? 'Install Fisherman'

}

main
