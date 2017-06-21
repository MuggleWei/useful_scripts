#!/bin/bash

repo_name=""
user_name="git"
repo_dir="/srv/git_repo"

# check arguments
if [ $# -lt 1 ]; then
	echo "usage: $0 git-repo-name [user-name] [repo_dir]"
	exit 1
fi

# ensure repo_name end up with .git
if [[ $1 != *.git ]]; then
	repo_name=$1.git
else
	repo_name=$1
fi

# set user
if [ $# -ge 2 ]; then
	user_name=$2
fi

# set repo directory 
if [ $# -ge 3 ]; then
	repo_dir=$3
fi

# check user exist
grep "^$user_name" /etc/passwd >& /dev/null
if [ $? -ne 0 ]; then
	echo "the user($user_name) is not exist, can't create git repo"
	exit 1
fi

# ensure repo_dir exist
if [ ! -d $repo_dir ]; then
	sudo mkdir $repo_dir
	sudo chown -R $user_name:$user_name $repo_dir
fi

# create git repo
sudo git init --bare $repo_dir/$repo_name
sudo chown -R $user_name:$user_name $repo_dir/$repo_name
