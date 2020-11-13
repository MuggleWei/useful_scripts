#!/bin/bash

# login notify, source this_file.sh in ~/.bashrc
IP="$(echo $SSH_CONNECTION | cut -d " " -f 1)"
HOSTNAME=$(hostname)
NOW=$(date +"%Y-%m-%dT%H:%M:%S")

# notify
echo "$IP $HOSTNAME $NOW"
