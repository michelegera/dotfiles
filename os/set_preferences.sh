#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source 'utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  declare -r OS="$(get_os)"

  if [ "$OS" == "macos" ]; then
    ./macos/preferences/main.sh
  fi

}

main
