#!/bin/bash

# NOTE: if build_nvim.sh set proxy, need remove proxy set, include config .wgetrc

# setup tmux
# cp $repo/tmux/.tmux.conf ~/

# get curl proxy
echo "Usage: $0 [cur_proxy]"
if [[ $# -gt 0 ]]; then
	echo "set curl proxy: $1"
	curl_proxy=$1
else
	echo "len(args) = $#, curl without proxy"
fi

# setup provider python3
echo "------------------------------"
echo "setup provider python3"
echo "------------------------------"

if [ -f "/etc/arch-release" ]; then
	sudo pacman -S python-pip
elif [ -f "/etc/lsb-release" ]; then
	sudo apt-get install python3-pip
fi

echo "install pynvim"
python3 -m pip install --user --upgrade pynvim

# set config path
echo "------------------------------"
echo "setup config path"
echo "------------------------------"

nvim_cfg_path=$HOME/.config/nvim
mkdir -p ${nvim_cfg_path}

# setup vim-plug
echo "------------------------------"
echo "setup vim-plug"
echo "------------------------------"

if [ -z "$curl_proxy" ]; then
	sh -c \
		'curl -fLo \
		"${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
else
	sh -c \
		"http_proxy=socks5://$curl_proxy \
		https_proxy=socks5://$curl_proxy \
		all_proxy=socks5://$curl_proxy \
		curl -fLo \
		\"${XDG_DATA_HOME:-$HOME/.local/share}\"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
fi

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
echo "------------------------------"
echo "setup init.vim"
echo "------------------------------"

cp init.vim ${nvim_cfg_path}/

# install language server
echo "------------------------------"
echo "install language server - c/c++"
echo "------------------------------"

if [ -f "/etc/arch-release" ]; then
	sudo pacman -S llvm clang
elif [ -f "/etc/lsb-release" ]; then
	sudo apt-get install clangd-9
	sudo ln -s clangd-9 /usr/bin/clangd
fi

echo "------------------------------"
echo "install language server - python"
echo "------------------------------"

#python3 -m pip install --user --upgrade python-lsp-server[all]
python3 -m pip install --user --upgrade pyright

echo "------------------------------"
echo "install language server - TypeScript"
echo "------------------------------"

npm install -g typescript-language-server typescript

# install plugins
echo "------------------------------"
echo "install plugins"
echo "------------------------------"

if [ -f "/etc/arch-release" ]; then
	sudo pacman -S fzf ripgrep ctags the_silver_searcher fd
elif [ -f "/etc/lsb-release" ]; then
	sudo apt install fzf ripgrep universal-ctags silversearcher-ag fd-find
fi

# Plugin install
echo "install plugins"
nvim +PlugInstall +qall

# copy ftplugin
echo "------------------------------"
echo "setup ftplugin"
echo "------------------------------"

mkdir -p ${nvim_cfg_path}/ftplugin
cp -rf ftplugin/* ${nvim_cfg_path}/ftplugin/

# copy .vsnip
echo "------------------------------"
echo "setup .vsnip"
echo "------------------------------"

mkdir -p $HOME/.vsnip
cp -rf ./.vsnip/* $HOME/.vsnip/
