#!/bin/bash

# setup tmux
# cp $repo/tmux/.tmux.conf ~/

# setup provider python3
echo "install pynvim"
python3 -m pip install pynvim

# set config path
nvim_cfg_path=$HOME/.config/nvim
mkdir -p ${nvim_cfg_path}

# setup vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if [ $? -eq 0 ]
then
	echo "success get plug.vim"
else
	echo "failed get plug.vim from remote, use local plug.vim"
	autoload_path=$HOME/.local/share/nvim/site/autoload
	mkdir -p $autoload_path
	cp ../vim/vim-plug/plug.vim $autoload_path/
fi

# copy init.vim
cp init.vim ${nvim_cfg_path}/

# install language server

sudo apt-get install clangd-9
sudo ln -s clangd-9 /usr/bin/clangd

python3 -m pip install python-lsp-server

# Plugin install
echo "install plugins"
nvim +PlugInstall +qall

# # copy ftplugin
# mkdir -p ${nvim_cfg_path}/ftplugin
# cp -rf ftplugin/* ${nvim_cfg_path}/ftplugin/
