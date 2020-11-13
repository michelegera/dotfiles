#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

mas_install() {

    # Bash 3 does not support associative arrays, so we use a hack

    declare -a MAS_APPS=(
        "1091189122:Bear"
        "536511979:Characters"
        "1450640351:Lightweight PDF"
        "441258766:Magnet"
        "957810159:Raindrop.io for Safari"
        "1529448980:Reeder 5"
        "1176895641:Spark"
        "1384080005:Tweetbot"
    )


    local appID=""
    local appName=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for app in "${MAS_APPS[@]}" ; do

        appID="${app%%:*}"
        appName="${app##*:}"

        execute "mas install $appID" "$appName"
    done

}


mas_signin() {

    local appleIDEmail=""
    local appleIDPassword=""

    while [ -z "$appleIDEmail" ]; do
        ask "Please type your Apple ID email: "
        appleIDEmail="$(get_answer)"
    done

    while [ -z "$appleIDPassword" ]; do
        ask_for_password "Please type your Apple ID password: " && printf "\n"
        appleIDPassword="$(get_answer)"
    done

    mas signout &> /dev/null
    mas signin "$appleIDEmail" "$appleIDPassword" &> /dev/null

    print_result $? "Sign in"
}

main() {

    print_in_purple "\n • Mac App Store\n\n"

    mas_signin
    mas_install

}

main
