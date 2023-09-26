#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   System\n\n"

brew_install "Logi Options +" "logi-options-plus"
brew_install "Rode Connect" "rode-connect"
