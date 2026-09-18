#!/bin/bash

origin_dir="$(dirname "$(readlink -f "$0")")"
root_dir=$origin_dir/..
deps_dir=$root_dir/_deps
dist_dir=$deps_dir/dist
stress_ng=$dist_dir/usr/bin/stress-ng
output_dir="$root_dir/output"
output_name="perf_bench.$(date +%Y%m%d-%H%M%S).log"
output="$output_dir/$output_name"

if [ ! -d $output_dir ]; then
	mkdir $output_dir
fi

echo "---- CPU ----" 2>&1 | tee -a "$output"
taskset -c 0-3 sudo $stress_ng --cpu 4 --cpu-method matrixprod --ignite-cpu --timeout 5m --thermalstat 5 --metrics-brief 2>&1 | tee -a "$output"

echo "---- Cache ----" 2>&1 | tee -a "$output"
taskset -c 0-3 sudo $stress_ng --cache 4 --ignite-cpu --timeout 5m --thermalstat 5 --metrics-brief 2>&1 | tee -a "$output"

echo "---- VM ----" 2>&1 | tee -a "$output"
taskset -c 0-3 sudo $stress_ng --vm 4 --vm-bytes 16g --ignite-cpu --timeout 5m --thermalstat 5 --metrics-brief 2>&1 | tee -a "$output"

echo "---- IO ----" 2>&1 | tee -a "$output"
taskset -c 0-3 sudo $stress_ng --io 4 --ignite-cpu --timeout 5m --thermalstat 5 --metrics-brief 2>&1 | tee -a "$output"
