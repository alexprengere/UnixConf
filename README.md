Configuration
=============

Installation
------------

Install basic packages:
```bash
./install_ubuntu.sh # or ./install_fedora.sh
```
You may copy automatically the configuration:
```bash
./deploy.sh
```
Generate vim directory with:
```bash
rm -rf ~/.vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
# Finish YCM plugin installation
cd ~/.vim/bundle/YouCompleteMe
./install.sh # --clang-completer for LLVM based autocomplete
```
Syntastic plugin uses `pylint` and `jsl` as syntax checkers. Make sure these are
installed and configuration files are there. Check the `.vimrc` to see
where syntastic is looking for, usually `~/.pylintrc` and `~/.jsl.conf`.

A plugin also use `ag`, make sure this is installed (either from install script,
or install it manually from sources, see below).

Details
-------

### Prompt (zsh + liquidprompt)

Liquidprompt is an elaborate prompt, highly configurable, bash / zsh
compliant, supporting VCS, jobs, battery, etc...
```bash
cp liquidprompt ~/.liquidprompt
cp liquidpromptrc-dist ~/.liquidpromptrc # configuration, edit if needed
cp bashrc ~/.bashrc
cp zshrc ~/.zshrc
chsh # change default shell to zsh
```

### SVN

For SVN colorization, edit the `~/.subversion/config` to set the `diff-cmd`
to `colordiff`. Make sure `colordiff` is installed.
```bash
cp colordiffrc ~/.colordiffrc
```

### Ag

This may be installed automatically with the install script if packages are available.
If not, try installing from source.
```bash
# Prerequisistes
# apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
# yum -y install pkgconfig automake gcc zlib-devel pcre-devel xz-devel
git clone https://github.com/ggreer/the_silver_searcher.git
cd the_silver_searcher
./build.sh
sudo make install
```

### fstab

Editing `/etc/fstab` is required to mount stuff. Edit this file
as root and *carefully* copy the needed lines from the local fstab file.

