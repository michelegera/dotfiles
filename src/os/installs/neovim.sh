#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_lazyvim() {
    declare -r NVIM_DIRECTORY="$HOME/.config/nvim"

    # Clone the repository into an non-empty directory
    git -C "$NVIM_DIRECTORY" init &> /dev/null
    git -C "$NVIM_DIRECTORY" remote add origin https://github.com/LazyVim/starter &> /dev/null
    git -C "$NVIM_DIRECTORY" fetch &> /dev/null
    git -C "$NVIM_DIRECTORY" checkout origin/main &> /dev/null
    rm -rf "$NVIM_DIRECTORY/.git" &> /dev/null

    print_result $? "Install LazyVim"

}

main() {

    print_in_purple "\n   Neovim\n\n"

    brew_install "Neovim" "neovim"

    install_lazyvim

}

main
