#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Language & Region\n\n"

execute "defaults write -g AppleLanguages -array 'en' 'it'" \
    "Set language"

execute "defaults write -g AppleLocale -string 'en_US@currency=EUR'" \
    "Set locale"

execute "defaults write -g AppleMeasurementUnits -string 'Centimeters'" \
    "Set measurement units"

execute "sudo systemsetup -settimezone 'Europe/Rome'" \
    "Set timezone"
