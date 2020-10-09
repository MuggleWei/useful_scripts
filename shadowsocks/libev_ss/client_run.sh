#!/bin/bash

# copy client config
sudo cp ./client_config.json /etc/shadowsocks-libev/server0.json

# start client
sudo systemctl restart shadowsocks-libev-local@server0.service

# make sure it's running
systemctl status shadowsocks-libev-local@server0.service
