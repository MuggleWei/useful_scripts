#!/bin/bash

# clone neovim
git clone https://github.com/neovim/neovim --branch=0.5.0 --depth=1
cd neovim

# Build prerequisites
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

# Build
# NOTE: maybe need proxy in some situation
# export http_proxy=socks5://127.0.0.1:1080
# export https_proxy=socks5://127.0.0.1:1080
# git config --global http.proxy 'socks5://127.0.0.1:1080'
# git config --global https.proxy 'socks5://127.0.0.1:1080'
# 
# NOTE: maybe need set hosts in /etc/hosts in some situation
# 151.101.0.133 raw.githubusercontent.com
make CMAKE_BUILD_TYPE=Release

# Install
sudo make install
