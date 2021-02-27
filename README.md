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
    tree                          \
    cmake automake                \
    g++ build-essential           \
    linux-headers-generic         \
    dkms                          \
    git subversion cvs            \
    imagemagick                   \
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
    exuberant-ctags               \
    silversearcher-ag             \
    gparted                       \
    python-dev                    \
    libffi-dev                    \
    libxml2-dev                   \
    libxslt1-dev                  \
    libyaml libyaml-dev           \
    libtokyocabinet-dev           \
    cairo-dev                     \
    openssl-dev                   \
    libcurl-dev                   \
    libXt-dev                     \
    readline-dev                  \
    gtk2-dev                      \
    ggobi-dev                     \
    bzip2-dev                     \
    tk-dev
```
* Install basic packages on Fedora (use ``dnf`` for recent versions):
```bash
sudo yum check-update
sudo yum install                  \
    openssh-server                \
    wget curl                     \
    vim screen zsh htop colordiff \
    tree                          \
    cmake automake                \
    gcc-c++                       \
    kernel-headers kernel-devel   \
    dkms                          \
    git subversion cvs            \
    ImageMagick                   \
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
    ctags                         \
    jsl                           \
    the_silver_searcher           \
    gparted                       \
    python-devel                  \
    libffi-devel                  \
    libxml2-devel                 \
    libxslt-devel                 \
    libyaml libyaml-devel         \
    tokyocabinet-devel            \
    cairo-devel                   \
    openssl-devel                 \
    libcurl-devel                 \
    libXt-devel                   \
    readline-devel                \
    gtk2-devel                    \
    ggobi-devel                   \
    bzip2-devel                   \
    tk-devel                      \
    lapack-devel
```
* Install Python packages:
```bash
python3 -m pip install --user pipx
pipx install virtualenv
pipx install tox
pipx install black
pipx install pylint
pipx install flake8
```
* Install node packages:
```bash
sudo npm install -g coffeelint grunt-cli diff-so-fancy
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
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall
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

