#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Tools\n\n"

brew_install "bat" "bat"
brew_install "coreutils" "coreutils"
brew_install "delta" "delta"
brew_install "duti" "duti"
brew_install "Elasticsearch" "elasticsearch"
brew_install "fd" "fd"
brew_install "fzf" "fzf"
brew_install "GitHub" "gh"
brew_install "Heroku CLI" "heroku" "heroku/brew"
brew_install "htop" "htop"
brew_install "MariaDB" "mariadb"
brew_install "mkcert" "mkcert"
brew_install "PostgreSQL" "postgresql"
brew_install "prettyping" "prettyping"
brew_install "pv" "pv"
brew_install "Python" "python"
brew_install "RabbitMQ" "rabbitmq"
brew_install "rbenv-gemset" "rbenv-gemset"
brew_install "rbenv" "rbenv"
brew_install "reattach-to-user-namespace" "reattach-to-user-namespace"
brew_install "Redis" "redis"
brew_install "ripgrep" "ripgrep"
brew_install "ShellCheck" "shellcheck"
brew_install "Starship" "starship"
brew_install "tldr" "tldr"
brew_install "tmux" "tmux"
brew_install "tree" "tree"
brew_install "xh" "xh"
brew_install "Yarn" "yarn"
