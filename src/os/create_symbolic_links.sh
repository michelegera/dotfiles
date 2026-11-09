#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# `~/.gnupg` used to be a symbolic link to `src/prefs/gnupg` in this
# repository. That put the GPG private keys, the keybox and the agent sockets
# inside the Git working tree, which the bootstrap deletes before re-creating
# it, making the keys unrecoverable. `~/.gnupg` has to be a real directory, and
# this repository only provides the tracked configuration files.
#
# This migrates an existing link exactly once: the GPG state is moved into a
# staging directory, the link is replaced by that directory, and the
# repository keeps only `gpg.conf`, `gpg-agent.conf` and `.gitignore`. Once
# `~/.gnupg` is a real directory the function is a no-op, so it is safe to run
# on every bootstrap.

migrate_gnupg_out_of_repository() {

    local gnupgDir="$HOME/.gnupg"
    local repoRoot=""
    local resolvedTarget=""
    local stagingDir="$HOME/.gnupg.migrated"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    repoRoot="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)" \
        || return 1

    # Fresh machine: `~/.gnupg` has to be a real directory, never a link.

    if [ ! -e "$gnupgDir" ] && [ ! -L "$gnupgDir" ]; then

        mkdir -p "$gnupgDir" \
            && chmod 700 "$gnupgDir" \
            && print_success "$gnupgDir (created)"

        return $?

    fi

    # Already a real directory: nothing to migrate (idempotent no-op).

    if [ ! -L "$gnupgDir" ]; then
        return 0
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Resolve the link target to an absolute, physical path.

    resolvedTarget="$(cd "$gnupgDir" 2> /dev/null && pwd -P)" \
        || resolvedTarget=""

    # A dangling link holds no state: replace it with a real directory.

    if [ -z "$resolvedTarget" ]; then

        rm "$gnupgDir" \
            && mkdir -p "$gnupgDir" \
            && chmod 700 "$gnupgDir" \
            && print_success "$gnupgDir (created)"

        return $?

    fi

    # Only migrate links that point inside this repository; anything else is
    # the user's own setup and must be left alone.

    case "$resolvedTarget" in
        "$repoRoot"/*) ;;
        *) return 0 ;;
    esac

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Release the agent sockets before moving them. The agent may not be
    # running, so a failure here is not fatal.

    if cmd_exists "gpgconf"; then
        gpgconf --kill gpg-agent &> /dev/null || true
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Refuse to reuse a staging directory: it could already hold private keys
    # from a previous, interrupted run.

    if ! mkdir "$stagingDir"; then
        print_error "$stagingDir (already exists, not overwriting it)"
        return 1
    fi

    chmod 700 "$stagingDir" || return 1

    # Move the GPG state, but keep the repository's tracked files in place.

    if ! find "$resolvedTarget" \
        -mindepth 1 \
        -maxdepth 1 \
        ! -name "gpg.conf" \
        ! -name "gpg-agent.conf" \
        ! -name ".gitignore" \
        -exec mv {} "$stagingDir/" \; ; then

        print_error "$resolvedTarget (could not move the GPG state)"
        return 1

    fi

    # Replace the link with the directory holding the moved state.

    rm "$gnupgDir" \
        && mv "$stagingDir" "$gnupgDir" \
        && chmod 700 "$gnupgDir" \
        && print_success "$gnupgDir (migrated out of the repository)"

    return $?

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_symlinks() {

    declare -a FILES_TO_SYMLINK=(

        "git/gitaliases"
        "git/gitattributes"
        "git/gitconfig"
        "git/gitignore"

        "prefs/duti"

        "shell/bundle"
        "shell/config"
        "shell/curlrc"
        "shell/fdignore"
        "shell/gemrc"
        "shell/hushlogin"
        "shell/inputrc"
        "shell/irbrc"
        "shell/rgignore"
        "shell/screenrc"
        "shell/scripts"
        "shell/ssh"

    )

    # Files whose target is not simply `$HOME/.<basename>`, declared as
    # '<path in this repository>:<path relative to $HOME>'.

    declare -a PATHS_TO_SYMLINK=(

        "prefs/homebrew/trust.json:.homebrew/trust.json"
        "prefs/gnupg/gpg.conf:.gnupg/gpg.conf"

    )

    local i=""
    local sourceFile=""
    local targetFile=""
    local skipQuestions=false

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    skip_questions "$@" \
        && skipQuestions=true

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # This runs before `~/.gnupg/gpg.conf` is linked, so the link always lands
    # in a real directory.

    migrate_gnupg_out_of_repository

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for i in "${FILES_TO_SYMLINK[@]}"; do

        sourceFile="$(cd .. && pwd)/$i"
        targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

        symlink "$sourceFile" "$targetFile" $skipQuestions

    done

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for i in "${PATHS_TO_SYMLINK[@]}"; do

        sourceFile="$(cd .. && pwd)/${i%%:*}"
        targetFile="$HOME/${i##*:}"

        # The parent directory needs to exist before the link is created.

        mkdir -p "$(dirname "$targetFile")" \
            || print_error "$(dirname "$targetFile")"

        symlink "$sourceFile" "$targetFile" $skipQuestions

    done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n • Create symbolic links\n\n"

    create_symlinks "$@"

}

main "$@"
