#!/bin/bash

origin_dir="$(dirname "$(readlink -f "$0")")"
root_dir=$origin_dir/..
deps_dir=$root_dir/_deps

if [ -d $deps_dir ]; then
	rm -rf $deps_dir
fi
mkdir -p $deps_dir

echo "download c2c_benchmark"
cd $deps_dir
git clone https://github.com/MuggleWei/c2c_benchmark.git
cd c2c_benchmark
git checkout 33209bf7ba879d26908e0c7b19b4328e2e7b3b55

echo "download stress-ng"
cd $deps_dir
git clone https://github.com/ColinIanKing/stress-ng.git
cd stress-ng
git checkout V0.22.00
