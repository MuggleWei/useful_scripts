#!/bin/bash

# copy .vimrc
cp -f .vimrc ~/.vimrc
cp -rf ftplugin ~/.vim/ 

# git clone vundle
if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Plugin Install
vim +PluginInstall +qall

# for taglist and tagbar
sudo apt-get install exuberant-ctags

# powerline fonts
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd ..
rm -rf fonts

# YCM
sudo apt-get install build-essential cmake
sudo apt-get install python-dev python3-dev
~/.vim/bundle/YouCompleteMe/install.py --clang-completer
