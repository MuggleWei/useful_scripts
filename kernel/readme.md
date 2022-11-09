# 简介
本文件夹中包含一些与内核小关的小脚本

## build_kernel.sh
编译内核并将一些生成的文件放入脚本所在文件夹

### 使用
```
./build_kernel.sh <kernel-version> <kernel-source-directory>
例如:
./build_kernel.sh 6.0.0 ~/kernel/linux
```
* kernel-version: 指定kernel的版本号, 作为目录识别名, 也可以指定为任意想要的名称
* kernel-source-directory: 指定要编译的kernel代码所在的目录

### 配置
在此脚本中, 使用了默认的配置`make defconfig`, 这在大多数情况下是无法正常运行的. 可以根据需要修改脚本, 在三种配置方式中选一种使用:
```
# 通过菜单配置
make menuconfig

# 使用当前正在使用的配置
# 注意, 这个配置文件并不一定存在, 只有在配置中将CONFIG_IKCONFIG和
# CONFIG_IKCONFIG_PROC设为y, 才会在/proc中出现config.gz
zcat /proc/config.gz > .config

# 使用默认的配置
make defconfig
```
