# 系统调校

## 概述
此目录中包含了一些系统调较的脚本/操作说明

## 调校

### CPU频率
脚本: `set_cpu_freq.sh`  
作用: 将 CPU 固定在一个指定的频率上运行  
注意事项: 在运行之前, 先调整脚本中设定的频率, 让其在允许的区间之内

### 关闭图形界面
脚本: `stop_display_mgr.sh`
作用: 关闭使用 systemd 的显示管理器

### 隔离核
操作:
- 打开 `/etc/default/grub`
- 在 `GRUB_CMDLINE_LINUX_DEFAULT` 尾部增加要隔离的核, 例如 `isolcpus=3,4,5`
- 更新 grub: `sudo update-grub`
- 若上面命令出现了 `command not found` 的报错, 也可以使用命令
  ```
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  ```
- 重启
- 验证隔离是否成功: `cat /proc/cmdline | tr ' ' '\n' | grep -E 'isolcpus'`
- 运行的时候指定核: `taskset -c 3,4,5 ./xxx`

### 关闭隔离核上的中断
# TODO:

### 禁用隔离核的 RCU 回调
# TODO:

### 大页设置
详见: `Hakuna_Matata` 当中的设置
