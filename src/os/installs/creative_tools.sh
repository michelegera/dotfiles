#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Creative Tools\n\n"

brew_tap "homebrew/cask-versions"

brew_install "Affinity Designer v1" "affinity-designer1"
brew_install "Affinity Photo v1" "affinity-photo1"
brew_install "Affinity Publisher v1" "affinity-publisher1"
brew_install "Figma" "figma"
brew_install "Handbrake" "handbrake"
brew_install "Kap" "kap"
brew_install "Optimage" "optimage"
brew_install "Pika" "pika"
