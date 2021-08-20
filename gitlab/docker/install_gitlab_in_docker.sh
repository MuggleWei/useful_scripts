#!/bin/bash

# if in china, pull image from mirror first
# sudo docker pull registry.docker-cn.com/gitlab/gitlab-ce:latest
# sudo docker tag registry.docker-cn.com/gitlab/gitlab-ce:latest gitlab/gitlab-ce:latest

sudo docker run --detach \
	--hostname muggle.gitlab.com \
	--publish 443:443 --publish 80:80 --publish 5022:22 \
	--name gitlab \
	--restart always \
	--volume $PWD/gitlab/config:/etc/gitlab \
	--volume $PWD/gitlab/logs:/var/log/gitlab \
	--volume $PWD/gitlab/data:/var/opt/gitlab \
	gitlab/gitlab-ce:latest
