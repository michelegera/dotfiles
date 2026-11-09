#!/bin/bash

# Check that the repository's own Fish files are formatted with `fish_indent`.
#
# Note: This is meant to be run locally only, NOT in CI. `fish_indent`'s output
# changes between Fish releases, so a format gate in CI would be flaky across
# the Fish version shipped by `ubuntu-latest` and the one installed on a macOS
# development machine.
#
# Vendored files are skipped: `fisher.fish` (both the function and the
# completion) is a copy of upstream Fisher, so reformatting it would create
# churn on every upstream update.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../src/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -a VENDORED_FILES=(
    "src/shell/config/fish/functions/fisher.fish"
    "src/shell/config/fish/completions/fisher.fish"
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

is_vendored() {

    local file=""

    for file in "${VENDORED_FILES[@]}"; do
        if [ "$1" = "$file" ]; then
            return 0
        fi
    done

    return 1

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local -a filesToCheck=()
    local exitCode=0
    local file=""

    if ! cmd_exists "fish_indent"; then
        print_error "fish_indent is not installed"
        return 1
    fi

    while IFS= read -r file; do
        filesToCheck+=("$file")
    done < <(git -C .. ls-files '*.fish')

    for file in "${filesToCheck[@]}"; do
        if is_vendored "$file"; then
            print_warning "skipped (vendored): $file"
            continue
        fi

        if ! fish_indent --check "../$file"; then
            print_error "not formatted: $file"
            exitCode=1
        fi
    done

    print_result "$exitCode" "Check Fish formatting"

    return "$exitCode"

}

main
