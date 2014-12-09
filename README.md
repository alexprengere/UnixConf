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
✓ agignore              /home/localoriuser/.agignore             exists (same)
✓ bashrc                /home/localoriuser/.bashrc               exists (same)
✓ colordiffrc           /home/localoriuser/.colordiffrc          moved
✓ conkyrc               /home/localoriuser/.conkyrc              exists (same)
✓ gitconfig             /home/localoriuser/.gitconfig            exists (same)
✓ jsl.conf              /home/localoriuser/.jsl.conf             exists (same)
✓ liquidprompt          /home/localoriuser/.liquidprompt         exists (same)
✓ liquidpromptrc-dist   /home/localoriuser/.liquidpromptrc       moved
✓ liquid.ps1            /home/localoriuser/.liquid.ps1           exists (same)
✓ liquid.theme          /home/localoriuser/.liquid.theme         exists (same)
✓ pylintrc              /home/localoriuser/.pylintrc             exists (same)
✗ ssh_config            /home/localoriuser/.ssh/config           exists (with diffs): not copying (-f to force)
✓ subversion_config     /home/localoriuser/.subversion/config    moved
✓ vimrc                 /home/localoriuser/.vimrc                exists (same)
✗ zshrc                 /home/localoriuser/.zshrc                exists (with diffs): not copying (-f to force)
```

Generate vim directory
----------------------
After the `vimrc` deployment, generate the `vim` directory with:
```bash
rm -rf ~/.vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
```
Finish YCM plugin installation:
```bash
cd ~/.vim/bundle/YouCompleteMe
./install.sh # --clang-completer for LLVM based autocomplete
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

