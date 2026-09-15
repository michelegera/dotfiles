#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# Each entry below is independent and reports its own result, so a single
# failure must not abort the rest of the list.

set +e

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Development\n\n"

brew_install "Bruno" "bruno"
brew_install "Medis" "medis"
brew_install "Postico" "postico"
brew_install "Tuicr" "tuicr"
brew_install "Workmux" "workmux" "" "raine/workmux"
brew_install "Zed" "zed"
