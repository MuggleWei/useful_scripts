#!/bin/bash

# check arguments
user_name=""
passphrase=""
if [ $# -lt 2 ]; then
	echo "usage: $0 user_and_key_name passphrase" 
	exit 1
fi
user_name=$1
passphrase=$2

# create user
sudo adduser \
	--home /home/$user_name \
	--disabled-password \
	$user_name    

# add user to sudo and sudo without password
sudo usermod -aG sudo $user_name
echo "$user_name ALL=(ALL) NOPASSWD:ALL" |sudo tee /etc/sudoers.d/${user_name}_sudo_without_passwd

# create .ssh
sudo mkdir /home/$user_name/.ssh              
sudo chown $user_name:$user_name /home/$user_name/.ssh

# gen key
ssh-keygen -q -N $passphrase -f $user_name
cat ./$user_name.pub > authorized_keys 
sudo chmod 600 $user_name $user_name.pub authorized_keys
sudo mv $user_name $user_name.pub authorized_keys /home/$user_name/.ssh/
sudo chown $user_name:$user_name \
	/home/$user_name/.ssh/$user_name \
	/home/$user_name/.ssh/$user_name.pub \
	/home/$user_name/.ssh/authorized_keys
sudo chmod 700 /home/$user_name/.ssh

# exit to root and restart sshd
sudo service sshd restart
