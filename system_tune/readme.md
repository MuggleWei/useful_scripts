# 系统调校

## 概述
此目录中包含了一些系统调较的脚本/操作说明

## 调校

### CPU频率
先通过 `show_cpu_freq.sh` 查看当前的频率与驱动, 这里要注意
* 由于我们后续想要通过 `cpupower frequency-set` 来指定一个频率, 需要将 `governors` 设置为 `userspace`
* 如果 `scaling_driver` 为 `intel_pstate`/`amd_pstate`, 那么一般情况下只支持 `performance` 和 `powersave`
* 遇到这种情况时, 有几种方法可以应对
  1. 临时关闭 `intel_pstate`/`amd_pstate`, 例如 `echo passive | sudo tee /sys/devices/system/cpu/intel_pstate/status`; 但有个问题 `intel_pstate/status` 不是每个内核版本都支持写 passive, 如果文件不存在或写入失败, 就无法生效
  2. 调用 `force_set_cpu_freq.sh`, 但 `intel_pstate`/`amd_pstate` 的硬件控制逻辑不一定严格服从
  3. 修改 GRUB 配置
    * 在 `GRUB_CMDLINE_LINUX_DEFAULT` 尾部增加 `intel_pstate=disable`/`amd_pstate=disable`
    * 运行 `sudo grub-mkconfig -o /boot/grub/grub.cfg`
    * 重启
    * 此时再次运行 `show_cpu_freq.sh`, 应该可以看到 `driver` 发生了改变
    * 现在运行 `sudo cpupower frequency-info` 里应该可以看到 `userspace` 了
    * 但这也有一个问题, 当使用 `acpi-cpufreq` 驱动时, 最大支持频率可能不被正确的查看到, `cpuinfo_max_freq` 可能是一个很小的值

所以关于固定 CPU 频率到一个指定的值, 分类讨论如下
1. 如果存在 `/sys/devices/system/cpu/intel_pstate/status` 文件, 尝试临时设置为 `passive`, 然后再次通过 `show_cpu_freq.sh` 查看 `scaling_available_gover` 是否支持 `userspace`, 若支持的话, 修改 `set_cpu_freq.sh` 中的频率, 运行
2. 若在 GRUB 中设置了 `intel_pstate=disable`/`amd_pstate=disable`, 使用 `show_cpu_freq.sh` 看到的 `cpuinfo_max_freq` 合适的话, 修改 `set_cpu_freq.sh` 中的频率, 运行
3. 若上面两种方法都不合适的情况下, 修改 `force_set_cpu_freq.sh`, 运行, 从而尝试强制指定一个频率范围

最后, 如果要取消上面设置的频率, 只需使用 `cpupower frequency-set -g` 切换到其他的 `governor` 即可恢复

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
