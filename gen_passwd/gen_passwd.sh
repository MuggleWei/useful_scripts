#!/bin/bash

# 产生num个长度为len的随机密码
num=10
len=16
cat /dev/urandom | tr -dc 'a-zA-Z0-9!@#$%^&*()_+' | fold -w $len | head -n $num
