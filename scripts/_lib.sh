export COMMAND_ID="#_AUTO_PROFILE_LOADER_#"
export COMMAND="source /Library/AutoConfigLoader/run.sh # $COMMAND_ID"

export ACON_TEST_PROFILE_PATH="${ACON_TEST_PROFILE_PATH:-"/root/scripts/test/profile"}"

# Setup injection
function remove_command() {
    if [ "$(uname)" == "Darwin" ]; then
        # Mac OS X platform
        sed -i '' "s,.*$COMMAND_ID,,g" "$1"
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        # GNU/Linux platform
        sed -i "s,.*$COMMAND_ID,,g" "$1"
    fi
}

function replace_command() {
    # append file if it doesn't exist
    if ! grep -q "$COMMAND_ID" "$1"; then
        # check if file ends with newline
        tail -c1 "$1" | read -r _ || echo >> "$1"
        # append command
        echo "$COMMAND" >> "$1"
    else
        if [ "$(uname)" == "Darwin" ]; then
            # Mac OS X platform
            sed -i '' "s,.*$COMMAND_ID,$COMMAND,g" "$1"
        elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
            # GNU/Linux platform
            sed -i "s,.*$COMMAND_ID,$COMMAND,g" "$1"
        fi
    fi
}
