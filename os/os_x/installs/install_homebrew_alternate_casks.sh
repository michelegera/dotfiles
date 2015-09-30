#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Homebrew Alternate Casks
  # https://github.com/caskroom/homebrew-versions

  if cmd_exists 'brew' \
    && brew_tap 'caskroom/versions'; then

    brew_install 'Sublime Text 3' 'sublime-text3' 'cask'
    brew_install 'A Better Finder Rename 10 Beta' 'a-better-finder-rename-beta' 'cask'

  fi

}

main
