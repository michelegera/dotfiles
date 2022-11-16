#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Development\n\n"

brew_install "Postico" "postico" "--cask"
brew_install "RapidAPI" "rapidapi" "--cask"
brew_install "Tower" "tower" "--cask"
