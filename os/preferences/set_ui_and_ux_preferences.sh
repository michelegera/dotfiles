#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_ui_and_ux_preferences() {

  execute 'defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true' \
    'Avoid creating ".DS_Store" files on network volumes'

  execute 'defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true' \
    'Avoid creating ".DS_Store" files on USB drives'

  execute 'defaults write com.apple.menuextra.battery ShowPercent -string "NO"' \
    'Hide battery percentage from the menu bar'

  execute 'defaults write com.apple.LaunchServices LSQuarantine -bool false' \
    'Disable "Are you sure you want to open this application?" dialog'

  execute 'defaults write com.apple.loginwindow TALLogoutSavesState 0' \
    'Disable "Reopen windows when logging back in"'

  execute 'defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true' \
    'Automatically quit the printer app once the print jobs are completed'

  execute 'defaults write com.apple.screencapture location -string "$HOME/Desktop"' \
    'Save screenshots to the Desktop'

  execute 'defaults write com.apple.screencapture type -string "png"' \
    'Save screenshots as PNGs'

  execute 'defaults write com.apple.screencapture include-date -int 0' \
    'Remove date and timestamp from screenshots'

  # Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
  execute 'defaults write -g AppleFontSmoothing -int 2' \
    'Enable subpixel font rendering on non-Apple LCDs'

  execute 'defaults write -g NSDisableAutomaticTermination -bool true' \
    'Disable automatic termination of inactive apps'

  execute 'defaults write -g NSNavPanelExpandedStateForSaveMode -bool true' \
    'Expand save panel by default'

  execute 'defaults write -g NSTableViewDefaultSizeMode -int 2' \
    'Set sidebar icon size to medium'

  execute 'defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false' \
    'Disable resume system-wide'

  execute 'defaults write -g PMPrintingExpandedStateForPrint -bool true' \
    'Expand print panel by default'

  execute 'sudo systemsetup -setrestartfreeze on' \
    'Restart automatically if the computer freezes'

  execute 'sudo pmset -a lidwake 1' \
    'Turns on lid wakeup'

  execute 'sudo pmset -a autorestart 1' \
    'Restart automatically on power loss'

  execute 'sudo pmset -a displaysleep 15' \
    'Put the display to sleep after 15 minutes'

  execute 'sudo pmset -c sleep 0' \
    'Do not allow machine to sleep on charger'

  execute 'sudo pmset -b sleep 5' \
    'Set machine sleep to 5 minutes on battery'

  execute 'sudo systemsetup -setcomputersleep Off' \
    'Never go into computer sleep mode'

  execute 'sudo pmset -a hibernatemode 0' \
    'Disable hibernation'

  execute 'sudo rm /private/var/vm/sleepimage &&
           sudo touch /private/var/vm/sleepimage &&
           sudo chflags uchg /private/var/vm/sleepimage' \
    'Remove the sleep image file to save disk space'

  execute ' for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
              sudo defaults write "${domain}" dontAutoLoad -array \
                "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
                "/System/Library/CoreServices/Menu Extras/Volume.menu"
              done && \

              sudo defaults write com.apple.systemuiserver menuExtras -array \
                "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
                "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
                "/System/Library/CoreServices/Menu Extras/Battery.menu" \
                "/System/Library/CoreServices/Menu Extras/Clock.menu"
            ' \
    'Hide Time Machine and Volume icons from the menu bar'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  print_in_purple '\n  UI & UX\n\n'
  set_ui_and_ux_preferences

}

main
