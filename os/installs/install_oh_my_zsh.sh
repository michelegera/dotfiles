#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Install Oh My Zsh
  # https://github.com/robbyrussell/oh-my-zsh
  curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh &> /dev/null

  # Install Spaceship theme
  # https://github.com/denysdovhan/spaceship-zsh-theme
  curl -LsSo - https://raw.githubusercontent.com/denysdovhan/spaceship-zsh-theme/master/install.zsh | zsh &> /dev/null

  print_result $? 'Install Oh My Zsh and theme'

}

main
