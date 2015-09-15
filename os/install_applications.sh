#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source 'utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  declare -r OS="$(get_os)"

  if [ "$OS" == "osx" ]; then
    ./os_x/installs/main.sh
    ./os_x/change_default_shell.sh
  fi

}

main
