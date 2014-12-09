#!/bin/bash

DIRNAME=$(dirname $0)
cd $DIRNAME

usage () {
    echo "Usage: $0 [-h] [-f] [-v]"
    echo "    -h display help and quit"
    echo "    -f override even if target is already there"
    echo "    -v verbose mode"
}

SKIPPED=(
    `basename $0`
    "README.md"
    "gitattributes"
    "gitignore"
    "fstab.ssd"
    "fstab"
)

# Special targets, default is $HOME/.$SOURCE
declare -A SPECIALS
SPECIALS=(
    [subversion_config]="$HOME/.subversion/config"
    [ssh_config]="$HOME/.ssh/config"
    [liquidpromptrc-dist]="$HOME/.liquidpromptrc"
    [fstab.ssd]="/etc/fstab"
    [fstab]="/etc/fstab"
)

FORCE=false
VERBOSE=false

while getopts ":hfv" opt; do
    case $opt in
        h)
            usage
            exit 1
            ;;
        f)
            FORCE=true
            ;;
        v)
            VERBOSE=true
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

shift $(($OPTIND - 1))

is_in_array () {
    local e
    for e in "${@:2}"; do
        [[ "$e" == "$1" ]] && echo "Y" && return
    done
    echo "N"
}

msg () {
    printf "%s %-20s\t%-50s %s\n" "$1" "$2" "$3" "$4"
}

for SOURCE in `ls`; do
    if [ `is_in_array "$SOURCE" "${SKIPPED[@]}"` == "Y" ]; then
        [ "$VERBOSE" = "true" ] && msg '.' "$SOURCE" '' "skipped"
        continue
    fi
    if [ "${SPECIALS[${SOURCE}]}" == "" ]; then
        TARGET="$HOME/.$SOURCE"
    else
        TARGET="${SPECIALS[${SOURCE}]}"
    fi

    if [ ! -f "$TARGET" ]; then
        msg '✓' "$SOURCE" "$TARGET" "moved"
        cp $SOURCE $TARGET

    elif [ "$(diff -u $SOURCE $TARGET)" = "" ]; then
        msg '✓' "$SOURCE" "$TARGET" "exists (same)"

    # Target exists and files are different here
    elif [ "$FORCE" = "false" ]; then
        msg '✗' "$SOURCE" "$TARGET" "exists (with diffs), not copying (use -f or -v)"
        [ "$VERBOSE" = "true" ] && colordiff -u $SOURCE $TARGET
    else
        msg '✓' "$SOURCE" "$TARGET" "moved (overriding)"
        cp $SOURCE $TARGET
    fi
done
