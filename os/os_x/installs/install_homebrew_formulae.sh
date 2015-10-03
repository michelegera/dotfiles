#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Homebrew Formulae
  # https://github.com/Homebrew/homebrew

  if cmd_exists 'brew'; then

    brew_install 'duti' 'duti'
    brew_install 'fish' 'fish'
    brew_install 'git' 'git'
    brew_install 'httpie' 'httpie'
    brew_install 'imagemagick' 'imagemagick --with-webp'
    brew_install 'memcached' 'memcached'
    brew_install 'mongodb' 'mongodb'
    brew_install 'mysql' 'mysql'
    brew_install 'node' 'node'
    brew_install 'rbenv' 'rbenv'
    brew_install 'rbenv-gemset' 'rbenv-gemset'
    brew_install 'ruby-build' 'ruby-build'
    brew_install 'sphinx' 'sphinx'
    brew_install 'tig' 'tig'
    brew_install 'tree' 'tree'
    brew_install 'watchman' 'watchman'

    printf '\n'

    MYSQL_PREFIX="$(brew --prefix mysql)"
    execute 'ln -sfv $MYSQL_PREFIX/*.plist ~/Library/LaunchAgents' \
      'Start MySQL at login'

    MONGODB_PREFIX="$(brew --prefix mongodb)"
    execute 'ln -sfv $MONGODB_PREFIX/*.plist ~/Library/LaunchAgents' \
      'Start MongoDB at login'

    RBENV_INIT="$(rbenv init -)"
    execute 'eval "$RBENV_INIT"' \
      'Initialize rbenv'

  fi

}

main
