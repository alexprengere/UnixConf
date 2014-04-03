#!/bin/bash

# Install common libs
sudo apt-get update
sudo apt-get install              \
    nfs-common                    \
    openssh-server                \
    vim screen zsh htop colordiff \
    cmake automake                \
    g++ python-dev                \
    build-essential               \
    git subversion cvs            \
    python-pip ipython            \
    python-numpy python-scipy     \
    python-matplotlib             \
    ruby                          \
    r-base                        \
    mongodb                       \
    memcached redis-server        \
    exuberant-ctags               \
    pylint                        \

# Changing default shell
#chsh -s /bin/zsh

# Generating keys
#ssh-keygen -t rsa -b 2048
