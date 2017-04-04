#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Fonts
  # https://github.com/caskroom/homebrew-fonts

  if cmd_exists 'brew' \
    && brew_tap 'caskroom/fonts'; then

    brew_install 'Source Code Pro for Powerline' 'font-source-code-pro-for-powerline' 'cask'

  fi

}

main
