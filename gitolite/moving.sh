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

# unzip migrate package
origin_dir="$(dirname "$(readlink -f "$0")")"
cp $origin_dir
unzip gitolite_migrate.zip
mv gitolite_migrate/gitolite-admin . 

sudo mv gitolite_migrate /home/$user_name/
sudo chown -R $user_name:$user_name /home/$user_name/gitolite_migrate

# install gitolite
cd /home/$user_name
#sudo -H -u git git config --global http.https://github.com.proxy socks5://127.0.0.1:1080
sudo -H -u git git clone https://github.com/sitaramc/gitolite.git
sudo -H -u git mkdir -p /home/$user_name/bin
sudo -H -u git gitolite/install -to /home/$user_name/bin

# set admin key
sudo -H -u git env PATH=$PATH:/home/$user_name/bin gitolite setup -pk ./gitolite_migrate/keys/$user_name.pub

# copy rc file
mv ./gitolite_migrate/.gitolite.rc .

# copy all repositories
mv ./gitolite_migrate/repositories/* /home/$user_name/repositories/
