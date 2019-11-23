#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source 'utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -r -a NPM_PACKAGES=(
  'avn'
  'avn-nvm'
  'avn-n'
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Install nvm
  execute 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash' 'Install nvm'

   # Source this to load nvm
  source ${HOME}/.bash_profile

  # Install latst Node
  execute 'nvm install node' 'Install latest Node'

  # Install `npm` packages
  for i in ${NPM_PACKAGES[@]}; do
    execute "npm install --global $i" "Install $i"
  done

  execute 'avn setup' 'Setting up avn'

  print_result $? 'Install Node version manager, latest Node and npm packages'

}

main
