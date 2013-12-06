#!/bin/bash

###
### DATA
###

# Skipped files
SKIPPED=(
    `basename $0`
    "install_ubuntu.sh"
    "install_fedora.sh"
    "README.rst"
    "shell.aliases"
    "liquidprompt.oldzsh"
    "aprengere.zsh-theme"
    "gitattributes"
    "conkyrc"
    "wgetrc"
    "fstab.ssd"
    "fstab"
    "vim"
)

# Special targets, default is $HOME/.$SOURCE
declare -A SPECIALS
SPECIALS=(
    [liquidpromptrc-dist]="$HOME/.liquidpromptrc"
    [liquidprompt]="$HOME/.liquidprompt"
    #[fstab.ssd]="/etc/fstab"
    #[fstab]="/etc/fstab"
)

####
####

DIRNAME=$(dirname $0)
cd $DIRNAME

usage () {
    echo "Usage: $0 [-h] [-t] [-f] [-d]"
    echo "    -h display help and quit"
    echo "    -t test mode, do not actually perform command"
    echo "    -f override even if configuration file is already there"
    echo "    -d show differences when files are already there"
}

TEST=false
FORCE=false
DIFFS=false

while getopts ":tfdh" opt; do
    case $opt in
        t)
            TEST=true
            ;;
        f)
            FORCE=true
            ;;
        d)
            DIFFS=true
            ;;
        h)
            usage
            exit 1
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

shift $(($OPTIND - 1))

msg () {
    local source="$1"
    local symbol="$2"
    local target="$3"
    local message="$4"
    printf "%-20s\t%s %-40s %s\n" "$source" "$symbol" "$target" "$message"
}


# We start with every single file and dir of the current directory
ALL_SOURCES=`ls`
SOURCES=()

msg SOURCE S TARGET MESSAGE

# We remove the elements of SKIPPED array
for SOURCE in $ALL_SOURCES; do
    SKIP=false
    for s in "${SKIPPED[@]}"; do
        if [ "$s" = "$SOURCE" ]; then
            SKIP=true
        fi
    done
    if [ "$SKIP" = "false" ]; then
        SOURCES+=($SOURCE)
    else
        msg $SOURCE "/" "" "skipped"
    fi
done

for SOURCE in ${SOURCES[@]}; do

    if [ "${SPECIALS[${SOURCE}]}" != "" ]; then
        TARGET="${SPECIALS[${SOURCE}]}"
        SYMBOL="S"
    else
        TARGET="$HOME/.$SOURCE"
        SYMBOL="."
    fi

    if [ ! -f "$TARGET" ] && [ ! -d "$TARGET" ]; then
        msg $SOURCE $SYMBOL $TARGET "moved to target"

        if [ "$TEST" = "false" ]; then
            if [ -f "$SOURCE" ]; then
                cp $SOURCE $TARGET
            elif [ -d "$SOURCE" ]; then
                cp -r $SOURCE $TARGET
            else
                msg $SOURCE $SYMBOL $TARGET "something weird happened!"
            fi
        fi

    elif [ -f "$SOURCE" ]; then
        DIFF=$(diff -u $TARGET $SOURCE)

        if [ "$DIFF" = "" ]; then
            msg $SOURCE $SYMBOL $TARGET "skipped, exists with no differences"
        else
            if [ "$FORCE" = "true" ]; then
                msg $SOURCE $SYMBOL $TARGET "moved to target, *overriding*"
                if [ "$DIFFS" = "true" ]; then
                    diff -u $TARGET $SOURCE
                fi
                if [ "$TEST" = "false" ]; then
                    mv $TARGET $TARGET.back
                    cp $SOURCE $TARGET
                fi
            else
                msg $SOURCE $SYMBOL $TARGET "skipped, exists *with* differences"
                if [ "$DIFFS" = "true" ]; then
                    diff -u $TARGET $SOURCE
                fi
            fi
        fi

    elif [ -d "$SOURCE" ]; then
        if [ "$FORCE" = "true" ]; then
            msg $SOURCE $SYMBOL $TARGET "moved to target, *overriding*"
            if [ "$TEST" = "false" ]; then
                rm -rf $TARGET.back
                mv $TARGET $TARGET.back
                cp -r $SOURCE $TARGET
            fi
        else
            msg $SOURCE $SYMBOL $TARGET "skipped, target *directory* exists"
        fi
    else
        msg $SOURCE $SYMBOL $TARGET "something weird happened!"
    fi
done
