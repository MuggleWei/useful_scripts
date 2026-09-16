#!/bin/bash

origin_dir="$(dirname "$(readlink -f "$0")")"
root_dir=$origin_dir/..
py_dir=$root_dir/py_scripts

cd $py_dir
source venv/bin/activate
export PYTHONPATH=$PWD
python monitor_sys.py
