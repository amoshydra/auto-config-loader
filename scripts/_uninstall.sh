#!/bin/bash

# load libraries
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/_lib.sh"

# check debug mode
if [ "$1" == "--debug" ]; then
    echo "Debug mode enabled"
    declare -a injection_sites=("/root/scripts/test/profile")
else
    declare -a injection_sites=("/etc/profile" "/etc/zprofile" "/etc/zsh/profile")
fi

for injection_site in "${injection_sites[@]}"
do
    if [ -f "$injection_site" ]; then
        echo "Removing from $injection_site"
        remove_command "$injection_site"
    fi
done

