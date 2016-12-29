#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -r -a APM_PACKAGES=(
  'package-sync'
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Check if `apm` is installed

  if ! cmd_exists 'apm'; then
    print_error 'apm is required, please install it!\n'
    exit 1
  fi

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Install the `apm` packages

  for i in ${APM_PACKAGES[@]}; do
    execute "apm install $i" "$i"
  done

}

main
