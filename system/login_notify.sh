#!/bin/bash

# login notify, source this_file.sh in ~/.bashrc
IP="$(echo $SSH_CONNECTION | cut -d " " -f 1)"
HOSTNAME=$(hostname)
NOW=$(date +"%Y-%m-%dT%H:%M:%S")

# change dir to this script path
cur_path=$(readlink -f "$(dirname "$0")")
cd $cur_path

# notify
echo "$IP $HOSTNAME $NOW"
