#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Bash 3 does not support associative arrays, so we use a hack

declare -a MAS_APPS=(
  '918858936:Airmail 3'
  '649835201:AppSana'
  '536511979:Characters'
  '449589707:Dash'
  '924726344:Deliveries'
  '1082624744:Gifox'
  '1039633667:Irvue'
  '409183694:Keynote'
  '880001334:Reeder'
  '507257563:Sip'
  '557168941:Tweetbot'
  '417701035:VidConvert'
  '1000397973:Wallcat'
  '497799835:Xcode'
)

main() {

  APPLE_ID_EMAIL=''
  while [ -z "$APPLE_ID_EMAIL" ]; do
    ask 'Please type your Apple ID email: '
    APPLE_ID_EMAIL="$(get_answer)"
  done

  APPLE_ID_PASSWORD=''
  while [ -z "$APPLE_ID_PASSWORD" ]; do
    ask_for_password 'Please type your Apple ID password: '
    APPLE_ID_PASSWORD="$(get_answer)"
  done

  printf '\n'

  mas signout
  mas signin $APPLE_ID_EMAIL $APPLE_ID_PASSWORD

  for app in "${MAS_APPS[@]}" ; do
    ID="${app%%:*}"
    NAME="${app##*:}"
    execute "mas install $ID" "$NAME"
  done

  printf '\n'

  print_result $? 'Install Mac App Store applications'

}

main
