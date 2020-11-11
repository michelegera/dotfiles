#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Tools\n\n"

brew_install "bat" "bat"
brew_install "coreutils" "coreutils"
brew_install "diff-so-fancy" "diff-so-fancy"
brew_install "duti" "duti"
brew_install "fd" "fd"
brew_install "fzf" "fzf"
brew_install "Heroku CLI" "heroku" "heroku/brew"
brew_install "htop" "htop"
brew_install "HTTPie" "httpie"
brew_install "MariaDB" "mariadb"
brew_install "mas" "mas"
brew_install "mkcert" "mkcert"
brew_install "PostgreSQL" "postgresql"
brew_install "prettyping" "prettyping"
brew_install "rbenv-gemset" "rbenv-gemset"
brew_install "rbenv" "rbenv"
brew_install "ripgrep" "ripgrep"
brew_install "ShellCheck" "shellcheck"
brew_install "tldr" "tldr"
brew_install "Yarn" "yarn" "" "" "--without-node"
brew_install "z" "z"
