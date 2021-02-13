#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    # Bash 3 does not support associative arrays, so we use a hack

    declare -a MAS_APPS=(
        "1091189122:Bear"
        "536511979:Characters"
        "1450640351:Lightweight PDF"
        "1464122853:NextDNS"
        "957810159:Raindrop.io for Safari"
        "1529448980:Reeder 5"
        "1176895641:Spark"
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

install_mas() {

    brew_install 'Install mas' 'mas'

    printf "\n"

}

is_signed_into_mas() {

    mas account

}

sign_into_mas() {

    open /System/Applications/App\ Store.app

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until signed into the App Store.

    execute \
        "until is_signed_into_mas; do \
            sleep 5; \
         done" \
        "Sign in"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    osascript -e 'quit app "App Store"'

    printf "\n"

}

main() {

    print_in_purple "\n • Mac App Store\n\n"

    install_mas
    sign_into_mas
    install_apps
}

main
