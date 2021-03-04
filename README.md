Environment setup
=================

System packages
---------------

* Install packages on Debian/Ubuntu:

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

* Install packages on Fedora/CentOS:

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
    libffi-devel                  \
    zlib-devel                    \
    bzip2-devel                   \
    xz-devel                      \
    openssl-devel                 \
    ncurses-devel                 \
    sqlite-devel                  \
    readline-devel                \
    tk-devel                      \
    gdbm-devel                    \
    expat-devel
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
* Install Node packages:

```bash
sudo npm install -g coffeelint grunt-cli diff-so-fancy
```

Deploy the configuration files
------------------------------

```bash
git clone https://github.com/alexprengere/UnixConf.git
cd UnixConf
./deploy.sh
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

Rust
----

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Miscellaneous
-------------

```bash
# Change default shell to zsh
chsh -s /bin/zsh

# Fix permissions that may be wrong after copying ssh_config
chmod 600 ~/.ssh/config

# Generate your ssh keys
ssh-keygen -t rsa -b 2048

# Fix sticky bits
sudo dnf reinstall shadow-utils

# Enable ping for non-root users
sudo dnf install procps-ng iputils
sudo sysctl -w net.ipv4.ping_group_range="0 2000"
```

WSL2
----

If running with WSL, this can help get network access:
```
Get-NetIPInterface -InterfaceAlias "vEthernet (WSL)" | Set-NetIPInterface -InterfaceMetric 1
Get-NetAdapter | Where-Object {$_.InterfaceDescription -Match "Cisco AnyConnect"} | Set-NetIPInterface -InterfaceMetric 6000
```

Also you should edit your `/etc/wsl.conf` to set the default user and disallow the overriding of `/etc/resolv.conf`.

Finally, you can edit the Windows Terminal settings and add things from `WindowsTerminal.json`:
```
/mnt/c/Users/<USER>/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
```
