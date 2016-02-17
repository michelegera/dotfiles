#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Homebrew Alternate Casks
  # https://github.com/caskroom/homebrew-versions

  if cmd_exists 'brew' \
    && brew_tap 'caskroom/versions'; then

    # Nothing to install!

  fi

}

main
