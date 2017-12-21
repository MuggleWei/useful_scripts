#!/bin/bash

#########################
# use who -H to see tty or pts, and input as argument

if [ $# -lt 1 ]; then
	echo "usage: $0 tty" 
	exit 1
fi

sudo peekfd -8cnd $(ps -fat | grep "$1 *Ss" | awk '{print$1}') 0 1 2
