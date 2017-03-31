#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source 'utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -r -a NPM_PACKAGES=(
  'bower'
  'gh'
  'rebase-editor'
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Check if `npm` is installed

  if ! cmd_exists 'npm'; then
    print_error 'npm is required, please install it!\n'
    exit 1
  fi

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Ensure the most recent version of `npm` is installed

  execute 'npm install --global npm' 'npm (update)'

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Install the `npm` packages

  for i in ${NPM_PACKAGES[@]}; do
    execute "npm install --global $i" "$i"
  done

}

main
