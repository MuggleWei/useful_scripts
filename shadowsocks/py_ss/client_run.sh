#!/bin/bash

cur_dir=`pwd`
sudo sslocal -c $cur_dir/client_config.json -d start
# export http_proxy="http://127.0.0.1:8123/"
