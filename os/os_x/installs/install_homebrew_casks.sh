#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh' \
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
    brew_install 'Adobe Creative Cloud' 'adobe-creative-cloud' 'cask'
    brew_install 'Air Video Server HD' 'air-video-server-hd' 'cask'
    brew_install 'Alfred' 'alfred' 'cask'
    brew_install 'AppCleaner' 'appcleaner' 'cask'
    brew_install 'Arq' 'arq' 'cask'
    brew_install 'ChitChat' 'chitchat' 'cask'
    brew_install 'Cocktail' 'cocktail' 'cask'
    brew_install 'Dropbox' 'dropbox' 'cask'
    brew_install 'Evernote' 'evernote' 'cask'
    brew_install 'Firefox' 'firefox' 'cask'
    brew_install 'Google Chrome' 'google-chrome' 'cask'
    brew_install 'Google Drive' 'google-drive' 'cask'
    brew_install 'Heroku Toolbelt' 'heroku-toolbelt' 'cask'
    brew_install 'ImageOptim' 'imageoptim' 'cask'
    brew_install 'iStat Menus' 'istat-menus' 'cask'
    brew_install 'iTerm 2' 'iterm2' 'cask'
    brew_install 'LICEcap' 'licecap' 'cask'
    brew_install 'Limechat' 'limechat' 'cask'
    brew_install 'Little Snitch' 'little-snitch' 'cask'
    brew_install 'MacDown' 'macdown' 'cask'
    brew_install 'Paw' 'paw' 'cask'
    brew_install 'RightFont' 'rightfont' 'cask'
    brew_install 'Sequel Pro' 'sequel-pro' 'cask'
    brew_install 'Skitch' 'skitch' 'cask'
    brew_install 'Skype' 'skype' 'cask'
    brew_install 'Slack' 'slack' 'cask'
    brew_install 'Spectacle' 'spectacle' 'cask'
    brew_install 'Spotify' 'spotify' 'cask'
    brew_install 'Telegram' 'telegram' 'cask'
    brew_install 'TextWrangler' 'textwrangler' 'cask'
    brew_install 'The Unarchiver' 'the-unarchiver' 'cask'
    brew_install 'Things' 'things' 'cask'
    brew_install 'Transmission' 'transmission' 'cask'
    brew_install 'Transmit' 'transmit' 'cask'
    brew_install 'Unsplash Wallpaper' 'unsplash-wallpaper' 'cask'
    brew_install 'Viscosity' 'viscosity' 'cask'
    brew_install 'VLC' 'vlc' 'cask'
    brew_install 'xScope' 'xscope' 'cask'
    printf '\n'

    ask_for_confirmation 'Do you want to install Microsoft Office 2016?'

    if answer_is_yes; then
      brew_install 'Microsoft Office 2016' 'microsoft-office-365' 'cask'
    fi
  fi

}

main
