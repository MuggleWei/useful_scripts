#!/bin/bash

# copy .vimrc
cp -f .vimrc ~/.vimrc
mkdir -p ~/.vim/ftplugin
cp -rf ftplugin/* ~/.vim/ftplugin/

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

# ~/.vim/bundle/YouCompleteMe/install.py --clang-completer
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --clangd-completer --go-completer

# clangd
# see: https://clangd.llvm.org/installation.html
# install clangd, and use clangd recommend changing YCM's default settings(see clangd section in ftplugin/c.vim)
sudo apt-get install clangd-9
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100
