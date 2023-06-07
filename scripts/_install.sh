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


# Setup files
mkdir -p "/Library/AutoConfigLoader"
cp -r AutoConfigLoader "/Library/AutoConfigLoader" # TODO file doesn't exist yet

# Setup injection
for injection_site in "${injection_sites[@]}"
do
    if [ -f "$injection_site" ]; then
        echo "Injecting into $injection_site"
        replace_command "$injection_site"
    fi
done

