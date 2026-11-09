#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    || exit 1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Note: this file lives in `os/preferences/`, so `utils.sh` is two levels up,
# exactly like `os/installs/main.sh` (not one level up like `os/*.sh`).

. "../../utils.sh" \
    || exit 1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Preferences\n\n"

declare -a FAILED_SCRIPTS=()

run_preference_script() {

    local script="$1"

    if ! "./$script"; then
        FAILED_SCRIPTS+=("$script")
    fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Sourcing `utils.sh` above enables `set -e`, which would abort this script on
# the first failing preference. Disable it so the rest still run and are
# reported in the summary.

set +e

# Close any open `System Settings` panes in order to
# avoid overriding the preferences that are being changed.

./close_system_settings_panes.applescript

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

run_preference_script "app_store.sh"
run_preference_script "chrome.sh"
run_preference_script "dock.sh"
run_preference_script "finder.sh"
run_preference_script "firefox.sh"
run_preference_script "keyboard.sh"
run_preference_script "language_and_region.sh"
run_preference_script "maps.sh"
run_preference_script "miscellaneous.sh"
run_preference_script "photos.sh"
run_preference_script "security_and_privacy.sh"
run_preference_script "textedit.sh"
run_preference_script "trackpad_and_mouse.sh"
run_preference_script "transmission.sh"
run_preference_script "ui_and_ux.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_summary() {

    local failedCount="${#FAILED_SCRIPTS[@]}"
    local failedLabel="preference scripts"
    local script=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ "$failedCount" -eq 0 ]; then
        print_success "All preference scripts completed"
        return 0
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ "$failedCount" -eq 1 ]; then
        failedLabel="preference script"
    fi

    print_warning "$failedCount $failedLabel failed:"

    for script in "${FAILED_SCRIPTS[@]}"; do
        print_error "$script"
    done

}

print_summary

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Always exit 0, even when some preference scripts failed.
#
# `setup.sh` runs this script under `set -euo pipefail`, so a non-zero exit
# would abort the whole bootstrap before `set_default_apps.sh`, the git
# repository initialisation and the update step. Continuing is the lesser
# evil: the summary above is how failures are reported, not the exit code. Do
# not "fix" this into a non-zero exit.

exit 0
