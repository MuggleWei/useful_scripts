#!/bin/bash

sudo apt-get install -y -qq polipo
sudo cp --force polipo_config /etc/polipo/config
sudo /etc/init.d/polipo restart
sudo cp --force set_http_proxy.sh /etc/profile.d/
