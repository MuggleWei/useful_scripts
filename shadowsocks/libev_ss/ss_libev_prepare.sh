#!/bin/bash

git checkout tags/v3.3.5

git submodule update --init

# Installation of libsodium
export LIBSODIUM_VER=1.0.16
wget https://download.libsodium.org/libsodium/releases/old/libsodium-$LIBSODIUM_VER.tar.gz

# Installation of MbedTLS
export MBEDTLS_VER=2.6.0
wget https://tls.mbed.org/download/mbedtls-$MBEDTLS_VER-gpl.tgz
