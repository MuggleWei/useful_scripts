#!/bin/bash

# copy .vimrc
echo "initialize vim directory"
cp -f .vimrc ~/.vimrc
mkdir -p ~/.vim/ftplugin
cp -rf ftplugin/* ~/.vim/ftplugin/

# install vim-plug
echo "install vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Plugin install
echo "install plugins"
vim +PlugInstall +qall

# for taglist and tagbar
sudo apt-get install exuberant-ctags

# powerline fonts
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd ..
rm -rf fonts

# clangd
# see: https://clangd.llvm.org/installation.html
# install clangd, and use clangd recommend changing YCM's default settings(see clangd section in ftplugin/c.vim)
sudo apt-get install clangd-9
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100

# YCM
sudo apt-get install build-essential cmake
sudo apt-get install python-dev python3-dev

# ~/.vim/plugged/YouCompleteMe/install.py --clang-completer
cd ~/.vim/plugged/youcompleteme
python3 install.py --clangd-completer --go-completer
