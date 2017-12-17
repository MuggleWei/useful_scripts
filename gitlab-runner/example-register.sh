#!/bin/bash

sudo gitlab-runner register -n \
	--url http://192.168.0.104/ \
	--registration-token uGer6fXfYTWA7vGR9rXp \
	--executor shell \
	--description "ci-java" \
	--docker-extra-hosts ["muggle.docker.com:192.168.0.102"]

sudo usermod -aG docker gitlab-runner

sudo -u gitlab-runner -H docker info
