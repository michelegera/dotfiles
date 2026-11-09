#!/bin/bash

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../src/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local -a filesToCheck=()
    local exitCode=0
    local file=""

    # Lint every shell script under `src/` and `tests/`, plus any shell scripts
    # kept directly at the repository root (e.g. `setup.sh`), if there are any.
    #
    # Exclusions:
    #   * `*.applescript` files are not shell scripts.
    #   * `brew_local_allowlist` is a plain list, not a shell script.
    #   * `utils/` is a vendored helper (see `utils/README.md`), not project
    #     code, so it is not ours to lint.
    #   * `src/shell/config/tmux/plugins/` and `src/shell/config/opencode/skills/`
    #     hold vendored, git-ignored third-party code, not project code.

    while IFS= read -r -d '' file; do
        filesToCheck+=("$file")
    done < <(
        find \
            ../src \
            ../tests \
            -type f \
            \( -name '*.sh' -o -path '*/shell/scripts/*' \) \
            ! -path '../src/os/preferences/*.applescript' \
            ! -name 'brew_local_allowlist' \
            ! -path '../utils/*' \
            ! -path '../src/shell/config/tmux/plugins/*' \
            ! -path '../src/shell/config/opencode/skills/*' \
            -print0
    )

    while IFS= read -r -d '' file; do
        filesToCheck+=("$file")
    done < <(find .. -maxdepth 1 -type f -name '*.sh' -print0)

    shellcheck \
        -e SC1090 \
        -e SC1091 \
        "${filesToCheck[@]}" \
        || exitCode=$?

    print_result "$exitCode" "Run code through ShellCheck"

    return "$exitCode"

}

main
