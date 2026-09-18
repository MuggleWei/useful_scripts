#!/bin/bash

origin_dir="$(dirname "$(readlink -f "$0")")"
root_dir=$origin_dir/..
deps_dir=$root_dir/_deps
dist_dir=$deps_dir/dist

cd $dist_dir

#sudo ./usr/bin/stress-ng --matrix 0 --matrix-size 64 --tz --timeout 5m --thermalstat 5 --metrics-brief
 sudo ./usr/bin/stress-ng --cpu 0 --cpu-method matrixprod --tz --timeout 5m --thermalstat 10 --metrics-brief
