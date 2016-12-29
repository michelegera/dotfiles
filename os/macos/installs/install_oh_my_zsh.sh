#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &> /dev/null

  print_result $? 'Install Oh My Zsh'

}

main
