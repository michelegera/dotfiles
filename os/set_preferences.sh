#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source 'utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  ./preferences/main.sh

}

main
