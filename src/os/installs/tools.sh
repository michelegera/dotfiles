#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Tools\n\n"

brew_install "bash" "bash"
brew_install "bat" "bat"
brew_install "bottom" "bottom"
brew_install "coreutils" "coreutils"
brew_install "curl" "curl"
brew_install "difftastic" "difftastic"
brew_install "direnv" "direnv"
brew_install "dog" "dog"
brew_install "duf" "duf"
brew_install "duti" "duti"
brew_install "exa" "exa"
brew_install "fd" "fd"
brew_install "flyctl" "flyctl"
brew_install "fontforge" "fontforge"
brew_install "fx" "fx"
brew_install "fzf" "fzf"
brew_install "gawk" "gawk"
brew_install "gh" "gh"
brew_install "git" "git"
brew_install "htop" "htop"
brew_install "libyaml" "libyaml"
brew_install "mkcert" "mkcert"
brew_install "nss" "nss"
brew_install "openssl" "openssl"
brew_install "pgcli" "pgcli" "" "dbcli/tap"
brew_install "pnpm" "pnpm"
brew_install "postgresql" "postgresql@16"
brew_install "prettyping" "prettyping"
brew_install "pv" "pv"
brew_install "python" "python"
brew_install "reattach-to-user-namespace" "reattach-to-user-namespace"
brew_install "ripgrep" "ripgrep"
brew_install "rtx" "rtx"
brew_install "shared-mime-info" "shared-mime-info"
brew_install "shellcheck" "shellcheck"
brew_install "starship" "starship"
brew_install "tldr" "tldr"
brew_install "tmux" "tmux"
brew_install "tree" "tree"
brew_install "xh" "xh"
brew_install "yarn" "yarn"
brew_install "zoxide" "zoxide"
