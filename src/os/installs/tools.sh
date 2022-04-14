#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Tools\n\n"

brew_install "bat" "bat"
brew_install "coreutils" "coreutils"
brew_install "curl" "curl"
brew_install "dog" "dog"
brew_install "duti" "duti"
brew_install "elasticsearch" "elasticsearch-full" "" "elastic/tap"
brew_install "fd" "fd"
brew_install "fzf" "fzf"
brew_install "gawk" "gawk"
brew_install "gh" "gh"
brew_install "heroku" "heroku" "" "heroku/brew"
brew_install "htop" "htop"
brew_install "mariadb" "mariadb"
brew_install "mkcert" "mkcert"
brew_install "openssl" "openssl"
brew_install "postgresql" "postgresql"
brew_install "prettyping" "prettyping"
brew_install "pgcli" "pgcli" "" "dbcli/tap"
brew_install "pv" "pv"
brew_install "python" "python"
brew_install "rabbitmq" "rabbitmq"
brew_install "reattach-to-user-namespace" "reattach-to-user-namespace"
brew_install "redis" "redis"
brew_install "ripgrep" "ripgrep"
brew_install "shared-mime-info" "shared-mime-info"
brew_install "shellcheck" "shellcheck"
brew_install "starship" "starship"
brew_install "tldr" "tldr"
brew_install "tmux" "tmux"
brew_install "tree" "tree"
brew_install "xh" "xh"
brew_install "Yarn" "yarn"
brew_install "zoxide" "zoxide"
