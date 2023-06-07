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


# Setup files
mkdir -p "/Library/AutoConfigLoader"
cp -r AutoConfigLoader "/Library/AutoConfigLoader" # TODO file doesn't exist yet

# Setup injection
for target in "${targets[@]}"
do
    if [ -f "$target" ]; then
        echo "Installing into $target"
        replace_command "$target"
    else
        echo "Skipped $target. File not found"
    fi
done

