#!/bin/bash

# gen private key
openssl genrsa -des3 -out private.key 2048

# gen ca
openssl req -new -key private.key -out server.csr

# gen server private key
openssl rsa -in private.key -out server.key

# gen server ca
openssl x509 -req -in server.csr -out server.crt -outform pem -signkey server.key -days 3650
