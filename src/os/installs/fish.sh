#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

change_default_shell() {

    local newShellPath=""
    local brewPrefix=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Try to get the path of Fish shell installed through `Homebrew`.

    brewPrefix="$(brew_prefix)" \
        || return 1

    newShellPath="$brewPrefix/bin/fish"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Add the path of Fish shell installed through `Homebrew` to the list of
    # login shells from the `/etc/shells` file.
    #
    # This needs to be done because applications use this file to determine
    # whether a shell is valid (e.g.: `chsh` consults `/etc/shells` to determine
    # whether an unprivileged user may change the login shell for their own
    # account).
    #
    # http://www.linuxfromscratch.org/blfs/view/7.4/postlfs/etcshells.html

    if ! grep "$newShellPath" < /etc/shells &> /dev/null; then
        execute \
            "printf '%s\n' '$newShellPath' | sudo tee -a /etc/shells" \
            "Fish (add '$newShellPath' to '/etc/shells')" \
        || return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Set Fish as the default shell.

    chsh -s "$newShellPath" &> /dev/null
    print_result $? "Fish (set as default)"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Fish\n\n"

    brew_install "Fish" "fish" \
        && change_default_shell

}

main
