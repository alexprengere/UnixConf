#!/bin/bash

DIRNAME=$(dirname $0)
cd $DIRNAME

usage () {
    echo "Usage: $0 [-h] [-f] [-v]"
    echo "    -h display help and quit"
    echo "    -f override even if target is already there"
    echo "    -v verbose mode: show skipped files and diffs"
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
                 [flake8]="$HOME/.config/flake8"
               [pylintrc]="$HOME/.config/pylintrc"
      [subversion_config]="$HOME/.subversion/config"
             [ssh_config]="$HOME/.ssh/config"
    [liquidpromptrc-dist]="$HOME/.liquidpromptrc"
               [pip.conf]="$HOME/.pip/pip.conf"
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
        if [ "$e" == "$1" ]; then
            echo "Y"
            return
        fi
    done
    echo "N"
}

msg () {
    printf "%-1s %-20s\t%-22s %s\n" "$1" "$2" "$3" "$4"
}

unexpand () {
    if [[ "$1" =~ ^"$HOME"(/|$) ]]; then
        echo "~${1#$HOME}"
    else
        echo $1
    fi
}

mv_p () {
    local SOURCE="$1"
    local TARGET="$2"
    mkdir -p `dirname "$TARGET"`
    rm -rf "$TARGET"
    cp -r "$SOURCE" "$TARGET"
}

msg '' "SOURCE" "TARGET"

for SOURCE in `ls`; do
    if [ `is_in_array "$SOURCE" "${SKIPPED[@]}"` == "Y" ]; then
        [ "$VERBOSE" = "true" ] && msg '.' "$SOURCE" '' "skipped"
        continue
    fi
    if [ "${SPECIALS[${SOURCE}]}" == "" ]; then
        TARGET="${HOME}/.${SOURCE}"
    else
        TARGET="${SPECIALS[${SOURCE}]}"
    fi
    TARGET_S=`unexpand "$TARGET"`

    if [ ! -f "$TARGET" ]; then
        msg '✓' "$SOURCE" "$TARGET_S" "copied"
        mv_p "$SOURCE" "$TARGET"

    elif [ "$(diff -u $TARGET $SOURCE)" = "" ]; then
        msg '✓' "$SOURCE" "$TARGET_S" "exists (same)"

    # Target exists and files are different here
    elif [ "$FORCE" = "false" ]; then
        msg '✗' "$SOURCE" "$TARGET_S" "exists (with diffs): not copying. Try -f to force, -v to view diffs"
        [ "$VERBOSE" = "true" ] && colordiff -u "$TARGET" "$SOURCE"
    else
        msg '✓' "$SOURCE" "$TARGET_S" "copied (overriding)"
        mv_p "$SOURCE" "$TARGET"
    fi
done
