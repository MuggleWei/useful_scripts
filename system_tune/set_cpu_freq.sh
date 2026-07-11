#!/bin/bash

TARGET_FREQ=3.2GHz

# set userspace governor
echo "----------------"
echo "set governor to userspace"
sudo cpupower frequency-set -g userspace

# set frequency
echo "----------------"
echo "set cpu frequency"
sudo cpupower frequency-set -f $TARGET_FREQ
#sudo cpupower frequency-set --max $TARGET_FREQ --min $TARGET_FREQ

# show current frequency
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
