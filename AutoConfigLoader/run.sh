DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

debug() {
    if [ "$DEBUG" = true ]; then
        echo -e "\e[1;45mDEBUG\e[0m: $1"
    fi
}
error() {
    echo -e "\e[1;31mERROR\e[0m: $1"
}

for file in /Library/AutoConfigLoader/config/*.sh; do
    debug "Running $file"
    source $file || error "source failed at $file"
done
