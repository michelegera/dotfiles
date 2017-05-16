#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Install Oh My Zsh
  # https://github.com/robbyrussell/oh-my-zsh
  bash -c "$(curl -LsS https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &> /dev/null

  print_result $? 'Install Oh My Zsh'

}

main
