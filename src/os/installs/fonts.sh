#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Fonts\n\n"

# Subversion is required by the `font-source-code-pro-for-powerline` cask

brew_install "Subversion (requirement)" "svn"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install "Source Code Pro for Powerline" "font-source-code-pro-for-powerline" "homebrew/cask-fonts" "cask"
