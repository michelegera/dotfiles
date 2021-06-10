#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Creative Tools\n\n"

brew_install "Kap" "kap" "homebrew/cask" "cask"
brew_install "Optimage" "optimage" "homebrew/cask" "cask"
brew_install "Sketch" "sketch" "homebrew/cask" "cask"
brew_install "Sketchpacks" "sketchpacks" "homebrew/cask" "cask"
