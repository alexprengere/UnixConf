#!/usr/bin/env bash

# BAckup previous
rm -rf ~/.vim.back
mv ~/.vim ~/.vim.back

# Bootstrap minimal conf
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Download all plugins
vim +BundleInstall +qall

# Final step
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer

