#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Make `brew` available to every install script.
#
# `main.sh` runs each install script as a separate process, so the PATH that
# `homebrew.sh` sets up is gone by the time the next script starts. Adding the
# `Homebrew` directory here means all of them can find `brew`, no matter which
# one runs first.

add_homebrew_to_path() {

    local prefix=""

    for prefix in "/opt/homebrew" "/usr/local"; do

        if [ -x "$prefix/bin/brew" ]; then

            case ":$PATH:" in
                *":$prefix/bin:"*) ;;
                *) PATH="$prefix/bin:$PATH" && export PATH ;;
            esac

            return 0

        fi

    done

    return 0

}

add_homebrew_to_path

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install() {

    declare -r ARGUMENTS="${3:-}"
    declare -r FORMULA="$2"
    declare -r FORMULA_READABLE_NAME="$1"
    declare -r TAP_VALUE="${4:-}"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Homebrew` is installed.

    if ! cmd_exists "brew"; then
        print_error "$FORMULA_READABLE_NAME ('Homebrew' is not installed)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If `brew tap` needs to be executed, check if it executed correctly.

    if [ -n "$TAP_VALUE" ]; then
        if ! brew_tap "$TAP_VALUE"; then
            print_error "$FORMULA_READABLE_NAME ('brew tap $TAP_VALUE' failed)"
            return 1
        fi
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the specified formula.

    # shellcheck disable=SC2086
    if brew list "$FORMULA" &> /dev/null; then
        print_success "$FORMULA_READABLE_NAME"
    else
        execute \
            "brew install $FORMULA $ARGUMENTS" \
            "$FORMULA_READABLE_NAME"
    fi

}

brew_prefix() {

    local path=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if path="$(brew --prefix 2> /dev/null)"; then
        printf "%s" "$path"
        return 0
    else
        print_error "Homebrew (get prefix)"
        return 1
    fi

}

brew_tap() {
    brew tap "$1" &> /dev/null
}

brew_update() {

    execute \
        "brew update" \
        "Homebrew (update)"

}

brew_upgrade() {

    execute \
        "brew upgrade" \
        "Homebrew (upgrade)"

}

mas_install() {

    declare -r APP_ID="$2"
    declare -r APP_READABLE_NAME="$1"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `mas` is installed.

    if ! cmd_exists "mas"; then
        print_error "$APP_READABLE_NAME ('mas' is not installed)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the specified application.
    #
    # Note: This requires being signed in to the App Store, and the app
    # needs to have been previously obtained with the signed-in account.
    #
    # `MAS_NO_AUTO_INDEX=1` prevents `mas` from triggering Spotlight
    # indexing of App Store apps and printing noisy warnings about it.

    if MAS_NO_AUTO_INDEX=1 mas list | awk '{ print $1 }' | grep -qx "$APP_ID"; then
        print_success "$APP_READABLE_NAME"
    else
        execute \
            "MAS_NO_AUTO_INDEX=1 mas install $APP_ID" \
            "$APP_READABLE_NAME"
    fi

}
