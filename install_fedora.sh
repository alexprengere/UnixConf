#!/bin/bash

# Install common libs
sudo yum update
sudo yum install                  \
    vim screen zsh htop colordiff \
    openssh-server                \
    python-pip ipython            \
    git subversion                \
    gcc-c++ python-devel          \
    pylint jsl                    \
    nfs-utils nfs-utils-lib

# Changing default shell
#chsh -s /bin/zsh

# Generating keys
#ssh-keygen -t rsa -b 2048
