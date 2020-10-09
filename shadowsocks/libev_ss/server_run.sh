#!/bin/bash

# copy server config
sudo cp /etc/shadowsocks-libev/config.json /etc/shadowsocks-libev/config_bak.json
sudo cp ./server_config.json /etc/shadowsocks-libev/config.json

# restart shadowsocks
sudo systemctl restart shadowsocks-libev.service

# check status, make sure it’s running
systemctl status shadowsocks-libev.service
