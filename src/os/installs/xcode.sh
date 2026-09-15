#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

agree_with_xcode_licence() {

    local exitCode=0

    # Automatically agree to the terms of the `Xcode` license.
    #
    # https://github.com/alrra/dotfiles/issues/10
    #
    # The exit code needs to be captured so that a failure is reported instead
    # of aborting the script through `set -e`.

    sudo xcodebuild -license accept &> /dev/null \
        || exitCode=$?

    print_result "$exitCode" "Agree to the terms of the Xcode licence"

}

are_xcode_command_line_tools_installed() {
    xcode-select --print-path &> /dev/null
}

install_xcode() {

    # If necessary, prompt user to install `Xcode`.

    if ! is_xcode_installed; then
        open "macappstores://itunes.apple.com/en/app/xcode/id497799835"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until `Xcode` is installed.

    execute \
        "until is_xcode_installed; do \
            sleep 5; \
         done" \
        "Xcode"

}

install_xcode_command_line_tools() {

    # If necessary, prompt user to install the `Xcode Command Line Tools`.
    #
    # `xcode-select --install` exits with a non-zero code when the tools are
    # already installed, so its failure must not abort the script.

    if ! are_xcode_command_line_tools_installed; then
        xcode-select --install &> /dev/null || true
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the `Xcode Command Line Tools` are installed.

    execute \
        "until are_xcode_command_line_tools_installed; do \
            sleep 5; \
         done" \
        "Xcode Command Line Tools"

}

is_xcode_installed() {
    [ -d "/Applications/Xcode.app" ] || [ -d "/Applications/Xcode-beta.app" ]
}

set_xcode_developer_directory() {

    local developerDirectory=""
    local exitCode=0

    # Point the `xcode-select` developer directory to the appropriate directory
    # from within `Xcode`.
    #
    # https://github.com/alrra/dotfiles/issues/13

    # `Xcode.app` takes precedence over `Xcode-beta.app`, as it did when both
    # switches ran one after the other.

    if [ -d "/Applications/Xcode-beta.app" ]; then
        developerDirectory="/Applications/Xcode-beta.app/Contents/Developer"
    fi

    if [ -d "/Applications/Xcode.app" ]; then
        developerDirectory="/Applications/Xcode.app/Contents/Developer"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # The exit code of `xcode-select` needs to be captured directly, otherwise
    # the result of the checks above would be reported instead.

    if [ -z "$developerDirectory" ]; then
        print_error "Make 'xcode-select' developer directory point to the appropriate directory from within Xcode"
        return 1
    fi

    sudo xcode-select -switch "$developerDirectory" &> /dev/null \
        || exitCode=$?

    print_result "$exitCode" "Make 'xcode-select' developer directory point to the appropriate directory from within Xcode"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "   Xcode\n\n"

    install_xcode_command_line_tools
    install_xcode
    set_xcode_developer_directory
    agree_with_xcode_licence

}

main
