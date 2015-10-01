#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Check if `duti` is installed

  if ! cmd_exists 'duti'; then
    print_error 'duti is required, please install it!\n'
    exit 1
  fi

  duti $HOME/.duti &> /dev/null

  print_result $? 'Set default applications for document types and URL schemes'

}

main
