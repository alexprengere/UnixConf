#!/usr/bin/env bash

DIRNAME=$(dirname $0)
cd $DIRNAME

usage () {
    echo "Usage: $0 [-h] [-n]"
    echo "    -h display help and quit"
    echo "    -n do not compile YouCompleteMe"
}

NO_COMPILE=false

while getopts ":hn" opt; do
    case $opt in
        n)
            NO_COMPILE=true
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

# Backup previous
rm -rf ~/.vim.back
mv ~/.vim ~/.vim.back

# Bootstrap minimal conf
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Download all plugins
vim +BundleInstall +qall

if [ "$NO_COMPILE" = "false" ]; then
    # Final step
    cd ~/.vim/bundle/YouCompleteMe
    ./install.sh --clang-completer
else
    echo "Skipping YouCompleteMe compilation."
fi

