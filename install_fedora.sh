#!/bin/bash

# Install common libs
sudo yum check-update
sudo yum install                  \
    nfs-utils nfs-utils-lib       \
    vim screen zsh htop           \
    openssh-server                \
    python-pip ipython            \
    ruby-irb                      \
    numpy scipy                   \
    python-matplotlib             \
    mongodb                       \
    memcached redis               \
    R                             \
    git subversion                \
    colordiff                     \
    cmake automake                \
    gcc-c++ python-devel          \
    kernel-devel                  \
    ctags                         \
    pylint                        \
    jsl                           \

# Changing default shell
#chsh -s /bin/zsh

# Generating keys
#ssh-keygen -t rsa -b 2048
