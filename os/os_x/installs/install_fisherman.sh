#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  if ! cmd_exists 'fisher'; then

    curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs | \
      git.io/fisherman &> /dev/null

  fi

  print_result $? 'Install Fisherman'

}

main
