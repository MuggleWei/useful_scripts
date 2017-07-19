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
    		--shell /bin/sh \
    		--gecos 'git version control' \
    		--group \
    		--disabled-password \
    		--home /srv/git \
    		git
else
	echo "The user($user_name) already exist"
fi

# install git, python-setuptools and gitosis
sudo apt-get install git
sudo apt-get install python-setuptools
git clone https://github.com/tv42/gitosis.git
cd gitosis
sudo python setup.py install

# init gitosis
ssh-keygen -f ~/.ssh/id_rsa
sudo -H -u git gitosis-init < ~/.ssh/id_rsa.pub
