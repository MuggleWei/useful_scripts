#!/bin/bash

cur_dir=`pwd`
sudo ssserver -c $cur_dir/server_config.json -d start

# if failed, try below
# sudo python /path/to/ssserver -c `pwd`/multi_config.json -d start