#!/bin/bash

# copy foo header and libs
pyfoo_build_dir=pyfoo/build
rm -rf $pyfoo_build_dir
mkdir -p $pyfoo_build_dir/foo
mkdir -p $pyfoo_build_dir/foo/include
mkdir -p $pyfoo_build_dir/foo/lib
cp -r cc_module/src/foo/*.h $pyfoo_build_dir/foo/include/
cp -r cc_module/build/lib/*.so $pyfoo_build_dir/foo/lib/

# swig pyfoo
mkdir -p $pyfoo_build_dir/pyfoo
cp pyfoo/foo.i $pyfoo_build_dir/pyfoo/
cd $pyfoo_build_dir/pyfoo
swig -python -c++ foo.i

# build pyfoo
cd ..
cmake ..
make

# copy pyfoo and foo
cd ../..
mkdir build
cp pyfoo/build/pyfoo/pyfoo.py build/
cp pyfoo/build/foo/lib/libfoo.so build/
cp pyfoo/build/lib/libpyfoo.so build/_pyfoo.so
