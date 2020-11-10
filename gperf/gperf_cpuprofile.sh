#!/bin/bash

# get exe file name
if [ $# -lt 1 ]; then
    echo "usage: $0 exe_filepath"
    exit 1
fi
exe_path=$1
exe_name=$(basename -- $1)
echo "exe_pathfile: $exe_path"
echo "exe_name: $exe_name"

# find libprofiler.so
libprofiler_paths=`whereis libprofiler`
libprofiler_path=""
for word in $libprofiler_paths
do
	if [[ "$word" == *.so ]];
	then
		libprofiler_path=$word
	fi
done

if [ -z "$libprofiler_path" ]; then
	echo "failed find libprofiler.so"
	exit 1
fi
echo "find libprofiler.so: $libprofiler_path"

# run with gproftools cpu profiler
env LD_PRELOAD="$libprofiler_path" CPUPROFILE=$exe_name.prof $exe_path

# generate output
echo "generate callgrind"
pprof --callgrind $exe_path $exe_name.prof > $exe_name.callgrind
echo "generate txt"
pprof --text $exe_path $exe_name.prof > $exe_name.prof.txt
