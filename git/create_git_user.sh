#!/bin/bash

user_name=""

# check argument
if [ $# -lt 1 ]; then
	echo "usage: $0 git-user-name" 
	exit 1
fi

# if user is not exist, then create user
user_name=$1
grep "^$user_name" /etc/passwd >& /dev/null
if [ $? -ne 0 ]; then
	sudo useradd $user_name -m -d /home/$user_name -s /bin/bash
	sudo passwd $user_name
	sudo su -c "ssh-keygen -f /home/$user_name/.ssh/id_rsa" $user_name
	sudo su -c "touch /home/$user_name/.ssh/authorized_keys" $user_name
	if [ -f /usr/bin/git-shell ]; then
		sudo chsh -s /usr/bin/git-shell git
	fi
else
	echo "The user($user_name) already exist"
	exit 1
fi

