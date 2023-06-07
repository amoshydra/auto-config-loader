#!/bin/bash

# load libraries
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/_lib.sh"

# check debug mode
if [ "$1" == "--debug" ]; then
    echo "Debug mode enabled"
    declare -a targets=("$ACON_TEST_PROFILE_PATH")
else
    declare -a targets=("/etc/profile" "/etc/zprofile" "/etc/zsh/profile")
fi

# [1. SETUP CONFIG]
rm -rf "/Library/AutoConfigLoader"

# [2. Install]
for target in "${targets[@]}"
do
    if [ -f "$target" ]; then
        echo "Removing from $target"
        remove_command "$target"
    else
        echo "Skipped $target. File not found"
    fi
done

