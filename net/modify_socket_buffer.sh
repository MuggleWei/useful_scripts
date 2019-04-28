#!/bin/bash

echo "current receiver max:"
cat /proc/sys/net/core/rmem_max

echo "current receiver default:"
cat /proc/sys/net/core/rmem_default

echo "current sender max:"
cat /proc/sys/net/core/wmem_max

echo "current sender default:"
cat /proc/sys/net/core/wmem_default

echo "modify socket buffer"
sudo sysctl -w net.core.wmem_max=16777216
sudo sysctl -w net.core.rmem_max=16777216
sudo sysctl -w net.core.rmem_default=8388608

echo "after modify, receiver max:"
cat /proc/sys/net/core/rmem_max

echo "after modify, receiver default:"
cat /proc/sys/net/core/rmem_default

echo "after modify, sender max:"
cat /proc/sys/net/core/wmem_max

echo "after modify, sender default:"
cat /proc/sys/net/core/wmem_default
