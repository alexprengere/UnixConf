Environment setup
=================

Basic packages installation
---------------------------
* Install basic packages on Debian/Ubuntu:
```bash
sudo apt-get update
sudo apt-get install              \
    nfs-common                    \
    openssh-server                \
    vim screen zsh htop colordiff \
    cmake automake                \
    g++ build-essential           \
    linux-headers-generic         \
    dkms                          \
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
    silversearcher-ag
```
* Install basic packages on Fedora:
```bash
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
    the_silver_searcher
```
* `Ag` may not be in the repositories and fail to install with `yum` or `apt-get`. If it the case, try installing from source.
```bash
# Prerequisistes
# apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
# yum -y install pkgconfig automake gcc zlib-devel pcre-devel xz-devel
git clone https://github.com/ggreer/the_silver_searcher.git
cd the_silver_searcher
./build.sh
sudo make install
```

Deploy the configuration files
------------------------------
```bash
$ ./deploy.sh
  SOURCE                TARGET
✓ agignore              ~/.agignore                    exists (same)
✗ bashrc                ~/.bashrc                      exists (with diffs): not copying (-f to force)
✓ colordiffrc           ~/.colordiffrc                 copied
✓ conkyrc               ~/.conkyrc                     exists (same)
✓ gitconfig             ~/.gitconfig                   exists (same)
✓ jsl.conf              ~/.jsl.conf                    exists (same)
✓ liquidprompt          ~/.liquidprompt                exists (same)
✓ liquidpromptrc-dist   ~/.liquidpromptrc              copied
✓ liquid.ps1            ~/.liquid.ps1                  exists (same)
✓ liquid.theme          ~/.liquid.theme                exists (same)
✗ pylintrc              ~/.pylintrc                    exists (with diffs): not copying (-f to force)
✗ ssh_config            ~/.ssh/config                  exists (with diffs): not copying (-f to force)
✓ subversion_config     ~/.subversion/config           copied
✓ vimrc                 ~/.vimrc                       exists (same)
✓ zshrc                 ~/.zshrc                       exists (same)

$ ./deploy.sh -h
Usage: ./deploy.sh [-h] [-f] [-v]
    -h display help and quit
    -f override even if target is already there
    -v verbose mode: show skipped files and diffs
```

Generate vim directory
----------------------
After the `vimrc` deployment, generate the `vim` directory with:
```bash
rm -rf ~/.vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
```
Syntastic plugin uses `pylint` and `jsl` as syntax checkers. Make sure these are
installed and configuration files are there. Check the `.vimrc` to see
where syntastic is looking for, usually `~/.pylintrc` and `~/.jsl.conf`.

`Ag` is also used by a plugin, make sure this is installed.

Miscellaneous
-------------
```bash
# Change default shell to zsh
chsh -s /bin/zsh

# Generate your ssh keys
ssh-keygen -t rsa -b 2048
```

