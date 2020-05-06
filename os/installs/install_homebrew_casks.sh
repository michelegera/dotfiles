#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Homebrew Casks
  # https://github.com/caskroom/homebrew-cask

  if cmd_exists 'brew'; then

    brew_install '1Password' '1password' 'cask'
    brew_install 'A Better Finder Rename' 'a-better-finder-rename' 'cask'
    brew_install 'Adobe Creative Cloud' 'adobe-creative-cloud' 'cask'
    brew_install 'Alfred' 'alfred' 'cask'
    brew_install 'AppCleaner' 'appcleaner' 'cask'
    brew_install 'Arq' 'arq' 'cask'
    brew_install 'Catch' 'catch' 'cask'
    brew_install 'Firefox' 'firefox' 'cask'
    brew_install 'Google Backup & Sync' 'google-backup-and-sync' 'cask'
    brew_install 'Google Chrome' 'google-chrome' 'cask'
    brew_install 'Google Drive File Stream' 'google-drive-file-stream' 'cask'
    brew_install 'Install Disk Creator' 'install-disk-creator' 'cask'
    brew_install 'iTerm2' 'iterm2' 'cask'
    brew_install 'kitty' 'kitty' 'cask'
    brew_install 'Microsoft Office' 'microsoft-office' 'cask'
    brew_install 'NordVPN' 'nordvpn' 'cask'
    brew_install 'NTFS for Mac' 'paragon-ntfs' 'cask'
    brew_install 'Optimage' 'optimage' 'cask'
    brew_install 'Paw' 'paw' 'cask'
    brew_install 'Postico' 'postico' 'cask'
    brew_install 'Sip' 'sip' 'cask'
    brew_install 'Sketch' 'sketch' 'cask'
    brew_install 'Sketchpacks' 'sketchpacks' 'cask'
    brew_install 'Skype' 'skype' 'cask'
    brew_install 'Slack' 'slack' 'cask'
    brew_install 'Spotify Notifications' 'spotify-notifications' 'cask'
    brew_install 'Spotify' 'spotify' 'cask'
    brew_install 'SwiftDefaultApps' 'swiftdefaultappsprefpane' 'cask'
    brew_install 'Telegram Desktop' 'telegram-desktop' 'cask'
    brew_install 'The Unarchiver' 'the-unarchiver' 'cask'
    brew_install 'Tower' 'tower' 'cask'
    brew_install 'Transmission' 'transmission' 'cask'
    brew_install 'Transmit' 'transmit' 'cask'
    brew_install 'Visual Studio Code' 'visual-studio-code' 'cask'
    brew_install 'VLC' 'vlc' 'cask'
    brew_install 'WhatsApp' 'whatsapp' 'cask'
    brew_install 'Zoom.us' 'zoomus' 'cask'
    printf '\n'

    # Fix a quarantine issue
    # https://github.com/Homebrew/homebrew-cask/issues/51646#issuecomment-418885172
    execute 'xattr -r -d com.apple.quarantine /Applications/Firefox.app'
    execute 'xattr -r -d com.apple.quarantine /Applications/Google\ Chrome.app'
    execute 'xattr -r -d com.apple.quarantine /Applications/1Password\ 7.app'

    print_info 'Please run the Adobe Creative Cloud installer'
  fi

}

main
