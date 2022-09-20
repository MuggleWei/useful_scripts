#!/bin/bash

# NOTE: maybe need set proxy and hosts in some situation
#
# ----- set http & https proxy -----
# export all_proxy=socks5://127.0.0.1:1080
# export http_proxy=socks5://127.0.0.1:1080
# export https_proxy=socks5://127.0.0.1:1080
# export HTTP_PROXY=socks5://127.0.0.1:1080
# export HTTPS_PROXY=socks5://127.0.0.1:1080
#
# ----- set git proxy -----
# git config --global http.proxy 'socks5://127.0.0.1:1080'
# git config --global https.proxy 'socks5://127.0.0.1:1080'
#
# ----- set wget proxy -----
# touch ~/.wgetrc
# write the ~/.wgetrc config
# ```
# use_proxy=on
# http_proxy=http://127.0.0.1:1080
# https_proxy=http://127.0.0.1:1080
# ```

# build type
BUILD_TYPE=Release
INSTALL_DIR=/opt/neovim/

# script directory
origin_dir="$(dirname "$(readlink -f "$0")")"
cd $origin_dir

# build prerequisites
echo "------------------------------"
echo "build prerequisites"
echo "------------------------------"

if [ -f "/etc/arch-release" ]; then
	sudo pacman -S base-devel cmake unzip ninja tree-sitter curl wget
elif [ -f "/etc/lsb-release" ]; then
	sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl wget doxygen
fi

# clone neovim
echo "------------------------------"
echo "clone neovim"
echo "------------------------------"

git clone https://github.com/neovim/neovim --branch=v0.7.2 --depth=1
cd $origin_dir/neovim

# #########################################
# # normal
# 
# # Build
# make CMAKE_BUILD_TYPE=Release
# 
# # Install
# sudo make install

#########################################
# separating dependencies and neovim 
echo "------------------------------"
echo "build dependencies"
echo "------------------------------"

mkdir -p $origin_dir/neovim/.deps
cd $origin_dir/neovim/.deps
cmake ../third-party/ -DCMAKE_BUILD_TYPE=$BUILD_TYPE
make

echo "------------------------------"
echo "build neovim"
echo "------------------------------"

cd ..
mkdir $origin_dir/neovim/build
cd $origin_dir/neovim/build
cmake .. -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR
make
