#!/bin/bash

host_name=""
addr=""

# check arguments
if [ $# -lt 2 ]; then
	echo "usage: $0 ip_addr host-name" 
	exit 1
fi
addr=$1
host_name=$2

# if [[ $string =~ .*:.* ]]
# then
# 	# IPv6
# 	addr=$1::443
# else
# 	# IPv4
# 	addr=$1:443
# fi

echo -- auto deploy docker registry in  $host_name [$addr]

# write host
echo -- update /etc/hosts
echo $addr $host_name >> /etc/hosts

# gen cert
echo -- generate certs
echo -- "#########################################################"
echo -- "## NOTE: must write  Common Name the same as your host"
echo -- "#########################################################"
mkdir -p ./certs
# openssl genrsa -out muggle.docker.com.key 2048
openssl req -newkey rsa:4096 -nodes -sha256 -keyout ./certs/$host_name.key -x509 -days 365 -out ./certs/$host_name.crt

# save cert and restart docker
echo -- save certs
mkdir -p /etc/docker/certs.d/$host_name
cp ./certs/$host_name.crt /etc/docker/certs.d/$host_name/

# restart docker
echo -- restart docker
service docker restart

# run registry
echo -- create private registry
./run_registry.sh certs/$host_name

# generate client auto deploy
echo -- generate client certs deploy
mkdir -p ./client_deploy
cp ./certs/$host_name.crt ./client_deploy/

echo -e "#!/bin/bash\n\
echo $addr $host_name >> /etc/hosts\n\
mkdir -p /etc/docker/certs.d/$host_name\n\
cp ./$host_name.crt /etc/docker/certs.d/$host_name/\n
service docker restart" > ./client_deploy/add_registry_cert.sh

chmod u+x ./client_deploy/add_registry_cert.sh
zip -r client_deploy.zip ./client_deploy/
rm -rf ./client_deploy
