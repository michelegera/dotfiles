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

  execute 'sudo systemsetup -setnetworktimeserver "time.euro.apple.com" &&
           sudo systemsetup -setusingnetworktime on' \
    'Sync time from network'

  execute 'defaults write -g NSUseSpellCheckerForCompletions -bool false' \
    'Disable autocomplete when pressing ESC'

  execute 'sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true' \
    'Show language menu in the top right corner of the boot screen'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  print_in_purple '\n  Language & Region\n\n'
  set_language_and_region_preferences

}

main
