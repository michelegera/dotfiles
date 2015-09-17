#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Homebrew Formulae
  # https://github.com/Homebrew/homebrew

  if cmd_exists 'brew'; then

    brew_install 'fish' 'fish'
    brew_install 'git' 'git'
    brew_install 'httpie' 'httpie'
    brew_install 'imagemagick' 'imagemagick --with-webp'
    brew_install 'memcached' 'memcached'
    brew_install 'mongodb' 'mongodb'
    brew_install 'node' 'node'
    brew_install 'mysql' 'mysql'
    brew_install 'sphinx' 'sphinx'
    brew_install 'tig' 'tig'
    brew_install 'tree' 'tree'
    brew_install 'watchman' 'watchman'

  fi

}

main
