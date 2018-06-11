#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Homebrew Alternate Casks
  # https://github.com/caskroom/homebrew-versions

  if cmd_exists 'brew' \
    && brew_tap 'caskroom/versions'; then

    brew_install 'iTerm 3 Beta' 'iterm2-beta' 'cask'
    brew_install 'Skype 7' 'skype7' 'cask'

  fi

}

main
