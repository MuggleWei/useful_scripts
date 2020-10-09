#!/bin/bash

# restart shadowsocks
sudo systemctl restart shadowsocks-libev.service

# check status, make sure it’s running
systemctl status shadowsocks-libev.service
