#!/bin/bash

# Check that every path referenced by the symbolic link arrays in
# `src/os/create_symbolic_links.sh` actually exists in the repository.
#
# The file is parsed at run time (rather than hardcoding the expected list), so
# the check stays in sync when entries are added, removed or re-ordered.
#
# Note: This is run both locally and in CI.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../src/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -r SYMLINKS_SCRIPT="../src/os/create_symbolic_links.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

get_array_entries() {

    # Print the quoted entries of the `declare -a <name>=( ... )` array whose
    # name is passed as the first argument.

    awk -v name="$1" '
        index($0, "declare -a " name "=(") {
            inArray = 1
        }

        inArray && /^[[:space:]]*\)[[:space:]]*$/ {
            inArray = 0
            next
        }

        inArray {
            line = $0
            sub(/#.*/, "", line)

            while (match(line, /"[^"]*"/)) {
                print substr(line, RSTART + 1, RLENGTH - 2)
                line = substr(line, RSTART + RLENGTH)
            }
        }
    ' "$SYMLINKS_SCRIPT"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

check_array() {

    local arrayName="$1"
    local entry=""
    local missing=0
    local sourcePath=""

    while IFS= read -r entry; do
        [ -n "$entry" ] || continue

        # Both array forms are supported: `<repo path>` (e.g.
        # `git/gitconfig`) and `<repo path>:<path relative to $HOME>` (e.g.
        # `prefs/homebrew/trust.json:.homebrew/trust.json`). Only the part
        # before the first colon is a repository path.

        sourcePath="${entry%%:*}"

        if [ ! -e "../src/$sourcePath" ]; then
            print_error "missing symlink target: src/$sourcePath (referenced by $(basename "$SYMLINKS_SCRIPT"))"
            missing=1
        fi
    done < <(get_array_entries "$arrayName")

    return "$missing"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local exitCode=0

    if [ ! -f "$SYMLINKS_SCRIPT" ]; then
        print_error "File not found: $SYMLINKS_SCRIPT"
        return 1
    fi

    check_array "FILES_TO_SYMLINK" || exitCode=1
    check_array "PATHS_TO_SYMLINK" || exitCode=1

    print_result "$exitCode" "Check symbolic link targets"

    return "$exitCode"

}

main
