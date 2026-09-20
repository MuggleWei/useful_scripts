#!/bin/bash

## Debian / Ubuntu
sudo apt-get update
sudo apt-get install --no-install-recommends build-essential cmake libpcre2-dev asciidoc xmlto libev-dev libc-ares-dev libmbedtls-dev libsodium-dev pkg-config

# Installation of libsodium
pushd libsodium
./configure --prefix=/usr && make
sudo make install
popd
sudo ldconfig

# Installation of MbedTLS
pushd mbedtls
make SHARED=1 CFLAGS="-O2 -fPIC"
sudo make DESTDIR=/usr install
popd
sudo ldconfig

# Start building
mkdir -p build && cd build
cmake ..
make
sudo make install
