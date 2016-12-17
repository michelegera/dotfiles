#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source 'utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  declare -r OS="$(get_os)"

  if [ "$OS" == "macos" ]; then
    ./macos/installs/main.sh
    ./macos/change_default_shell.sh
    ./macos/set_default_apps.sh
    ./macos/start_apps_at_login.sh
  fi

}

main
