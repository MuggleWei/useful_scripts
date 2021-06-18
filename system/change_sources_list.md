# 切换ubuntu源
1. 备份原文件
```
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
```
2. 查看版本代号
```
lsb_release -c
```
3. 编辑sources.list
```
sudo vim /etc/apt/sources.list

替换为对应条目

deb http://mirrors.xxx.com/ubunt/ ${2中查到到代号} main restricted universe multiverse
......
```
4. 更新软件列表
```
sudo apt-get update
```
