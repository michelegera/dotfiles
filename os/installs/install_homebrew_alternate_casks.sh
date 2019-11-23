#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Homebrew Alternate Casks
  # https://github.com/caskroom/homebrew-versions

  if cmd_exists 'brew' \
    && brew_tap 'homebrew/cask-versions'; then

    brew_install 'Java 1.8' 'adoptopenjdk8' 'cask' # Required by elasticsearch
    brew_install 'Sequel Pro (Nightly Build)' 'sequel-pro-nightly' 'cask'

  fi

}

main
