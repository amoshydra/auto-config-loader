#!/bin/bash

# load libraries
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/_lib.sh"

# check debug mode
if [ "$1" == "--debug" ]; then
    echo "Debug mode enabled"
    declare -a injection_sites=("$ACON_TEST_PROFILE_PATH")
else
    declare -a injection_sites=("/etc/profile" "/etc/zprofile" "/etc/zsh/profile")
fi

for injection_site in "${injection_sites[@]}"
do
    if [ -f "$injection_site" ]; then
        echo "Removing from $injection_site"
        remove_command "$injection_site"
    else
        echo "Skipped $injection_site. File not found"
    fi
done

