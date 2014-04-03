#!/bin/bash

# Install common libs
sudo apt-get update
sudo apt-get install              \
    nfs-common                    \
    openssh-server                \
    vim screen zsh htop colordiff \
    cmake automake                \
    g++ build-essential           \
    git subversion cvs            \
    python-dev                    \
    python-setuptools python-pip  \
    ipython                       \
    python-numpy python-scipy     \
    python-matplotlib             \
    ruby                          \
    r-base                        \
    mongodb                       \
    memcached redis-server        \
    tokyocabinet-bin              \
    libtokyocabinet-dev           \
    exuberant-ctags               \
    pylint                        \

# Changing default shell
#chsh -s /bin/zsh

# Generating keys
#ssh-keygen -t rsa -b 2048
