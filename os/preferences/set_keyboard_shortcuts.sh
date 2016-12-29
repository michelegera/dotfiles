#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_keyboard_shortcuts() {

  execute "defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 \"{enabled = 1; value = { parameters = (32, 49, 524288); type = 'standard'; }; }\"" \
    "Show Spotlight Search → ⌥ + Space"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  print_in_purple '\n  Keyboard shortcuts\n\n'
  set_keyboard_shortcuts

}

main
