#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # System software update tool
  # https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man8/softwareupdate.8.html

  execute 'sudo softwareupdate --install --all' 'Update system software'

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if cmd_exists 'brew'; then
    execute 'brew update' 'Brew (update)'
    execute 'brew upgrade --all' 'Brew (upgrade)'
    execute 'brew cleanup' 'Brew (cleanup)'
  fi

}

main
