#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Homebrew Formulae
  # https://github.com/Homebrew/homebrew

  if cmd_exists 'brew'; then

    brew_install 'diff-so-fancy' 'diff-so-fancy'
    brew_install 'duti' 'duti'
    brew_install 'fish' 'fish'
    brew_install 'git' 'git'
    brew_install 'heroku' 'heroku'
    brew_install 'httpie' 'httpie'
    brew_install 'imagemagick' 'imagemagick --with-webp'
    brew_install 'lame' 'lame'
    brew_install 'memcached' 'memcached'
    brew_install 'mongodb' 'mongodb'
    brew_install 'mysql' 'mysql'
    brew_install 'node' 'node'
    brew_install 'phantomjs' 'phantomjs'
    brew_install 'postgres' 'postgres'
    brew_install 'rbenv' 'rbenv'
    brew_install 'rbenv-gemset' 'rbenv-gemset'
    brew_install 'ruby-build' 'ruby-build'
    brew_install 'sphinx' 'sphinx'
    brew_install 'tig' 'tig'
    brew_install 'transcrypt' 'transcrypt'
    brew_install 'tree' 'tree'
    brew_install 'watchman' 'watchman'

    printf '\n'

    RBENV_INIT="$(rbenv init -)"
    execute 'eval "$RBENV_INIT"' \
      'Initialize rbenv'

  fi

}

main
