#!/bin/bash

# use this script, ensure $? == 0

if [ $# -lt 1 ]; then
	echo "usage: $0 program_key_word" 
	exit 1
fi
key_word=$1

arr=$(ps aux | grep "[^]]${key_word}" | awk '{print $2}')

for i in "${arr[@]}"
do
	if test -z "$i"
	then
		echo "nothing to kill"
	else
		# echo "$i is NOT empty"
		echo "kill -9 $i"
		kill -9 $i
	fi  
done

