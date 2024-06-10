#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Creative Tools\n\n"

brew_tap "homebrew/cask-versions"

brew_install "Affinity Designer" "affinity-designer"
brew_install "Affinity Photo" "affinity-photo"
brew_install "Affinity Publisher" "affinity-publisher"
brew_install "Figma" "figma"
brew_install "Handbrake" "handbrake"
brew_install "Kap" "kap"
brew_install "Optimage" "optimage"
brew_install "Pika" "pika"
