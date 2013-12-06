#!/bin/bash

# Install common libs
sudo apt-get update
sudo apt-get install              \
    nfs-common                    \
    vim screen zsh htop           \
    openssh-server                \
    python-pip ipython            \
    git subversion                \
    colordiff                     \
    cmake automake                \
    g++ python-dev                \
    build-essential               \
    exuberant-ctags               \
    pylint                        \

# Changing default shell
#chsh -s /bin/zsh

# Generating keys
#ssh-keygen -t rsa -b 2048
