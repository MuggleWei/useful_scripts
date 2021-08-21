#!/bin/bash

cur_path=$(readlink -f "$(dirname "$0")")
cd $cur_path

mkdir build
cd build
rm -rf *

# passphrase for private key
passwd=xyz123
name=domain

# gen encrypted private key
echo "----------------------------------"
echo "gen encrypted private key"
openssl genrsa -aes256 -passout pass:$passwd -out encrypted.key 2048

# get private key
echo "----------------------------------"
echo "unencrypted private key"
openssl rsa -in encrypted.key -passin pass:$passwd -out $name.key

# gen public key
openssl rsa -in $name.key -pubout -out pubkey.pem

# gen csr from private key
echo "----------------------------------"
echo "generate CSR"
#openssl req \
#    -key $name.key \
#    -subj "/C=CN/ST=Shang Hai/L=null/O=null/CN=127.0.0.1" \
#    -new -out $name.csr
openssl req -key $name.key -config $cur_path/openssl.cnf -new -out $name.csr

# view CSR
echo "----------------------------------"
echo "view CSR"
openssl req -in $name.csr -noout -text

# gen PEM self-signed certificate from private key and csr
echo "----------------------------------"
echo "generate self-signed certificate"
#openssl x509 -req \
#    -days 3650 \
#    -in $name.csr \
#    -signkey $name.key \
#    -outform pem -out $name.crt

# NOTE: must set -extfile for subjectAltName 
openssl x509 -req \
	-days 3650 \
	-in $name.csr \
	-signkey $name.key \
	-outform pem -out $name.crt -extfile $cur_path/v3.ext

# view crt
echo "----------------------------------"
echo "view crt"
openssl x509 -in $name.crt -noout -text
