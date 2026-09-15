#!/bin/bash

origin_dir="$(dirname "$(readlink -f "$0")")"
root_dir=$origin_dir/..
deps_dir=$root_dir/_deps
dist_dir=$deps_dir/dist

cd $dist_dir

./bin/c2c_benchmark_chan -p 0,1,2,3 -c 4

cat ./c2c_benchmark_reports/statistics_chan_wr_c4_to_c4.csv
