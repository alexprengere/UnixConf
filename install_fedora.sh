#!/bin/bash

# Install common libs
sudo yum check-update
sudo yum install                  \
    nfs-utils nfs-utils-lib       \
    openssh-server                \
    vim screen zsh htop colordiff \
    cmake automake                \
    gcc-c++ python-devel          \
    kernel-devel                  \
    git subversion cvs            \
    python-pip ipython            \
    numpy scipy                   \
    python-matplotlib             \
    ruby-irb                      \
    R                             \
    mongodb                       \
    memcached redis               \
    ctags                         \
    pylint                        \
    jsl                           \

# Changing default shell
#chsh -s /bin/zsh

# Generating keys
#ssh-keygen -t rsa -b 2048
