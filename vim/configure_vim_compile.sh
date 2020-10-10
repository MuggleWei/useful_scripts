#!/bin/bash

# remove files from previous compilation
sudo make distclean

# config
./configure \
	--with-features=huge \
	--enable-multibyte \
	--enable-python3interp \
	--with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu
