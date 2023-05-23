#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_lazyvim() {

    git clone https://github.com/LazyVim/starter ~/.config/nvim && \
    rm -rf ~/.config/nvim/.git &> /dev/null

    print_result $? "Install LazyVim"

}

main() {

    print_in_purple "\n   Neovim\n\n"

    brew_install "Neovim" "neovim"

    install_lazyvim

}

main
