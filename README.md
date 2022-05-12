# Environment setup

## WSL2

After installing WSL2, you can import/export a rootfs:

```
wsl --import CentOS C:\WSL\CentOS C:\WSL\CentOS.tar
wsl --export CentOS C:\WSL\CentOS-new.tar
```

Connect with:

```
wsl -d CentOS
```

You should edit your `/etc/wsl.conf` to disallow the overriding of `/etc/resolv.conf` (this needs a complete reboot of WSL to take effect).

```bash
echo -e "[network]\ngenerateResolvConf = false" > /etc/wsl.conf
```

Create a non-root user:

```bash
dnf install -y passwd cracklib-dicts
useradd -G wheel username
passwd username

# Logout + login as <username> with: wsl -u username
# Default user is configurable in /etc/wsl.conf

# Fix sticky bits
sudo dnf reinstall shadow-utils

# Enable ping for non-root users
sudo dnf install procps-ng iputils
sudo sysctl -w net.ipv4.ping_group_range="0 2000"
```

### Working with a VPN

* make sure the VPN DNS servers are in your `resolv.conf`, and that `resolv.conf` does not get overriden
* this can help get network access, after each VPN connection:

```
Get-NetIPInterface -InterfaceAlias "vEthernet (WSL)" | Set-NetIPInterface -InterfaceMetric 1
Get-NetAdapter | Where-Object {$_.InterfaceDescription -Match "Cisco AnyConnect"} | Set-NetIPInterface -InterfaceMetric 6000
```

### Windows Terminal config

You can edit the Windows Terminal settings and add things from `WindowsTerminal.json`:

```
/mnt/c/Users/<USER>/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
```

To feel like Linux in your WSL, you will probably need to update your keyboard layout from "US International" to "US", avoid avoid having to double press quotes for them to appear.

### Docker

Things relying on systemd will typically not work, for example Docker needs to be installed on Windows, with WSL2 integration.

For old Docker images, you need to edit a `.wslconfig` file in your *Windows* home directory:

```
[wsl2]
kernelCommandLine = vsyscall=emulate
```

## System packages

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
# CentOS only
sudo dnf -y install epel-release
sudo dnf config-manager --set-enabled powertools
# All
sudo dnf update
sudo dnf install                  \
    passwd sudo                   \
    openssh-server hostname       \
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
    libxslt-devel libxslt         \
    libxml2-devel libxml2         \
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
python3 -m pip install --user wheel pipx
pipx install virtualenv
pipx install tox
pipx install twine
pipx install black
pipx install pylint
pipx install flake8
```
* Install Node packages:

```bash
sudo npm install -g coffeelint grunt-cli diff-so-fancy
```

## Deploy the configuration files

```bash
git clone https://github.com/alexprengere/UnixConf.git
cd UnixConf
./deploy.sh
```

## Generate vim directory

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

## Miscellaneous

```bash
# Change default shell to zsh
chsh -s /bin/zsh

# Fix permissions that may be wrong after copying ssh_config
chmod 600 ~/.ssh/config

# Generate your ssh keys
ssh-keygen -t rsa -b 2048

# Generate a GPG key and export it
gpg --full-generate-key                     # 4096 bits please
gpg --list-secret-keys --keyid-format LONG  # lookup the key ID after sec rsa4096/<HERE>
gpg --armor --export <ID>

# If you run docker
sudo usermod -aG docker $USER

# Install Rust toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Compile vim 8.2 on CentOS8
# https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source
git clone https://github.com/vim/vim.git
cd vim
rm -f src/auto/config.cache
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-python3interp=yes \
            --with-python3-config-dir=/lib64/python3.6/config-3.6m-x86_64-linux-gnu \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=/usr/local
make VIMRUNTIMEDIR=/usr/local/share/vim/vim82
```
