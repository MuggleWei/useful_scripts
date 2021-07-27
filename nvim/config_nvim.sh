#!/bin/bash

# setup tmux
# cp $repo/tmux/.tmux.conf ~/

# setup provider python3
python3 -m pip install --user --upgrade pynvim

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
