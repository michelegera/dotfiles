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
    brew_install 'mysql' 'mysql'
    brew_install 'neovim' 'neovim'
    brew_install 'pinentry-mac' 'pinentry-mac'
    brew_install 'postgres' 'postgres'
    brew_install 'the_silver_searcher' 'the_silver_searcher'
    brew_install 'tig' 'tig'
    brew_install 'tldr' 'tldr'
    brew_install 'tmux' 'tmux'
    brew_install 'yarn' 'yarn --ignore-dependencies'
    brew_install 'zsh' 'zsh'
    brew_install 'zsh-history-substring-search' 'zsh-history-substring-search'
    brew_install 'zsh-syntax-highlighting' 'zsh-syntax-highlighting'
    printf '\n'

  fi

}

main
