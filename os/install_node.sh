#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source 'utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Install nvm
  execute 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash' 'Install nvm'

   # Source this to load nvm
  source ${HOME}/.bash_profile

  # Install latst Node
  execute 'nvm install node' 'Install latest Node'

  print_result $? 'Install Node version manager and latest Node'

}

main
