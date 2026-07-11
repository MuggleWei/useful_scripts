#!/bin/bash

if [ "$#" -lt 1 ]; then
	TARGET_CPU=cpu0
else
	TARGET_CPU=cpu$1
fi

min_freq=$(cat /sys/devices/system/cpu/$TARGET_CPU/cpufreq/cpuinfo_min_freq)
max_freq=$(cat /sys/devices/system/cpu/$TARGET_CPU/cpufreq/cpuinfo_max_freq)
scaling_driver=$(cat /sys/devices/system/cpu/$TARGET_CPU/cpufreq/scaling_driver)
scaling_gover=$(cat /sys/devices/system/cpu/$TARGET_CPU/cpufreq/scaling_governor)
scaling_available_gover=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors)
scaling_min_freq=$(cat /sys/devices/system/cpu/$TARGET_CPU/cpufreq/scaling_min_freq)
scaling_max_freq=$(cat /sys/devices/system/cpu/$TARGET_CPU/cpufreq/scaling_max_freq)
scaling_cur_freq=$(cat /sys/devices/system/cpu/$TARGET_CPU/cpufreq/scaling_cur_freq)

echo "----------------"
echo "CPU($TARGET_CPU) drivers and freq:"
echo "cpuinfo_min_freq: ${min_freq}"
echo "cpuinfo_max_freq: ${max_freq}"
echo "scaling_driver: ${scaling_driver}"
echo "scaling_gover: ${scaling_gover}"
echo "scaling_available_gover: ${scaling_available_gover}"
echo "scaling_min_freq: ${scaling_min_freq}"
echo "scaling_max_freq: ${scaling_max_freq}"
echo "scaling_cur_freq: ${scaling_cur_freq}"
