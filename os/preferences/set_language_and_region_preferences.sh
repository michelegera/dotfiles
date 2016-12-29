#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
    && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_language_and_region_preferences() {

  execute 'defaults write -g AppleLanguages -array "en" "it"' \
    'Set language'

  execute 'defaults write -g AppleLocale -string "en_US@currency=EUR"' \
    'Set locale'

  execute 'defaults write -g AppleMeasurementUnits -string "Centimeters"' \
    'Set measurement units'

  execute 'sudo systemsetup -settimezone "Europe/Rome"' \
    'Set timezone'

  execute 'defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false' \
    'Disable auto-correct'

  execute 'defaults write -g NSUseSpellCheckerForCompletions -bool false' \
    'Disable autocomplete when pressing ESC'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  print_in_purple '\n  Language & Region\n\n'
  set_language_and_region_preferences

}

main
