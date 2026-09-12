#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   System\n\n"

brew_install "Mole" "mole"
brew_install "OpenLogi" "openlogi"
brew_install "Rode Connect" "rode-connect"
