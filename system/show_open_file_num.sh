#!/bin/bash

# first col: number of open file
# second col: pid
sudo lsof -n|awk '{print $2}'|sort|uniq -c|sort -nr|more
