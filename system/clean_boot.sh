#!/bin/bash

sudo dpkg --list 'linux-image*'|awk '{ if ($1=="ii") print $2}'|grep -v `uname -r`|grep -v 'extra' > tmp_clean.txt

while read line
do
	echo clean $line
	sudo apt-get purge $line
done < clean_tmp.txt
rm -rf tmp_clean.txt

sudo apt-get autoremove
sudo update-grub
