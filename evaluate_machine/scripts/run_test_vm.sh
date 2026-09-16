#!/bin/bash

origin_dir="$(dirname "$(readlink -f "$0")")"
root_dir=$origin_dir/..
deps_dir=$root_dir/_deps
dist_dir=$deps_dir/dist

cd $dist_dir

#./usr/bin/stress-ng --vm 0 --vm-bytes 90% --timeout 1h --metrics-brief
./usr/bin/stress-ng --vm 0 --vm-bytes 32g --timeout 1h --metrics-brief
