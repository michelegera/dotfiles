#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Homebrew Custom Casks
  # https://github.com/michelegera/homebrew-custom

  if cmd_exists 'brew' \
    && brew_tap 'michelegera/custom'; then

    print_in_purple 'Nothing to install\n'

  fi

}

main
