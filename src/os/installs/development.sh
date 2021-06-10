#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Development\n\n"

brew_install "OpenJDK 8" "adoptopenjdk/openjdk/adoptopenjdk8" "adoptopenjdk/openjdk" "cask"
brew_install "Paw" "paw" "homebrew/cask" "cask"
brew_install "Sequel Pro (Nightly)" "sequel-pro-nightly" "homebrew/cask-versions" "cask"
brew_install "Tower" "tower" "homebrew/cask" "cask"
