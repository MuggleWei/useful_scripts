#!/bin/bash

TARGET_FREQ=3200000 

echo "----------------"
echo "try to force lock cpu min freq"
echo $TARGET_FREQ | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq

echo "----------------"
echo "try to force lock cpu max freq"
echo $TARGET_FREQ | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq

echo "----------------"
echo "CPU scaling_cur_freq"
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq

