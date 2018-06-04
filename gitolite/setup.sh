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
	echo "create new user for git repo"
	sudo adduser \
    		--system \
    		--shell /bin/bash \
    		--gecos 'git version control' \
    		--group \
    		--disabled-password \
    		--home /home/$user_name \
    		$user_name
else
	echo "The user($user_name) already exist"
fi

# gen key
ssh-keygen -f $user_name
pub=$PWD/$user_name.pub

# install gitolite
cd /home/$user_name
sudo -H -u git git clone git://github.com/sitaramc/gitolite
sudo -H -u git mkdir -p /home/$user_name/bin
sudo -H -u git gitolite/install -to /home/$user_name/bin

sudo -H -u git env PATH=$PATH:/home/$user_name/bin gitolite setup -pk $pub

