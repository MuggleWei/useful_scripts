#!/bin/bash

# clone neovim
git clone https://github.com/neovim/neovim --branch=v0.5.0 --depth=1
cd neovim

# Build prerequisites
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

# Build
make CMAKE_BUILD_TYPE=Release

# Install
sudo make install
