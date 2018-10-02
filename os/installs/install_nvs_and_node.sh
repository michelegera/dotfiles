#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Install NVS and latest Node
  export NVS_HOME="$HOME/.nvs"
  git clone https://github.com/jasongin/nvs "$NVS_HOME" &> /dev/null
  . "$NVS_HOME/nvs.sh" install &> /dev/null

  # Source this script to load NVS
  source ${HOME}/.bash_profile

  # Install latst Node and set it as default
  nvs add latest &> /dev/null
  nvs link latest &> /dev/null

  print_result $? 'Install nvs and latest Node'

}

main
