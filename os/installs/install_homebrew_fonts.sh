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

    brew_install 'Asap' 'font-asap' 'cask'
    brew_install 'Hack' 'font-hack' 'cask'
    brew_install 'Meslo LG for Powerline' 'font-meslo-lg-for-powerline' 'cask'
    brew_install 'Montserrat' 'font-montserrat' 'cask'
    brew_install 'Open Sans' 'font-open-sans' 'cask'

  fi

}

main
