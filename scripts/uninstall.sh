#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"
ROOT_DIR="$(dirname "$DIR")"

echo ""
echo "------------------------------------------------"
echo ">[AutoConfigLoader]: Pre-run check"
echo "------------------------------------------------"
echo ""
echo "Installation directory: $DIR"
echo "Root directory: $ROOT_DIR"
echo "Index of root directory:"
find "$ROOT_DIR"
echo ""
echo "<[AutoConfigLoader]"
echo ""

# load libraries
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

