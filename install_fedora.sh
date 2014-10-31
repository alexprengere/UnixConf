#!/bin/bash

# Install common libs
sudo yum check-update
sudo yum install                  \
    nfs-utils nfs-utils-lib       \
    openssh-server                \
    vim screen zsh htop colordiff \
    cmake automake                \
    gcc-c++                       \
    kernel-devel kernel-headers   \
    dkms                          \
    git subversion cvs            \
    python-devel                  \
    python-setuptools python-pip  \
    ipython                       \
    numpy scipy                   \
    python-matplotlib             \
    ruby-irb                      \
    R                             \
    mongodb                       \
    memcached redis               \
    tokyocabinet                  \
    tokyocabinet-devel            \
    ctags                         \
    pylint                        \
    jsl                           \

# Changing default shell
#chsh -s /bin/zsh

# Generating keys
#ssh-keygen -t rsa -b 2048
