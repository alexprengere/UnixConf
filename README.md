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
    wget curl                     \
    vim screen zsh htop colordiff \
    cmake automake                \
    g++ build-essential           \
    linux-headers-generic         \
    dkms                          \
    git subversion cvs            \
    python-dev                    \
    python-setuptools             \
    ipython                       \
    python-numpy python-scipy     \
    python-matplotlib             \
    ruby                          \
    npm                           \
    r-base                        \
    mongodb                       \
    memcached redis-server        \
    tokyocabinet-bin              \
    libtokyocabinet-dev           \
    exuberant-ctags               \
    silversearcher-ag             \
    gparted
```
* Install basic packages on Fedora (use ``dnf`` for recent versions):
```bash
sudo yum check-update
sudo yum install                  \
    nfs-utils nfs-utils-lib       \
    openssh-server                \
    wget curl                     \
    vim screen zsh htop colordiff \
    cmake automake                \
    gcc-c++                       \
    kernel-devel kernel-headers   \
    dkms                          \
    git subversion cvs            \
    python-devel                  \
    python-setuptools             \
    ipython                       \
    numpy scipy                   \
    python-matplotlib             \
    ruby-irb                      \
    npm                           \
    R                             \
    mongodb                       \
    memcached redis               \
    tokyocabinet                  \
    tokyocabinet-devel            \
    ctags                         \
    jsl                           \
    the_silver_searcher           \
    gparted
```
* Install Python packages:
```bash
easy_install --user pip
~/.local/bin/pip install --user pylint flake8 virtualenv tox
```
* Install node packages:
```bash
sudo npm install -g coffeelint grunt-cli
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
git clone https://github.com/alexprengere/UnixConf.git
cd UnixConf
./deploy.sh -f
  SOURCE                TARGET                 
✓ agignore              ~/.agignore            exists (same)
✓ bashrc                ~/.bashrc              exists (same)
✓ colordiffrc           ~/.colordiffrc         exists (same)
✓ conkyrc               ~/.conkyrc             exists (same)
✓ gitconfig             ~/.gitconfig           exists (same)
✓ jsl.conf              ~/.jsl.conf            exists (same)
✓ liquidprompt          ~/.liquidprompt        copied (overriding)
✓ liquidpromptrc-dist   ~/.liquidpromptrc      copied (overriding)
✓ liquid.ps1            ~/.liquid.ps1          copied (overriding)
✓ liquid.theme          ~/.liquid.theme        exists (same)
✓ pylintrc              ~/.pylintrc            exists (same)
✓ ssh_config            ~/.ssh/config          exists (same)
✓ subversion_config     ~/.subversion/config   exists (same)
✓ vimrc                 ~/.vimrc               exists (same)
✓ zshrc                 ~/.zshrc               copied (overriding)
```

Generate vim directory
----------------------
After the `vimrc` deployment, generate the `vim` directory with:
```bash
rm -rf ~/.vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +PluginInstall +qall
```
Finish YCM plugin installation:
```bash
cd ~/.vim/bundle/YouCompleteMe
./install.py # --clang-completer for LLVM based autocomplete
```
Some vim plugins (*Syntastic*, *vim-ag*) use external tools. These tools need to be installed and have their configuration files in place (check the `.vimrc` for file locations):
* `pylint` with `~/.pylintrc`
* `jsl` with `~/.jsl.conf`
* `Ag` with `~/.agignore`

Miscellaneous
-------------
```bash
# Change default shell to zsh
chsh -s /bin/zsh

# Generate your ssh keys
ssh-keygen -t rsa -b 2048
```

