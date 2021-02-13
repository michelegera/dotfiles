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
./creative_tools.sh
./git.sh
./gpg.sh
./mas.sh
./neovim.sh
./tools.sh
./vscode.sh
