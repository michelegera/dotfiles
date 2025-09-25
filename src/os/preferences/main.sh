#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Close any open `System Preferences` panes in order to
# avoid overriding the preferences that are being changed.

./close_system_preferences_panes.applescript

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./app_store.sh
./chrome.sh
./dock.sh
./finder.sh
./firefox.sh
./keyboard.sh
./language_and_region.sh
./maps.sh
./miscellaneous.sh
./photos.sh
./security_and_privacy.sh
./textedit.sh
./trackpad_and_mouse.sh
./transmission.sh
./ui_and_ux.sh
