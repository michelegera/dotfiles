#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # System duplicate formulae
  # https://github.com/Homebrew/homebrew-dupes

  if cmd_exists 'brew' \
    && brew_tap 'homebrew/dupes'; then

    brew_install 'Apple GCC compiler' 'apple-gcc42'

  fi

}

main
