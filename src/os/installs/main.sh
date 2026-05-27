#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Installs\n\n"

./xcode.sh
./homebrew.sh
./fish.sh

./ai.sh
./applications.sh
./browsers.sh
./communications.sh
./creative_tools.sh
./development.sh
./fonts.sh
./gpg.sh
./system.sh
./tools.sh
./neovim.sh
