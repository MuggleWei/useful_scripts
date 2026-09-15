#!/bin/bash

origin_dir="$(dirname "$(readlink -f "$0")")"
root_dir=$origin_dir/..
deps_dir=$root_dir/_deps
dist_dir=$deps_dir/dist

echo "----------------"
echo "build c2c_benchmark"
echo "----------------"
echo ""
cd $deps_dir/c2c_benchmark
mkdir build
cmake \
	-S . \
	-B build \
	-DCMAKE_BUILD_TYPE=Release \
	-DBUILD_SHARED_LIBS=OFF \
	-DCMAKE_INSTALL_PREFIX=$dist_dir
cmake --build build --target install

echo "----------------"
echo "build stress-ng"
echo "----------------"
echo ""
cd $deps_dir/stress-ng
make clean
make
make install DESTDIR=$dist_dir
