#!/bin/bash

# Install common libs
sudo apt-get update
sudo apt-get install              \
    vim screen zsh htop colordiff \
    openssh-server                \
    python-pip ipython            \
    git subversion                \
    g++ python-dev                \
    pylint                        \
    nfs-common

# Changing default shell
#chsh -s /bin/zsh

# Generating keys
#ssh-keygen -t rsa -b 2048