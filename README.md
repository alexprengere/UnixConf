Environment setup
=================

Installation
------------
Install basic packages:
```bash
./install_ubuntu.sh # or ./install_fedora.sh
```
`Ag` may not be in the repositories. If not, try installing from source.
```bash
# Prerequisistes
# apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
# yum -y install pkgconfig automake gcc zlib-devel pcre-devel xz-devel
git clone https://github.com/ggreer/the_silver_searcher.git
cd the_silver_searcher
./build.sh
sudo make install
```

Deploy config
-------------
```bash
./deploy.sh
```

Vim directory
-------------
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

Wrap things up
--------------

```bash
chsh                # change default shell to zsh
ssh-keygen -t rsa   # generate your ssh keys
```

