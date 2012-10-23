
=============
Configuration
=============


Liquidprompt
============

This is a pretty elaborate zsh prompt, highly configurable,
bash / zsh compliant, supporting VCS, jobs, battery, and many others.

Copy liquidprompt as        ~/.liquidprompt   # edit to change prompt order
Copy liquidpromptrc-dist as ~/.liquidpromptrc # configuration, edit if needed

Copy .bashrc and .zshrc as usual in ~.
Change your default shell to zsh using ``chsh``.

If you want to add private aliases, edit a ~/.shell.aliases file.


VIM
===

Decompress the vim.tar.gz as ~/.vim
Copy .vimrc as ~/.vimrc.


SVN
===

For SVN colorization, edit the ~/.subversion/config to set the 
diff-cmd to colordiff. Make sure colordiff is installed, then copy
the .colordiffrc in ~. The resulting colors should be the same as git.


Git
===

Copy the .gitconfig in ~, edit the file to insert you name and mail.


fstab
=====

Editing /etc/fstab is required to mount ORI datacenter.
Edit this file as root and *carefully* copy the needed lines
from the local fstab file.

