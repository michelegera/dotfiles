#!/bin/bash

set -euo pipefail

declare -r GITHUB_REPOSITORY="michelegera/dotfiles"

declare -r DOTFILES_ORIGIN="https://github.com/$GITHUB_REPOSITORY.git"
declare -r DOTFILES_TARBALL_URL="https://github.com/$GITHUB_REPOSITORY/archive/main.tar.gz"
declare -r DOTFILES_UTILS_URL="https://raw.githubusercontent.com/$GITHUB_REPOSITORY/main/src/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

dotfilesDirectory="$HOME/Code/$(whoami)/dotfiles"
declare dotfilesDirectory

declare skipQuestions=false

#  ----------------------------------------------------------------------------
# | Helper Functions                                                           |
#  ----------------------------------------------------------------------------

download() {

    local url="$1"
    local output="$2"

    if command -v "curl" &> /dev/null; then

        curl -LsSo "$output" "$url" &> /dev/null
        #     │││└─ write output to file
        #     ││└─ show error messages
        #     │└─ don't show the progress meter
        #     └─ follow redirects

        return $?

    elif command -v "wget" &> /dev/null; then

        wget -qO "$output" "$url" &> /dev/null
        #     │└─ write output to file
        #     └─ don't show output

        return $?
    fi

    return 1

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# | Why the dotfiles directory is never deleted                                 |
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# The dotfiles directory is not just tracked source files. It also holds local,
# gitignored state that only exists on this machine and cannot be recovered
# once removed:
#
#   - the GPG private keys (src/prefs/gnupg/private-keys-v1.d/*.key), which
#     `~/.gnupg` symlinks to and which are not part of the downloaded archive;
#   - the GitHub OAuth token (src/shell/config/gh/hosts.yml);
#   - the nested nvim repository (src/shell/config/nvim), including any
#     uncommitted changes in it.
#
# Because of that this script never runs `rm -rf` on an existing
# '$dotfilesDirectory'. When the directory is our repository it is updated in
# place (git leaves ignored and untracked files untouched); otherwise it is
# renamed aside so that it stays recoverable. Do not "simplify" this back into
# a deletion.

normalize_git_origin() {

    local origin="$1"

    # Reduce every supported transport form of the same repository to a single
    # canonical URL, so that HTTPS and SSH clones of the dotfiles repository
    # compare equal:
    #
    #   https://github.com/OWNER/REPO.git
    #   https://github.com/OWNER/REPO
    #   git@github.com:OWNER/REPO.git
    #   git@github.com:OWNER/REPO
    #   ssh://git@github.com/OWNER/REPO.git
    #
    # Only an exact match is considered "ours", so the canonical form has to be
    # transport agnostic.

    # Drop a trailing slash and the optional `.git` suffix.
    origin="${origin%/}"
    origin="${origin%.git}"

    # Rewrite the scp-like SSH form (`git@host:owner/repo`) as an HTTPS URL.
    # The colon is replaced before the scheme is prepended, otherwise the first
    # colon seen would be the one of `https://`.
    case "$origin" in
        git@*:*)
            origin="${origin#git@}"
            origin="${origin/:/\/}"
            origin="https://$origin"
            ;;
    esac

    # Rewrite `ssh://git@host/owner/repo` as an HTTPS URL.
    case "$origin" in
        ssh://git@*)
            origin="https://${origin#ssh://git@}"
            ;;
    esac

    printf "%s" "$origin"

}

is_dotfiles_origin() {

    local origin="$1"

    # Both the recorded origin and `$DOTFILES_ORIGIN` are normalised before
    # comparing, because a repository cloned over SSH (`git@github.com:...`)
    # is the same repository as one cloned over HTTPS. A mismatch here is
    # expensive: the directory is classified as "not ours" and moved aside, so
    # the comparison must accept every transport form.

    [ "$(normalize_git_origin "$origin")" == "$(normalize_git_origin "$DOTFILES_ORIGIN")" ]

}

is_dotfiles_repository() {

    local directory="$1"
    local origin=""

    # `-e` (not `-d`) so that git worktrees, where `.git` is a file, are
    # recognised as repositories too.

    [ -e "$directory/.git" ] || return 1
    command -v "git" &> /dev/null || return 1

    origin="$(git -C "$directory" config --get remote.origin.url 2> /dev/null || true)"

    is_dotfiles_origin "$origin"

}

update_dotfiles() {

    local directory="$1"
    local branch=""
    local changes=""
    local stashed=false
    local exitCode=0

    print_in_purple "\n • Update existing dotfiles\n\n"

    git -C "$directory" fetch --all \
        || exitCode=$?

    print_result "$exitCode" "Fetch origin" "true"
    printf "\n"

    [ "$exitCode" -eq 0 ] || return 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Only ever reset `main`.
    #
    # `git reset --hard <commit>` moves the branch that is *currently checked
    # out* to that commit. Running it while e.g. `feature/foo` is checked out
    # would therefore force-move `feature/foo` onto `origin/main`, silently
    # destroying that branch's history. Fetching is harmless, so fetch above
    # and leave every other branch (and a detached `HEAD`) untouched, telling
    # the user what happened and letting them decide. Do not "simplify" this
    # back into an unconditional reset.

    branch="$(git -C "$directory" rev-parse --abbrev-ref HEAD 2> /dev/null || true)"

    if [ "$branch" != "main" ]; then
        print_warning "You are on branch '$branch'; it was left untouched."
        print_info "Only 'main' is updated automatically. Switch to 'main' to update the dotfiles."
        printf "\n"

        cd "$directory/src" \
            || return 1

        return 0
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # `reset --hard` discards uncommitted changes to tracked files. Stash them
    # first, so they stay recoverable with `git stash pop` instead of being
    # lost. A stash is recoverable, a hard reset is not, so even under `--yes`
    # (which skips the confirmation) we stash rather than discard.

    changes="$(git -C "$directory" status --porcelain 2> /dev/null || true)"

    if [ -n "$changes" ]; then

        if ! $skipQuestions; then

            print_warning "The following local changes will be stashed:"
            printf "%s\n\n" "$changes"

            ask_for_confirmation "Continue and stash these changes?"

            if ! answer_is_yes; then
                print_info "Update cancelled — local changes preserved."
                printf "\n"

                cd "$directory/src" \
                    || return 1

                return 0
            fi

        fi

        if git -C "$directory" stash push -u -m "dotfiles-update-$(date +%s)" 1> /dev/null; then

            stashed=true

            print_success "Local changes stashed"
            printf "\n"

        else

            # If the changes cannot be preserved, do not reset: skipping the
            # update keeps the work in place rather than destroying it.
            print_warning "Failed to stash local changes; skipping the reset to avoid discarding them."
            printf "\n"

            cd "$directory/src" \
                || return 1

            return 0

        fi

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    exitCode=0

    git -C "$directory" reset --hard origin/main \
        || exitCode=$?

    print_result "$exitCode" "Reset to origin/main" "true"
    printf "\n"

    if $stashed; then
        print_info "Run 'git stash pop' in '$directory' to restore the stashed changes."
        printf "\n"
    fi

    [ "$exitCode" -eq 0 ] || return 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    cd "$directory/src" \
        || return 1

}

move_dotfiles_directory_aside() {

    local directory="$1"
    local backup=""
    local exitCode=0

    backup="$directory.backup-$(date +%Y%m%d%H%M%S)"

    mv "$directory" "$backup" \
        || exitCode=$?

    print_result "$exitCode" "Move '$directory' aside to '$backup'" "true"
    printf "\n"

    [ "$exitCode" -eq 0 ] || return 1

}

download_dotfiles() {

    local tmpFile=""
    local exitCode=0

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! $skipQuestions; then

        ask_for_confirmation "Do you want to store the dotfiles in '$dotfilesDirectory'?"

        if ! answer_is_yes; then
            dotfilesDirectory=""
            while [ -z "$dotfilesDirectory" ]; do
                ask "Please specify another location for the dotfiles (path): "
                dotfilesDirectory="$(get_answer)"
            done
        fi

        printf "\n"

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Resolve the target directory without ever deleting it (see the note
    # above this function): update our repository in place, and move anything
    # else aside instead of overwriting it. `--yes` only skips the questions,
    # it must never make this destructive.

    while [ -e "$dotfilesDirectory" ]; do

        if is_dotfiles_repository "$dotfilesDirectory"; then
            update_dotfiles "$dotfilesDirectory" \
                || exit 1
            return 0
        fi

        if ! $skipQuestions; then

            ask_for_confirmation "'$dotfilesDirectory' already exists, do you want to move it aside and continue?"

            if ! answer_is_yes; then
                dotfilesDirectory=""
                while [ -z "$dotfilesDirectory" ]; do
                    ask "Please specify another location for the dotfiles (path): "
                    dotfilesDirectory="$(get_answer)"
                done
                continue
            fi

        fi

        move_dotfiles_directory_aside "$dotfilesDirectory" \
            || exit 1

        break

    done

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_purple "\n • Download and extract archive\n\n"

    tmpFile="$(mktemp /tmp/XXXXX)"

    download "$DOTFILES_TARBALL_URL" "$tmpFile" \
        || exitCode=$?

    print_result "$exitCode" "Download archive" "true"
    printf "\n"

    exitCode=0

    mkdir -p "$dotfilesDirectory" \
        || exitCode=$?

    print_result "$exitCode" "Create '$dotfilesDirectory'" "true"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    exitCode=0

    extract "$tmpFile" "$dotfilesDirectory" \
        || exitCode=$?

    print_result "$exitCode" "Extract archive" "true"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    exitCode=0

    rm -rf "$tmpFile" \
        || exitCode=$?

    print_result "$exitCode" "Remove archive"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    cd "$dotfilesDirectory/src" \
        || return 1

}

download_utils() {

    local tmpFile=""

    tmpFile="$(mktemp /tmp/XXXXX)"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Download the utility script. This is a single-file bootstrap: the main
    # tarball is downloaded separately in download_dotfiles(). To mitigate
    # supply-chain risk, perform a basic sanity check before sourcing.

    download "$DOTFILES_UTILS_URL" "$tmpFile" || return 1

    # Sanity check: file must be non-empty and contain expected content.
    # This is not a cryptographic guarantee, but it catches empty files,
    # 404 HTML responses, and obvious corruption.

    if [ ! -s "$tmpFile" ] || ! grep -q "print_success" "$tmpFile"; then
        printf "Downloaded utility script appears corrupted or unexpected.\n"
        rm -rf "$tmpFile"
        return 1
    fi

    . "$tmpFile" \
        && rm -rf "$tmpFile" \
        && return 0

    return 1

}

extract() {

    local archive="$1"
    local outputDir="$2"

    if command -v "tar" &> /dev/null; then
        tar -zxf "$archive" --strip-components 1 -C "$outputDir"
        return $?
    fi

    return 1

}

verify_os() {

    declare -r MINIMUM_MACOS_VERSION="13.0"

    local os_name
    os_name="$(get_os)"

    local os_version
    os_version="$(get_os_version)"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ "$os_name" == "macos" ]; then

        if is_supported_version "$os_version" "$MINIMUM_MACOS_VERSION"; then
            return 0
        else
            printf "Sorry, this script is intended only for macOS %s or later" \
                "$MINIMUM_MACOS_VERSION"
        fi

    else
        printf "Sorry, this script is intended only for macOS"
    fi

    return 1

}

#  ----------------------------------------------------------------------------
# | Main                                                                       |
#  ----------------------------------------------------------------------------

main() {

    # Ensure that the following actions are made relative to this file’s path.

    cd "$(dirname "${BASH_SOURCE[0]:-$0}")" \
        || exit 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Load utils.

    if [ -x "utils.sh" ]; then
        . "utils.sh" \
            || exit 1
    else
        download_utils \
            || exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Clear screen.
    printf "\033c"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Ensure the OS is supported and it’s above the required version.

    verify_os \
        || exit 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    skip_questions "$@" \
        && skipQuestions=true

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ask_for_sudo

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if this script was run directly (./<path>/setup.sh) and if not, it
    # most likely means that dotfiles were not yet set up and they will need to
    # be downloaded.

    printf "%s" "${BASH_SOURCE[0]:-}" | grep "setup.sh" &> /dev/null \
        || download_dotfiles

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./os/create_directories.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./os/create_symbolic_links.sh "$@"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./os/create_local_config_files.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./os/installs/main.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./os/preferences/main.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ./os/set_default_apps.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if cmd_exists "git"; then

        # Compare normalised origins so that a repository cloned over SSH is
        # recognised as ours and is not re-initialised (which would fail with
        # "remote origin already exists").
        if ! is_dotfiles_origin "$(git config --get remote.origin.url 2> /dev/null || true)"; then
            ./os/initialize_git_repository.sh "$DOTFILES_ORIGIN"
        fi

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        if ! $skipQuestions; then
            ./os/update_content.sh
        fi

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! $skipQuestions; then
        ./os/restart.sh
    fi
}

main "$@"
