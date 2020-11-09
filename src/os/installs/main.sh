#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Installs\n"

./xcode.sh
./homebrew.sh
./fish.sh

./git.sh
./browsers.sh
./gpg.sh
./creative_tools.sh
./vscode.sh
./neovim.sh
./applications.sh
./tools.sh
