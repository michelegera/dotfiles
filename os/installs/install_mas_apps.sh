#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Bash 3 does not support associative arrays, so we use a hack

declare -a MAS_APPS=(
  '649835201:AppSana'
  '1091189122:Bear'
  '536511979:Characters'
  '1287239339:ColorSlurp'
  '1082624744:Gifox'
  '1039633667:Irvue'
  '409183694:Keynote'
  '1450640351:Lightweight PDF'
  '1084713122:Markoff'
  '880001334:Reeder'
  '1176895641:Spark'
  '1187772509:stts'
  '1384080005:Tweetbot 3'
  '497799835:Xcode'
)

main() {

  # Temporary commented out, see https://github.com/mas-cli/mas/issues/164

  # APPLE_ID_EMAIL=''
  # while [ -z "$APPLE_ID_EMAIL" ]; do
  #  ask 'Please type your Apple ID email: '
  #  APPLE_ID_EMAIL="$(get_answer)"
  # done

  # APPLE_ID_PASSWORD=''
  # while [ -z "$APPLE_ID_PASSWORD" ]; do
  #  ask_for_password 'Please type your Apple ID password: '
  #  APPLE_ID_PASSWORD="$(get_answer)"
  # done

  # printf '\n'

  # mas signout &> /dev/null
  # mas signin $APPLE_ID_EMAIL $APPLE_ID_PASSWORD &> /dev/null

  login_to_mas

  for app in "${MAS_APPS[@]}" ; do
    ID="${app%%:*}"
    NAME="${app##*:}"
    execute "mas install $ID" "$NAME"
  done

  sudo xcodebuild -license accept &> /dev/null

  printf '\n'

  print_result $? 'Install Mac App Store applications'

}

main
