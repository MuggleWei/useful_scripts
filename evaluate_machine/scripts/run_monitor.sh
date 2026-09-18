#!/bin/bash

if [ "$#" -lt 1 ]; then
	echo "[ERROR] Usage: run_monitor.sh <moniter_interval>"
	exit 1
fi

origin_dir="$(dirname "$(readlink -f "$0")")"
root_dir=$origin_dir/..
py_dir=$root_dir/py_scripts

cd $py_dir
source venv/bin/activate
export PYTHONPATH=$PWD
python monitor_sys.py $1
