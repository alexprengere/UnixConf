
=============
Configuration
=============

Automation
==========
You may install basic stuff::

 ./install_ubuntu.sh # or ./install_fedora.sh

You may deploy automatically using::

 ./deploy.sh

Generate vim directory with::

 rm -rf ~/.vim
 git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
 vim +BundleInstall +qall
 # If you use YCM plugin
 cd ~/.vim/bundle/YouCompleteMe
 ./install.sh # add --clang-completer for LLVM based autocomplete

Manually
========

Liquidprompt
------------
This is a pretty elaborate zsh prompt, highly configurable,
bash / zsh compliant, supporting VCS, jobs, battery, and many others.

Copy liquidprompt as        ~/.liquidprompt   # edit to change prompt order
Copy liquidpromptrc-dist as ~/.liquidpromptrc # configuration, edit if needed

Copy bashrc and zshrc as usual in ~.
Change your default shell to zsh using ``chsh``.

If you want to add private aliases, edit a ~/.shell.aliases file.

VIM
---
Copy vimrc as ~/.vimrc. Then generate the vim directory following instructions
in the ``Automation`` section.

Syntastic plugin uses pylint and jsl as syntax checkers.
Make sure your configuration files are reached for these ones.
Check the .vimrc to see where syntastic is looking for, usually ~/.pylintrc
and ~/.jsl.conf.

SVN
---
For SVN colorization, edit the ~/.subversion/config to set the 
diff-cmd to colordiff. Make sure colordiff is installed, then copy
the .colordiffrc in ~. The resulting colors should be the same as git.

Git
---
Copy the gitconfig in ~, edit the file to insert you name and mail.

fstab
-----
Editing /etc/fstab is required to mount ORI datacenter.
Edit this file as root and *carefully* copy the needed lines
from the local fstab file.

