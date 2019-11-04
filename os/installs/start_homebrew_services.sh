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

    execute 'brew services start elasticsearch' \
      'Start Elasticsearch at login'
    execute 'brew services start mariadb@10.1' \
      'Start MariaDB at login'
    execute 'brew services start postgresql' \
      'Start PostgreSQL at login'

  fi

}

main
