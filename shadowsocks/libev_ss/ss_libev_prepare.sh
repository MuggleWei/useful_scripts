#!/bin/bash

git checkout tags/v3.3.6

git submodule update --init

# Installation of libsodium
export LIBSODIUM_VER=1.0.16
git clone https://github.com/jedisct1/libsodium.git --branch 1.0.16 --depth 1

# Installation of MbedTLS
export MBEDTLS_VER=2.6.0
git clone https://github.com/Mbed-TLS/mbedtls.git --branch mbedtls-2.6.0 --depth 1
