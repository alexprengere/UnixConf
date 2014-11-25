Configuration
=============

Automation
----------

You may install basic stuff:
```bash
 ./install_ubuntu.sh # or ./install_fedora.sh
```
You may deploy automatically using:
```bash
 ./deploy.sh
```
Generate vim directory with:
```bash
 rm -rf ~/.vim
 git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
 vim +BundleInstall +qall
 # If you use YCM plugin
 cd ~/.vim/bundle/YouCompleteMe
 ./install.sh # add --clang-completer for LLVM based autocomplete
```

Manually
--------

### Liquidprompt

This is a pretty elaborate zsh prompt, highly configurable, bash / zsh
compliant, supporting VCS, jobs, battery, and many others.

```bash
cp liquidprompt ~/.liquidprompt
cp liquidpromptrc-dist a~/.liquidpromptrc # configuration, edit if
needed
cp bashrc ~/.bashrc
cp zshrc ~/.zshrc
chsh # change default shell to zsh
```
If you want to add private aliases, edit a `~/.shell.aliases` file.

### VIM
```bash
cp vimrc ~/.vimrc
```
Then generate the vim directory usgin same instructions in the `Automation` section.
```bash
 rm -rf ~/.vim
 git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
 vim +BundleInstall +qall
 # If you use YCM plugin
 cd ~/.vim/bundle/YouCompleteMe
 ./install.sh # add --clang-completer for LLVM based autocomplete
```

Syntastic plugin uses pylint and jsl as syntax checkers. Make sure your
configuration files are reached for these ones. Check the `.vimrc` to see
where syntastic is looking for, usually `~/.pylintrc` and `~/.jsl.conf`.

### SVN

For SVN colorization, edit the `~/.subversion/config` to set the diff-cmd
to colordiff. Make sure colordiff is installed.
```bash
cp colordiffrc ~/.colordiffrc
```

### Git

```bash
cp gitconfig ~/.gitconfig
```

### fstab

Editing `/etc/fstab` is required to mount stuff. Edit this file
as root and *carefully* copy the needed lines from the local fstab file.
