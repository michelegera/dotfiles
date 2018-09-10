#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source 'utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  ./installs/main.sh
  ./change_default_shell.sh
  ./start_apps_at_login.sh

}

main
