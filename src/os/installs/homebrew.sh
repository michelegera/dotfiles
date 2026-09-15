#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_to_path() {

    local exitCode=0

    # Check if `brew` is available.

    if command -v brew &> /dev/null; then
        return 0
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If not, add it to the PATH.
    #
    # `utils.sh` already does this when it is sourced, but `brew` did not exist
    # yet at that point on a machine where it was just installed.

    add_homebrew_to_path

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Inform the user about the availability of `brew`.
    #
    # `command -v` must not abort the script through `set -e`, otherwise a
    # missing `brew` exits silently without reporting anything.

    command -v brew &> /dev/null \
        || exitCode=1

    print_result "$exitCode" "Add to PATH"
}

get_git_config_file_path() {

    local repository=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Only the command substitution can fail here, so it needs to be checked
    # on its own. Testing the whole assignment would always succeed.

    if repository="$(brew --repository 2> /dev/null)" && [ -n "$repository" ]; then
        printf "%s" "$repository/.git/config"
        return 0
    else
        print_error "Get config file path"
        return 1
    fi

}

install() {

    local exitCode=0
    local tmpFile=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Nothing to do if `brew` is already installed.

    if cmd_exists "brew"; then
        print_success "Install"
        return 0
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ask_for_sudo

    tmpFile="$(mktemp /tmp/XXXXX)"

    # `NONINTERACTIVE=1` is the documented way to run the installer without
    # prompting. Keep `stdin` attached so the installer can still use `sudo`.

    NONINTERACTIVE=1 /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
        > "$tmpFile" 2>&1 \
        || exitCode=$?

    print_result "$exitCode" "Install" \
        || print_error_stream < "$tmpFile"

    rm -rf "$tmpFile"

    return "$exitCode"

}

opt_out_of_analytics() {

    local path=""
    local exitCode=0

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Try to get the path of the `Homebrew` git config file.

    path="$(get_git_config_file_path)" \
        || return 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Opt-out of Homebrew's analytics.
    #
    # https://git.io/JThIQ

    if [ "$(git config --file="$path" --get homebrew.analyticsdisabled)" != "true" ]; then

        git config --file="$path" --replace-all homebrew.analyticsdisabled true &> /dev/null \
            || exitCode=$?

        print_result "$exitCode" "Opt-out of analytics"

    fi

}

update() {
    execute \
        "brew update" \
        "Update"
}

upgrade() {
    execute \
        "brew upgrade" \
        "Upgrade"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Homebrew\n\n"

    # Without `brew` on the PATH every subsequent step is meaningless, so bail
    # out early and loudly instead of reporting success.

    install \
        || return 1

    add_to_path \
        || return 1

    opt_out_of_analytics

    update
    upgrade
}

main
