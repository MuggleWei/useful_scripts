#!/bin/bash

# inspired by: https://wiki.alienbase.nl/doku.php?id=linux:kernelbuilding

# handle argv
if [ "$#" -lt 1 ]; then
	echo "[ERROR] Usage: build_kernel.sh <kernel-version> <kernel-source-directory>"
	exit 1
fi

kernel_ver=$1
kernel_src_dir=$2

# prepare output directory
origin_dir="$(dirname "$(readlink -f "$0")")"
result_dir=$origin_dir/build/linux-$kernel_ver
mkdir -p $result_dir
mkdir -p $result_dir/boot
mkdir -p $result_dir/lib/modules

# chdir to kernel source directory
echo "kernel source in directory: $kernel_src_dir"
cd $kernel_src_dir

# configuring, uncomment 1 below
#make menuconfig
#zcat /proc/config.gz > .config
make defconfig

make oldconfig

# build kernel
make bzImage modules

make modules_install INSTALL_MOD_PATH=$result_dir
cp arch/x86/boot/bzImage $result_dir/boot/vmlinuz-$kernel_ver
cp System.map $result_dir/boot/System.map-$kernel_ver
cp .config $result_dir/boot/config-$kernel_ver

rm -rf $result_dir/lib/modules/$kernel_ver/build
rm -rf $result_dir/lib/modules/$kernel_ver/source
