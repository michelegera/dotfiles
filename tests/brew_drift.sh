#!/bin/bash

# Checks for drift between the packages declared in the install scripts
# and what is actually installed through Homebrew / `mas` on this machine.
#
# The two directions that are reported mean different things:
#
#   - "declared but not installed" → the package is expected here but is
#     missing, i.e. the install script was not run (a warning: install it).
#   - "installed but not declared" → the package is on this machine without
#     being declared anywhere (drift: declare it in `src/os/installs`, or
#     allow-list it if it is intentionally local-only).
#
# Packages that are intentionally managed only locally can be listed in
# the `brew_local_allowlist` file (one entry per line, '#' starts a comment).
#
# Note: This is meant to be run locally on macOS (it is not part of CI).

set -uo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../src/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# `jq` is needed to read the aliases / old names out of Homebrew's JSON
# output. Without this check the script would abort halfway through, because
# of the `set -e` inherited from `utils.sh`, with a confusing error.

if ! cmd_exists "jq"; then
    print_error "This script requires 'jq' (brew install jq)"
    exit 1
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -r INSTALLS_DIR="../src/os/installs"
declare -r ALLOWLIST_FILE="./brew_local_allowlist"

# A single- or double-quoted shell string, and a single quote character, as
# POSIX extended regular expressions (used by the extraction helpers below).

declare -r QUOTE='["'"'"']'
declare -r QUOTED='["'"'"'][^"'"'"']*["'"'"']'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

get_normalized_installs() {

    # Print the install scripts with the `\`-terminated continuation lines
    # joined, so that a call written as:
    #
    #     brew_install "Multi" \
    #         "multi-line"
    #
    # is matched exactly like `brew_install "Multi" "multi-line"`.
    #
    # Only lines that end with a backslash are joined, so unrelated lines are
    # left untouched.

    local file=""

    for file in "$INSTALLS_DIR"/*.sh; do
        awk '
            /\\[[:space:]]*$/ {
                sub(/[[:space:]]*\\[[:space:]]*$/, " ")
                printf "%s", $0
                next
            }
            { print }
        ' "$file"
    done

}

get_declared_formulae() {

    # Extract the formula / cask tokens (second `brew_install` argument),
    # stripping any tap prefixes.
    #
    # The recognised call shapes are all indented or line-initial, on a single
    # line or continued with a trailing `\`, and single- or double-quoted:
    #
    #     brew_install "Name" "token"
    #     brew_install 'Name' 'token'
    #
    # Limitation: calls that do not start the line (e.g. `if brew_install ...`
    # or `x && brew_install ...`) are not detected.

    get_normalized_installs \
        | grep -E "^[[:space:]]*brew_install[[:space:]]+${QUOTE}" \
        | sed -E "s/.*brew_install[[:space:]]+${QUOTED}[[:space:]]+${QUOTE}([^\"']+)${QUOTE}.*/\1/" \
        | sed -E 's|.*/||' \
        | sort -u

}

get_declared_taps() {

    {
        get_normalized_installs \
            | grep -E "^[[:space:]]*brew_tap[[:space:]]+${QUOTE}" \
            | sed -E "s/.*brew_tap[[:space:]]+${QUOTE}([^\"']+)${QUOTE}.*/\1/"

        # Taps are also declared as the fourth `brew_install` argument
        # (e.g. `brew_install "OpenCode" "opencode-v2" "" "anomalyco/tap"`).

        get_normalized_installs \
            | grep -E "^[[:space:]]*brew_install[[:space:]]+${QUOTE}" \
            | sed -nE "s/.*brew_install[[:space:]]+${QUOTED}[[:space:]]+${QUOTED}[[:space:]]+${QUOTED}[[:space:]]+${QUOTE}([^\"']+)${QUOTE}.*/\1/p"
    } | sort -u

}

get_declared_mas_ids() {

    {
        get_normalized_installs \
            | grep -E "^[[:space:]]*mas_install[[:space:]]+${QUOTE}" \
            | sed -E "s/.*mas_install[[:space:]]+${QUOTED}[[:space:]]+${QUOTE}([^\"']+)${QUOTE}.*/\1/"

        # Apps that cannot be installed through `mas` (e.g. `Xcode`, which is
        # too large for the App Store tooling) are declared by opening their
        # App Store page instead, so their ID is read from that URL.

        get_normalized_installs \
            | grep -oE "macappstores://[^\"']+" \
            | sed -E 's|.*/id([0-9]+)$|\1|'
    } | sort -u

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n • Brew drift check\n\n"

    if ! cmd_exists "brew"; then
        print_error "Homebrew is not installed"
        return 1
    fi

    local allowlist=""
    # `grep` exits 1 when the allowlist has no entries, which would abort the
    # script through `set -e` (inherited from `utils.sh`), so allow that.

    allowlist="$(grep -Ev '^[[:space:]]*(#|$)' "$ALLOWLIST_FILE" 2> /dev/null | awk '{ print $1 }' | sort -u || true)"

    local declaredFormulae="" declaredTaps="" declaredMasIds=""
    declaredFormulae="$(get_declared_formulae)"
    declaredTaps="$(get_declared_taps)"
    declaredMasIds="$(get_declared_mas_ids)"

    local installedFormulae="" installedCasks="" installedLeaves=""
    local installedTaps="" installedMasIds=""
    installedFormulae="$(brew list --formula 2> /dev/null | sed -E 's|.*/||' | sort -u)"
    installedCasks="$(brew list --cask 2> /dev/null | sort -u)"
    installedLeaves="$(brew leaves 2> /dev/null | sed -E 's|.*/||' | sort -u)"
    installedTaps="$(brew tap 2> /dev/null | sort -u)"

    if cmd_exists "mas"; then
        installedMasIds="$(mas list 2> /dev/null | awk '{ print $1 }' | sort -u)"
    fi

    # Map alias / old names to the canonical installed names
    # (e.g.: `gpg` → `gnupg`, `handbrake` → `handbrake-app`).

    local aliasMap=""
    aliasMap="$(brew info --json=v2 --installed 2> /dev/null | jq -r '
        (.formulae[] | .name as $n |
            (((.aliases // []) + (.oldnames // []))[] | select(type == "string") | "\(.) \($n)")),
        (.casks[] | .token as $t |
            ((.old_tokens // [])[] | select(type == "string") | "\(.) \($t)"))
    ' 2> /dev/null)"

    # Resolve the declared names to canonical installed names.

    local canonical="" item="" resolvedDeclared=""
    for item in $declaredFormulae; do

        canonical=""

        if printf "%s\n" "$installedFormulae" "$installedCasks" | grep -qx "$item"; then
            canonical="$item"
        else
            canonical="$(printf "%s\n" "$aliasMap" | awk -v key="$item" '$1 == key { print $2; exit }')"
        fi

        if [ -n "$canonical" ]; then
            resolvedDeclared="${resolvedDeclared}${canonical}"$'\n'
        else
            print_warning "declared but not installed: $item"
        fi

    done

    resolvedDeclared="$(printf "%s" "$resolvedDeclared" | sort -u)"

    # Check for installed packages that are not declared.
    #
    # Note: the opposite direction — "declared but not installed" — is printed
    # as a warning further down, because it means the install is missing on
    # this machine rather than that an undeclared package is present.

    local driftDetected=0

    for item in $installedLeaves; do
        if ! printf "%s\n" "$resolvedDeclared" | grep -qx "$item" \
            && ! printf "%s\n" "$allowlist" | grep -qx "$item"; then
            print_error "installed but not declared (formula): $item"
            driftDetected=1
        fi
    done

    for item in $installedCasks; do
        if ! printf "%s\n" "$resolvedDeclared" | grep -qx "$item" \
            && ! printf "%s\n" "$allowlist" | grep -qx "$item"; then
            print_error "installed but not declared (cask): $item"
            driftDetected=1
        fi
    done

    for item in $installedTaps; do

        case "$item" in
            homebrew/cask | homebrew/core) continue ;;
        esac

        if ! printf "%s\n" "$declaredTaps" | grep -qx "$item" \
            && ! printf "%s\n" "$allowlist" | grep -qx "$item"; then
            print_error "tapped but not declared: $item"
            driftDetected=1
        fi

    done

    for item in $installedMasIds; do
        if ! printf "%s\n" "$declaredMasIds" | grep -qx "$item" \
            && ! printf "%s\n" "$allowlist" | grep -qx "$item"; then
            print_error "installed but not declared (App Store): $item"
            driftDetected=1
        fi
    done

    # Check for declared entries missing on this machine (warnings only).

    for item in $declaredMasIds; do
        if ! printf "%s\n" "$installedMasIds" | grep -qx "$item"; then
            print_warning "declared but not installed (App Store): $item"
        fi
    done

    for item in $declaredTaps; do
        if ! printf "%s\n" "$installedTaps" | grep -qx "$item"; then
            print_warning "declared but not tapped: $item"
        fi
    done

    printf "\n"

    if [ "$driftDetected" -eq 0 ]; then
        print_success "No undeclared packages found"
    else
        print_error "Drift detected — declare the packages above in 'src/os/installs', or add them to 'tests/brew_local_allowlist'"
    fi

    return "$driftDetected"

}

main
exit $?
