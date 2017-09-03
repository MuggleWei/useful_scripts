#!/bin/bash

sudo echo "1" > /proc/sys/kernel/core_uses_pid
sudo echo "/corefile/core-%e-%p-%t" > /proc/sys/kernel/core_pattern
