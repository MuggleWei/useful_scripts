#!/bin/bash

# handle argv
if [ "$#" -lt 2 ]; then
	echo "[ERROR] build.sh without args"
	echo "[ERROR] Usage: build.sh <Debug|Release|RelWithDebInfo|Coverage> <shared|static>"
	exit 1
else
	# to lowercase
	BUILD_TYPE=$(echo $1 | tr '[:upper:]' '[:lower:]')
	LIB_TYPE=$(echo $2 | tr '[:upper:]' '[:lower:]')
fi

if [ "$LIB_TYPE" = "shared" ]; then
	CMAKE_SHARED_LIBS=ON
else
	CMAKE_SHARED_LIBS=OFF
fi

echo "build type: $BUILD_TYPE"
echo "lib type: $LIB_TYPE"
echo "CMAKE_SHARED_LIBS: $CMAKE_SHARED_LIBS"

# variables
origin_dir="$(dirname "$(readlink -f "$0")")"
build_dir=$origin_dir/build
dist_dir=$origin_dir/dist

if [ -d $build_dir ]; then
	rm -rf $build_dir
fi
if [ -d $dist_dir ]; then
	rm -rf $dist_dir
fi

mkdir -p $build_dir

cmake \
	-S $origin_dir -B $build_dir \
	-DCMAKE_BUILD_TYPE=$BUILD_TYPE \
	-DBUILD_SHARED_LIBS=$CMAKE_SHARED_LIBS \
	-DCMAKE_INSTALL_PREFIX=$dist_dir
cmake --build $build_dir --config $BUILD_TYPE
cmake --build $build_dir --config $BUILD_TYPE --target install
