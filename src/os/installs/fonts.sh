#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Fonts\n\n"

brew_tap "shaunsingh/SFMono-Nerd-Font-Ligaturized"

brew_install "SF Mono Nerd Font Ligaturized" "font-sf-mono-nerd-font-ligaturized" "--cask"
