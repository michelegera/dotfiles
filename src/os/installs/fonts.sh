#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# Each entry below is independent and reports its own result, so a single
# failure must not abort the rest of the list.

set +e

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Fonts\n\n"

brew_install "San Francisco Mono Nerd Font Ligaturized" "font-sf-mono-nerd-font-ligaturized" "--cask"
brew_install "Lilex Nerd Font" "font-lilex-nerd-font" "--cask"
