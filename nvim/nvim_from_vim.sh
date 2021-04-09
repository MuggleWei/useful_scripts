#!/bin/bash

# chdir to current path
cur_path=$(readlink -f "$(dirname "$0")")
cd $cur_path

# move init.vim to ~/.config/nvim/
mkdir -p ~/.config/nvim
cp ./init.vim ~/.config/nvim/
