#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Homebrew Services
  # https://github.com/Homebrew/homebrew-services

  if cmd_exists 'brew' \
    && brew_tap 'homebrew/services'; then

    execute 'brew services start mysql@5.7' \
      'Start MySQL at login'
    execute 'brew services start mongodb' \
      'Start MongoDB at login'
    execute 'brew services start postgresql' \
      'Start PostgreSQL at login'

  fi

}

main
