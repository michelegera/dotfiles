#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source 'utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  ./installs/main.sh
  ./change_default_shell.sh
  ./set_default_apps.sh
  ./start_apps_at_login.sh

}

main
