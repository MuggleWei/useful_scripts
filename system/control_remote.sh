#!/bin/bash

#########################
# use who -H to see tty or pts, and example input /dev/pts/1 to control pts/1

if [ $# -lt 1 ]; then
	echo "usage: $0 tty" 
	exit 1
fi

sudo script -f $1
