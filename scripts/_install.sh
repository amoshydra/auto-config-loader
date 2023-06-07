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
# if directory doesn't exist, create it
if [ ! -d "/Library/AutoConfigLoader" ]; then
    echo "Creating directory /Library/AutoConfigLoader"
    mkdir -p "/Library/AutoConfigLoader/config"
fi

declare -a files=(
    "/run.sh"
    "/config/_.sh"
)
for file in "${files[@]}"
do
    cp "$DIR/../AutoConfigLoader$file" "/Library/AutoConfigLoader$file"
done

# [2. Install]
for target in "${targets[@]}"
do
    if [ -f "$target" ]; then
        echo "Installing into $target"
        replace_command "$target"
    else
        echo "Skipped $target. File not found"
    fi
done

