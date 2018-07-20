#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Homebrew Formulae
  # https://github.com/Homebrew/homebrew

  if cmd_exists 'brew' \
    && brew_tap 'heroku/brew'; then

    brew_install 'autojump' 'autojump'
    brew_install 'bash' 'bash'
    brew_install 'diff-so-fancy' 'diff-so-fancy'
    brew_install 'duti' 'duti'
    brew_install 'git' 'git'
    brew_install 'gnupg' 'gnupg'
    brew_install 'gpg-agent' 'gpg-agent'
    brew_install 'heroku' 'heroku/brew/heroku'
    brew_install 'htop' 'htop'
    brew_install 'httpie' 'httpie'
    brew_install 'mas' 'mas'
    brew_install 'mongodb' 'mongodb'
    brew_install 'mysql' 'mysql@5.6'
    brew_install 'neovim' 'neovim'
    brew_install 'pinentry-mac' 'pinentry-mac'
    brew_install 'postgres' 'postgres'
    brew_install 'the_silver_searcher' 'the_silver_searcher'
    brew_install 'tig' 'tig'
    brew_install 'tldr' 'tldr'
    brew_install 'tmux' 'tmux'
    brew_install 'watchman' 'watchman'
    brew_install 'yarn' 'yarn --ignore-dependencies'
    printf '\n'

  fi

}

main
