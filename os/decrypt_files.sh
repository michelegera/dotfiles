#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source 'utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  ask 'Please provide the encryption password: ' && printf '\n'
  cd .. && transcrypt -y -c aes-256-cbc -p "$(get_answer)"

}

main
