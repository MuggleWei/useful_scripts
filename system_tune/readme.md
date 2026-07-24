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

设置成功之后, 可以通过 `cat /proc/cpuinfo | grep -E "Hz"` 来查看 CPU 频率, 或者运行 `monitor_cpu_freq.sh` 来持续监控 CPU 的频率

最后, 如果要取消上面设置的频率, 只需使用 `cpupower frequency-set -g` 切换到其他的 `governor` 即可恢复

### 关闭图形界面
临时操作: `sudo systemctl stop display-manager` 或 `sudo systemctl isolate multi-user.target`  
需要注意的是, 临时操作可能有残留的情况, 比较好的做法是, 直接设置启动时不使用图形界面: `sudo systemctl set-default multi-user.target`, 之后重启  
如果之后需要图形界面了, 在设置 `sudo systemctl set-default graphical.target` 之后重启

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
- 额外需要注意的事
  - 当隔离的核直接需要进行通讯的时候, 需要关注一下 CPU 本身的架构
  - 例如 AMD/海光 等 CPU，有 CCX 的概念, 即使同一个 NUMA 节点下, 不同 CCX 的核通讯延时也有很大的差距
  - 可以通过 `cat /sys/devices/system/cpu/cpu*/cache/index3/shared_cpu_list` 来观察不同的核之间 L3 cache 的共享情况

### 减少隔离核上的中断
比如要让核 3,4,5 尽量的少受到中断的影响, 可以如下设置
- 设置启动关闭 `irqbalance`: `sudo systemctl disable irqbalance`
- 配置硬中断的亲和性, 在 `GRUB_CMDLINE_LINUX_DEFAULT` 尾部增加要硬中断亲和的核, 例如 `irqaffinity=0,1`
- 运行 `sudo grub-mkconfig -o /boot/grub/grub.cfg`
- 重启之后看看是否生效
  ```
  # 硬中断分布
  cat /proc/interrupts

  # 软中断分布(注意, irqaffinity 并不直接影响软中断, 而是硬中断间接影响)
  cat /proc/softirqs
  ```
- 有一个额外注意的点是, 如果是网络程序且没有使用 kernel bypass, 这时候如果隔离的核被用来处理网络消息, 此时把网络相关的硬中断隔离出去不是一个好的选择

### 减少时钟中断
比如要让核 3,4,5 尽量的少受到时钟中断的影响, 可以如下设置
- 配置硬中断的亲和性, 在 `GRUB_CMDLINE_LINUX_DEFAULT` 尾部增加要硬中断亲和的核, 例如 `nohz_full=3,4,5`
- 运行 `sudo grub-mkconfig -o /boot/grub/grub.cfg`

### 禁用隔离核的 RCU 回调
比如要让核 3,4,5 尽量的少受到 RCU 回调的影响, 可以如下设置
- 配置硬中断的亲和性, 在 `GRUB_CMDLINE_LINUX_DEFAULT` 尾部增加要硬中断亲和的核, 例如 `rcu_nocbs=3,4,5`
- 运行 `sudo grub-mkconfig -o /boot/grub/grub.cfg`

### 其他
还有诸如关闭 iommu、nmi_watchdog 等, 就不一一介绍了

## 调校操作总结
- 开机启动, 在 BIOS 中
  - 关闭超线程 (Intel 的 Hyper-Threading 或 AMD 的 SMT)
  - 关闭虚拟化: VT-d/VT-x, IOMMU
- 设置 grub, 在 `GRUB_CMDLINE_LINUX_DEFAULT` 中增加
  ```
  isolcpus=3,4,5 \
  nohz_full=3,4,5 \
  rcu_nocbs=3,4,5 \
  irqaffinity=0,1 \
  iommu=off \
  intel_iommu=off \
  nmi_watchdog=0
  ```
- 若需要的话, 设置大页, 在 `GRUB_CMDLINE_LINUX_DEFAULT` 中增加
  ```
  transparent_hugepage=never \
  hugepagesz=1G hugepages=2 \
  ```
- 更新 GRUB 配置并重启
  ```
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  ```
- systemctl 关闭服务或设置模式
  ```
  sudo systemctl disable irqbalance
  sudo systemctl set-default multi-user.target
  ```
- 重新启动
  ```
  sudo reboot
  ```
- 固定 CPU 频率
  ```
  echo passive | sudo tee /sys/devices/system/cpu/intel_pstate/status
  sudo cpupower frequency-set -g userspace
  sudo cpupower -c 3,4,5 frequency-set -f 4.2GHz
  ```
- 使用结束后恢复
  - 在 BIOS 中重新开启超线程和虚拟化
  - 删除 grub 中增加的内容
  - 使用 `grub-mkconfig` 更新 GRUB 配置
  - 开启服务
    ```
    sudo systemctl enable irqbalance
    sudo systemctl set-default graphical.target
    ```
  - 重启
