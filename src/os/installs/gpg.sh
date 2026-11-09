#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# Each entry below is independent and reports its own result, so a single
# failure must not abort the rest of the list.

set +e

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   GPG\n\n"

brew_install "GPG" "gpg"
brew_install "Pinentry" "pinentry-mac"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# `pinentry-program` is executed directly by `gpg-agent`, so it must be an
# absolute path. `Homebrew` lives in `/opt/homebrew` on `Apple Silicon` and in
# `/usr/local` on `Intel`, so the tracked `gpg-agent.conf` is a template that
# gets rendered here into `~/.gnupg`. The rendered file is a real file, not a
# symbolic link, because it embeds a machine-specific path.

detect_brew_prefix() {

    local prefix=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if cmd_exists "brew"; then

        if prefix="$(brew --prefix 2> /dev/null)" && [ -n "$prefix" ]; then
            printf "%s" "$prefix"
            return 0
        fi

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for prefix in "/opt/homebrew" "/usr/local"; do

        if [ -d "$prefix/bin" ]; then
            printf "%s" "$prefix"
            return 0
        fi

    done

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    printf "%s" "/opt/homebrew"

}

render_gpg_agent_config() {

    local brewPrefix=""
    local configFile="$HOME/.gnupg/gpg-agent.conf"
    local exitCode=0
    local sourceFile=""
    local tempFile=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brewPrefix="$(detect_brew_prefix)"
    sourceFile="$(cd "../../prefs/gnupg" && pwd)/gpg-agent.conf"

    # If `~/.gnupg` itself is still a symbolic link (the old layout, before
    # `create_symbolic_links.sh` migrates it), every path below it resolves
    # into the Git working tree. Writing there would overwrite tracked files,
    # so refuse instead of rendering through the link.

    if [ -L "$HOME/.gnupg" ]; then

        print_error "$HOME/.gnupg (symbolic link, run create_symbolic_links.sh first)"
        print_result 1 "$configFile"
        return 1

    fi

    mkdir -p "$HOME/.gnupg" \
        && chmod 700 "$HOME/.gnupg" \
        || exitCode=$?

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # The destination may be an old symbolic link back to the tracked
    # `gpg-agent.conf`. A plain `>` redirect would follow it and overwrite the
    # template in the working tree, so remove the link first (only the link,
    # never its target) and render into a temporary file in the same directory
    # before moving it into place.

    if [ "$exitCode" -eq 0 ] && [ -L "$configFile" ]; then
        rm "$configFile" || exitCode=$?
    fi

    if [ "$exitCode" -eq 0 ]; then

        tempFile="$(mktemp "$HOME/.gnupg/gpg-agent.conf.XXXXXX")" \
            || exitCode=$?

    fi

    if [ "$exitCode" -eq 0 ]; then

        sed "s|%%BREW_PREFIX%%|$brewPrefix|g" \
            "$sourceFile" \
            > "$tempFile" \
                || exitCode=$?

    fi

    if [ "$exitCode" -eq 0 ]; then
        chmod 600 "$tempFile" || exitCode=$?
    fi

    if [ "$exitCode" -eq 0 ]; then
        mv "$tempFile" "$configFile" || exitCode=$?
    fi

    # Never leave a partial file behind on failure.

    if [ "$exitCode" -ne 0 ] && [ -n "$tempFile" ]; then
        rm -f "$tempFile"
    fi

    print_result "$exitCode" "$configFile"

}

render_gpg_agent_config
