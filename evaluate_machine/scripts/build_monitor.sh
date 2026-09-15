#!/bin/bash

origin_dir="$(dirname "$(readlink -f "$0")")"
root_dir=$origin_dir/..
py_dir=$root_dir/py_scripts

cd $py_dir
if [ ! -d venv ]; then
	python3 -m venv venv
fi
source venv/bin/activate
export PYTHONPATH=$PWD
pip install -r requirements.txt
