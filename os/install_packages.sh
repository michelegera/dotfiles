#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source 'utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -r -a NODE_PACKAGES=(
  'avn'
  'avn-nvm'
  'avn-n'
  'neovim'
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Install Node packages via Yarn
  for i in ${NODE_PACKAGES[@]}; do
    execute "yarn global add $i" "Install $i"
  done

  execute 'avn setup' 'Setting up avn'

  print_result $? 'Install packages'

}

main
