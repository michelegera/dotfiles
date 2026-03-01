#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Fonts\n\n"

brew_install "San Francisco Mono Nerd Font Ligaturized" "font-sf-mono-nerd-font-ligaturized" "--cask"
brew_install "Lilex Nerd Font" "font-lilex-nerd-font" "--cask"
