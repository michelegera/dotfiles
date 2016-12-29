#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_finder_preferences() {

  execute 'defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true &&
           defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true &&
           defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true' \
    'Automatically open a new Finder window when a volume is mounted'

  execute 'defaults write com.apple.finder WarnOnEmptyTrash -bool false' \
    'Disable the warning before emptying the Trash'

  execute 'defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"' \
    'Search the current directory by default'

  execute 'defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false' \
    'Disable warning when changing a file extension'

  execute 'defaults write com.apple.finder _FXSortFoldersFirst -bool true' \
    'Keep folders on top when sorting by name'

  # View modes
  # clmv = Column
  # Flwv = Coverflow
  # icnv = Icon
  # Nlsv = List
  execute 'defaults write com.apple.finder FXPreferredViewStyle -string "clmv"' \
    'Use column view in all Finder windows by default'

  execute 'defaults write com.apple.finder ShowStatusBar -bool true' \
    'Show status bar'

  execute 'defaults write com.apple.finder NewWindowTarget -string "PfDe" &&
           defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"' \
    'Set home directory as the default location for new Finder windows'

  execute 'defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true &&
           defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true &&
           defaults write com.apple.finder ShowMountedServersOnDesktop -bool true &&
           defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true' \
    'Show icons for hard drives, servers, and removable media on the desktop'

  execute 'defaults write com.apple.finder ShowRecentTags -bool false' \
    'Do not show recent tags'

  execute 'defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false' \
    'Disable reopening windows when logging back in'

  execute '/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 60" ~/Library/Preferences/com.apple.finder.plist &&
           /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 60" ~/Library/Preferences/com.apple.finder.plist' \
    'Set icon size'

  execute '/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 1" ~/Library/Preferences/com.apple.finder.plist &&
           /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 1" ~/Library/Preferences/com.apple.finder.plist' \
    'Set icon grid spacing size'

  execute '/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:textSize 12" ~/Library/Preferences/com.apple.finder.plist &&
           /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:textSize 12" ~/Library/Preferences/com.apple.finder.plist' \
    'Set icon label text size'

  execute '/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:labelOnBottom true" ~/Library/Preferences/com.apple.finder.plist &&
           /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:labelOnBottom true" ~/Library/Preferences/com.apple.finder.plist' \
    'Set icon label position'

  execute '/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist &&
           /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist' \
    'Set sort method'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  print_in_purple '\n  Finder\n\n'
  set_finder_preferences

  killall 'Finder' &> /dev/null

}

main
