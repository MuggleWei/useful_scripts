#!/bin/bash


cert=""

# check arguments
if [ $# -lt 1 ]; then
	echo "usage: $0 cert" 
	exit 1
fi
cert=$1

mkdir -p registry
sudo docker run -d \
	--restart=always \
	--name registry \
	-e REGISTRY_HTTP_ADDR=0.0.0.0:5000 \
	-v $PWD/certs:/certs \
	-v $PWD/registry:/var/lib/registry \
	-e REGISTRY_HTTP_TLS_CERTIFICATE=$cert.crt \
	-e REGISTRY_HTTP_TLS_KEY=$cert.key \
	-p 443:5000 \
	registry:2
