#!/bin/bash

# install shadowsocks-libev
sudo apt update
sudo apt install shadowsocks-libev

# Shadowsocks-libev (the server) will automatically start after being installed, need to stop server
sudo systemctl stop shadowsocks-libev

# disable auto-start at boot time
sudo systemctl disable shadowsocks-libev
