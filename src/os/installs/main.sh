#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Installs\n\n"

./xcode.sh
./homebrew.sh
./fish.sh

./applications.sh
./browsers.sh
./communications.sh
./creative_tools.sh
./development.sh
./fonts.sh
./git.sh
./gpg.sh
./neovim.sh
./system.sh
./tools.sh
./vscode.sh
