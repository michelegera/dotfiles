#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Creative Tools\n\n"

brew_install "Figma" "figma" "--cask"
brew_install "Handbrake" "handbrake" "--cask"
brew_install "Kap" "kap" "--cask"
brew_install "Optimage" "optimage" "--cask"
brew_install "Pika" "pika" "--cask"
brew_install "Sketch" "sketch" "--cask"
brew_install "Sketchpacks" "sketchpacks" "--cask"
