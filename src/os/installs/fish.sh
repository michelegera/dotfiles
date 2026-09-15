#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

change_default_shell() {

    local newShellPath=""
    local brewPrefix=""
    local exitCode=0

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
    #
    # `chsh` prompts for a password, so its output must not be discarded
    # silently and its exit code must not abort the script.

    if [ "$SHELL" == "$newShellPath" ]; then
        print_success "Fish (set as default)"
        return 0
    fi

    chsh -s "$newShellPath" \
        || exitCode=$?

    print_result "$exitCode" "Fish (set as default)"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_fisher() {

    local exitCode=0

    local script="curl -sL git.io/fisher | source && \
        fisher install jorgebucaran/fisher"

    # Fisher needs network access, so a failure must be reported instead of
    # aborting the script through `set -e`.

    fish -c "$script" &> /dev/null \
        || exitCode=$?

    print_result "$exitCode" "Fisher"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Fish\n\n"

    brew_install "Fish" "fish" \
        && change_default_shell \
        && install_fisher

}

main
