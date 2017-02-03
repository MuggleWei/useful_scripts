#!/bin/bash

# git clone vundle
if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Plugin Install
vim +PluginInstall +qall

# YCM
sudo apt-get install build-essential cmake
sudo apt-get install python-dev python3-dev
~/.vim/bundle/YouCompleteMe/install.py --clang-completer
