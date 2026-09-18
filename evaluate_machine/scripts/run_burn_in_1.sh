#!/bin/bash

origin_dir="$(dirname "$(readlink -f "$0")")"
root_dir=$origin_dir/..
deps_dir=$root_dir/_deps
dist_dir=$deps_dir/dist
stress_ng=$dist_dir/usr/bin/stress-ng
output_dir="$root_dir/output"
output_name="burn_in_1.$(date +%Y%m%d-%H%M%S).log"
output="$output_dir/$output_name"

if [ ! -d $output_dir ]; then
	mkdir $output_dir
fi

# ./usr/bin/stress-ng --cpu 0 --cache 4 --vm 2 --vm-bytes 64g --timeout 1h --metrics-brief
sudo $stress_ng --cpu 0 --cpu-method matrixprod --matrix 0 --mq 0 --vm 0 --vm-bytes 90% --cache 0 --ignite-cpu --timeout 30m --thermalstat 30 --metrics-brief 2>&1 | tee -a "$output"
