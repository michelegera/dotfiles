#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# Each entry below is independent and reports its own result, so a single
# failure must not abort the rest of the list.

set +e

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Tools\n\n"

brew_tap "buo/cask-upgrade"

brew_install "bash" "bash"
brew_install "bat" "bat"
brew_install "bottom" "bottom"
brew_install "coreutils" "coreutils"
brew_install "curl" "curl"
brew_install "difftastic" "difftastic"
brew_install "direnv" "direnv"
brew_install "doggo" "doggo"
brew_install "duf" "duf"
brew_install "duti" "duti"
brew_install "eza" "eza"
brew_install "fastfetch" "fastfetch"
brew_install "fd" "fd"
brew_install "ffmpeg" "ffmpeg"
brew_install "fx" "fx"
brew_install "fzf" "fzf"
brew_install "gawk" "gawk"
brew_install "gh" "gh"
brew_install "git" "git"
brew_install "gping" "gping"
brew_install "htop" "htop"
brew_install "jq" "jq"
brew_install "lazygit" "lazygit"
brew_install "libyaml" "libyaml"
brew_install "mas" "mas"
brew_install "mise" "mise"
brew_install "mkcert" "mkcert"
brew_install "nss" "nss"
brew_install "openssl" "openssl"
brew_install "postgresql" "postgresql@17"
brew_install "railway" "railway"
brew_install "redis" "redis"
brew_install "ripgrep" "ripgrep"
brew_install "shared-mime-info" "shared-mime-info"
brew_install "shellcheck" "shellcheck"
brew_install "starship" "starship"
brew_install "stylua" "stylua"
brew_install "tmux" "tmux"
brew_install "tree" "tree"
brew_install "wget" "wget"
brew_install "xh" "xh"
brew_install "zoxide" "zoxide"
