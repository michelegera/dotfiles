#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_keyboard_preferences() {

  execute 'defaults write -g AppleKeyboardUIMode -int 3' \
    'Enable full keyboard access for all controls'

  execute 'defaults write -g ApplePressAndHoldEnabled -bool false' \
    'Disable press-and-hold in favor of key repeat'

  execute 'defaults write -g InitialKeyRepeat -int 10' \
    'Set delay until repeat'

  execute 'defaults write -g KeyRepeat -int 1' \
    'Set the key repeat rate to fast'

  execute 'defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false' \
    'Disable smart quotes'

  execute 'defaults write -g NSAutomaticDashSubstitutionEnabled -bool false' \
    'Disable smart dashes'

  execute 'defaults write -g NSAutomaticCapitalizationEnabled -bool false' \
    'Disable automatic capitalization'

  execute 'defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false' \
    'Disable automatic period substitution'

  execute 'defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false' \
    'Disable auto-correct'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  print_in_purple '\n  Keyboard\n\n'
  set_keyboard_preferences

}

main
