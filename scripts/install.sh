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
    declare -a targets=("/etc/profile" "/etc/zshenv" "/etc/zsh/zshenv")
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

# In MacOS /etc/zshenv no longer get populated by default
# This function create the file if it doesn't exist
if [ "$(command -v zsh)" ]; then
    if [ "$(uname)" == "Darwin" ]; then
        if [ ! -f "/etc/zshenv" ]; then
            touch "/etc/zshenv"
        fi
    fi
fi

for target in "${targets[@]}"
do
    if [ -f "$target" ]; then
        echo "Installing into $target"
        replace_command "$target"
    else
        echo "Skipped $target. File not found"
    fi
done

