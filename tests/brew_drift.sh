#!/bin/bash

# Checks for drift between the packages declared in the install scripts
# and what is actually installed through Homebrew / `mas` on this machine.
#
# Packages that are intentionally managed only locally can be listed in
# the `brew_local_allowlist` file (one entry per line, '#' starts a comment).
#
# Note: This is meant to be run locally on macOS (it is not part of CI).

set -uo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../src/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -r INSTALLS_DIR="../src/os/installs"
declare -r ALLOWLIST_FILE="./brew_local_allowlist"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

get_declared_formulae() {

    # Extract the formula / cask tokens (second `brew_install` argument),
    # stripping any tap prefixes.

    grep -hE '^[[:space:]]*brew_install[[:space:]]+"' "$INSTALLS_DIR"/*.sh \
        | sed -E 's/.*brew_install[[:space:]]+"[^"]*"[[:space:]]+"([^"]+)".*/\1/' \
        | sed -E 's|.*/||' \
        | sort -u

}

get_declared_taps() {

    {
        grep -hE '^[[:space:]]*brew_tap[[:space:]]+"' "$INSTALLS_DIR"/*.sh \
            | sed -E 's/.*brew_tap[[:space:]]+"([^"]+)".*/\1/'

        grep -hE '^[[:space:]]*brew_install[[:space:]]+"' "$INSTALLS_DIR"/*.sh \
            | sed -nE 's/.*brew_install[[:space:]]+"[^"]*"[[:space:]]+"[^"]*"[[:space:]]+"[^"]*"[[:space:]]+"([^"]+)".*/\1/p'
    } | sort -u

}

get_declared_mas_ids() {

    grep -hE '^[[:space:]]*mas_install[[:space:]]+"' "$INSTALLS_DIR"/*.sh \
        | sed -E 's/.*mas_install[[:space:]]+"[^"]*"[[:space:]]+"([^"]+)".*/\1/' \
        | sort -u

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
