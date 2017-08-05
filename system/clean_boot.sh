#!/bin/bash

sudo dpkg --list 'linux-image*'|awk '{ if ($1=="ii") print $2}'|grep -v `uname -r`|grep -v 'extra'|grep -v 'linux-image-generic' > tmp_clean.txt

while read line
do
	# echo $line
	sudo apt-get -y purge $line
done < tmp_clean.txt

sudo apt-get autoremove
sudo update-grub

rm -rf tmp_clean.txt
