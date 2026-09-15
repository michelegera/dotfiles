#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# Each entry below is independent and reports its own result, so a single
# failure must not abort the rest of the list.

set +e

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Creative Tools\n\n"

brew_install "Affinity" "affinity"
brew_install "HandBrake" "handbrake-app"
brew_install "Optimage" "optimage"
