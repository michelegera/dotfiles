#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_lunarvim() {

    local script="https://raw.githubusercontent.com/lunarvim/lunarvim/fc6873809934917b470bff1b072171879899a36b/utils/installer/install.sh"

    LV_BRANCH='release-1.2/neovim-0.8' INTERACTIVE_MODE=0 /bin/bash -c "$(curl -s $script)" &> /dev/null

    print_result $? "Install LunarVim"

}

main() {

    print_in_purple "\n   Neovim\n\n"

    brew_install "Neovim" "neovim"

    install_lunarvim

}

main
