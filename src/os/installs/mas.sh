#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# Each entry below is independent and reports its own result, so a single
# failure must not abort the rest of the list.

set +e

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Mac App Store\n\n"

mas_install "Convert & Compress" "6752861983"
mas_install "Lightweight PDF" "1450640351"
mas_install "NextDNS" "1464122853"
mas_install "Parcel" "375589283"
mas_install "Things" "904280696"
