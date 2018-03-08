#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Drivers
  # https://github.com/caskroom/homebrew-drivers

  if cmd_exists 'brew' \
    && brew_tap 'caskroom/drivers'; then

    brew_install 'Garmin Express' 'garmin-express' 'cask'

  fi

}

main
