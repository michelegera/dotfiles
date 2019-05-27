#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -r -a NPM_PACKAGES=(
  'avn'
  'avn-nvm'
  'avn-n'
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Install `n` and latest Node via `n-install`
  curl -L https://git.io/n-install | N_PREFIX=~/.n bash -s -- -y latest &> /dev/null

  # Install `npm` packages
  for i in ${NPM_PACKAGES[@]}; do
    execute "npm install --global $i" "$i"
  done

  print_result $? 'Install Node version manager, latest Node and npm packages'

}

main
