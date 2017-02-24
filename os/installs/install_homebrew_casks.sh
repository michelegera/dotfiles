#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Homebrew Casks
  # https://github.com/caskroom/homebrew-cask

  if cmd_exists 'brew' \
    && brew_tap 'caskroom/cask'; then

    brew_install 'Homebrew Cask' 'caskroom/cask/brew-cask'
    printf '\n'

    brew_install '1Password' '1password' 'cask'
    brew_install 'A Better Finder Rename' 'a-better-finder-rename' 'cask'
    brew_install 'Adobe Creative Cloud' 'adobe-creative-cloud' 'cask'
    brew_install 'Alfred' 'alfred' 'cask'
    brew_install 'AppCleaner' 'appcleaner' 'cask'
    brew_install 'Arq' 'arq' 'cask'
    brew_install 'Atom' 'atom' 'cask'
    brew_install 'Cocktail' 'cocktail' 'cask'
    brew_install 'Dropbox' 'dropbox' 'cask'
    brew_install 'Evernote' 'evernote' 'cask'
    brew_install 'Firefox' 'firefox' 'cask'
    brew_install 'ForkLift' 'forklift' 'cask'
    brew_install 'Gitscout' 'gitscout' 'cask'
    brew_install 'Google Chrome' 'google-chrome' 'cask'
    brew_install 'Google Drive' 'google-drive' 'cask'
    brew_install 'GPG Tools' 'gpgtools' 'cask'
    brew_install 'Hyper' 'hyper' 'cask'
    brew_install 'ImageOptim' 'imageoptim' 'cask'
    brew_install 'Install Disk Creator' 'install-disk-creator' 'cask'
    brew_install 'iStat Menus' 'istat-menus' 'cask'
    brew_install 'Limechat' 'limechat' 'cask'
    brew_install 'Little Snitch' 'little-snitch' 'cask'
    brew_install 'Paw' 'paw' 'cask'
    brew_install 'Postico' 'postico' 'cask'
    brew_install 'RightFont' 'rightfont' 'cask'
    brew_install 'Sequel Pro' 'sequel-pro' 'cask'
    brew_install 'Skitch' 'skitch' 'cask'
    brew_install 'Skype' 'skype' 'cask'
    brew_install 'Slack' 'slack' 'cask'
    brew_install 'Spectacle' 'spectacle' 'cask'
    brew_install 'Spotify' 'spotify' 'cask'
    brew_install 'Spotify Notifications' 'spotify-notifications' 'cask'
    brew_install 'Telegram Desktop' 'telegram-desktop' 'cask'
    brew_install 'TextWrangler' 'textwrangler' 'cask'
    brew_install 'The Unarchiver' 'the-unarchiver' 'cask'
    brew_install 'Things' 'things' 'cask'
    brew_install 'Transmission' 'transmission' 'cask'
    brew_install 'Viscosity' 'viscosity' 'cask'
    brew_install 'VLC' 'vlc' 'cask'
    brew_install 'WhatsApp' 'whatsapp' 'cask'
    brew_install 'xScope' 'xscope' 'cask'
    brew_install 'Zoom.us' 'zoomus' 'cask'
    printf '\n'

    ask_for_confirmation 'Do you want to install Microsoft Office 2016?'

    if answer_is_yes; then
      brew_install 'Microsoft Office 2016' 'microsoft-office' 'cask'
    fi
  fi

}

main
