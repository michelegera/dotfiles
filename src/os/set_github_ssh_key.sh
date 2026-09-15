#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_ssh_configs() {

    local exitCode=0

    printf "%s\n" \
        "Host github.com" \
        "  IdentityFile $1" \
        "  LogLevel ERROR" >> ~/.ssh/config \
        || exitCode=$?

    print_result "$exitCode" "Add SSH configs"

}

copy_public_ssh_key_to_clipboard () {

    local exitCode=0

    if cmd_exists "pbcopy"; then

        pbcopy < "$1" \
            || exitCode=$?

        print_result "$exitCode" "Copy public SSH key to clipboard"

    else
        print_warning "Please copy the public SSH key ($1) to clipboard"
    fi

}

generate_ssh_keys() {

    local exitCode=0

    ask "Please provide an email address: " && printf "\n"

    # `ssh-keygen` is interactive, so a failure must be reported instead of
    # aborting the script through `set -e`.

    ssh-keygen -t ed25519 -C "$(get_answer)" -f "$1" \
        || exitCode=$?

    print_result "$exitCode" "Generate SSH keys"

    return "$exitCode"

}

open_github_ssh_page() {

    declare -r GITHUB_SSH_URL="https://github.com/settings/ssh"

    if cmd_exists "open"; then
        open "$GITHUB_SSH_URL"
    else
        print_warning "Please add the public SSH key to GitHub ($GITHUB_SSH_URL)"
    fi

}

set_github_ssh_key() {

    local sshKeyFileName="$HOME/.ssh/github"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If there is already a file with that name, generate another, unique, file
    # name.

    if [ -f "$sshKeyFileName" ]; then
        sshKeyFileName="$(mktemp -u "$HOME/.ssh/github_XXXXX")"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    generate_ssh_keys "$sshKeyFileName"
    add_ssh_configs "$sshKeyFileName"
    copy_public_ssh_key_to_clipboard "${sshKeyFileName}.pub"
    open_github_ssh_page
    test_ssh_connection \
        && rm "${sshKeyFileName}.pub"

}

test_ssh_connection() {

    local exitCode=0

    while true; do

        # `ssh -T git@github.com` exits with 1 once the key is authorized,
        # since GitHub does not provide shell access.

        exitCode=0

        ssh -T git@github.com &> /dev/null \
            || exitCode=$?

        [ "$exitCode" -eq 1 ] && break

        sleep 5

    done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local exitCode=0
    local sshExitCode=0

    print_in_purple "\n • Set up GitHub SSH keys\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! is_git_repository; then
        print_error "Not a Git repository"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # `ssh -T git@github.com` exits with 1 when the key is already authorized,
    # since GitHub does not provide shell access. Anything else means the keys
    # still need to be set up.

    ssh -T git@github.com &> /dev/null \
        || sshExitCode=$?

    if [ "$sshExitCode" -ne 1 ]; then
        set_github_ssh_key \
            || exitCode=$?
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_result "$exitCode" "Set up GitHub SSH keys"

}

main
