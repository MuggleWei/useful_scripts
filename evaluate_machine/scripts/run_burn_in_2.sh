#!/bin/bash

origin_dir="$(dirname "$(readlink -f "$0")")"
root_dir=$origin_dir/..
deps_dir=$root_dir/_deps
dist_dir=$deps_dir/dist
stress_ng=$dist_dir/usr/bin/stress-ng
output_dir="$root_dir/output"
output_name="burn_in_2.$(date +%Y%m%d-%H%M%S).log"
output="$output_dir/$output_name"

if [ ! -d $output_dir ]; then
	mkdir $output_dir
fi

#sudo ./usr/bin/stress-ng --matrix 0 --matrix-size 64 --tz --timeout 5m --thermalstat 5 --metrics-brief
sudo $stress_ng --cpu 0 --cpu-method matrixprod --tz --timeout 5m --thermalstat 10 --metrics-brief 2>&1 | tee -a "$output"
