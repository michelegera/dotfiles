#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Creative Tools\n\n"

brew_tap "homebrew/cask-versions"

brew_install "Affinity Designer v1" "affinity-designer1" "--cask"
brew_install "Affinity Photo v1" "affinity-photo1" "--cask"
brew_install "Affinity Publisher v1" "affinity-publisher1" "--cask"
brew_install "Figma" "figma" "--cask"
brew_install "Handbrake" "handbrake" "--cask"
brew_install "Kap" "kap" "--cask"
brew_install "Optimage" "optimage" "--cask"
brew_install "Pika" "pika" "--cask"
