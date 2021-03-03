Environment setup
=================

Basic packages installation
---------------------------
* Install basic packages on Debian/Ubuntu:
```bash
sudo apt update
sudo apt install                  \
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
    ipython                       \
    ruby                          \
    npm                           \
    exuberant-ctags               \
    silversearcher-ag             \
    gparted                       \
    python-dev                    \
    libffi-dev
```
* Install basic packages on Fedora/CentOS:
```bash
sudo dnf -y install epel-release
sudo dnf update
sudo dnf install                  \
    passwd sudo                   \
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
    ipython                       \
    ruby-irb                      \
    npm                           \
    ctags                         \
    the_silver_searcher           \
    gparted                       \
    python3 python3-devel         \
    libffi-devel
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

# Fix permissions
chmod 600 ~/.ssh/config

# Generate your ssh keys
ssh-keygen -t rsa -b 2048
```

