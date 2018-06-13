#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Homebrew Formulae
  # https://github.com/Homebrew/homebrew

  if cmd_exists 'brew'; then

    brew_install 'blueutil' 'blueutil'
    brew_install 'cmake' 'cmake'
    brew_install 'ctags' 'ctags'
    brew_install 'diff-so-fancy' 'diff-so-fancy'
    brew_install 'doxygen' 'doxygen'
    brew_install 'duti' 'duti'
    brew_install 'git-secret' 'git-secret'
    brew_install 'git' 'git'
    brew_install 'gnupg' 'gnupg'
    brew_install 'gpg-agent' 'gpg-agent'
    brew_install 'heroku' 'heroku'
    brew_install 'htop' 'htop'
    brew_install 'httpie' 'httpie'
    brew_install 'imagemagick' 'imagemagick --with-webp'
    brew_install 'lame' 'lame'
    brew_install 'mas' 'mas'
    brew_install 'memcached' 'memcached'
    brew_install 'mongodb' 'mongodb'
    brew_install 'mysql' 'mysql'
    brew_install 'node' 'node'
    brew_install 'phantomjs' 'phantomjs'
    brew_install 'pinentry-mac' 'pinentry-mac'
    brew_install 'postgres' 'postgres'
    brew_install 'pv' 'pv'
    brew_install 'sphinx' 'sphinx'
    brew_install 'the_silver_searcher' 'the_silver_searcher'
    brew_install 'tig' 'tig'
    brew_install 'tldr' 'tldr'
    brew_install 'tmux' 'tmux'
    brew_install 'tree' 'tree'
    brew_install 'vim' 'vim --with-override-system-vi'
    brew_install 'watchman' 'watchman'
    brew_install 'yarn' 'yarn --without-node'
    brew_install 'zsh-history-substring-search' 'zsh-history-substring-search'
    brew_install 'zsh' 'zsh'
    brew_install 'zsh-syntax-highlighting' 'zsh-syntax-highlighting'

    printf '\n'

  fi

}

main
