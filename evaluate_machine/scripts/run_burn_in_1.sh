#!/bin/bash

origin_dir="$(dirname "$(readlink -f "$0")")"
root_dir=$origin_dir/..
deps_dir=$root_dir/_deps
dist_dir=$deps_dir/dist

cd $dist_dir

# ./usr/bin/stress-ng --cpu 0 --cache 4 --vm 2 --vm-bytes 64g --timeout 1h --metrics-brief
sudo ./usr/bin/stress-ng --cpu 0 --cpu-method matrixprod --matrix 0 --mq 0 --vm 0 --vm-bytes 90% --cache 0 --ignite-cpu --timeout 30m --thermalstat 30 --metrics-brief
