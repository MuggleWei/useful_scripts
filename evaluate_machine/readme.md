# 服务器评估 

## 概述
本工程提供统一的服务器评估方法, 包括对 CPU 性能, CPU 核间通讯性能, 服务器烤机的监测

注意:
- 由于不同版本的 `stress-ng` 计算 `bogo ops/s` 可能是有差别的, 所以我们必须使用相同版本的工具来进行测试

## 测试流程
- 下载工具: `./scripts/download_tools.sh`
- 确保 `stess-ng` 的依赖库都已经安装, 详见: [Building stress-ng](https://github.com/ColinIanKing/stress-ng/blob/master/README.md#building-stress-ng)
- 编译工具: `./scripts/build_tools.sh`
- 准备监控工具: `./scripts/build_monitor.sh`
- 按自己的需求, 对系统参数进行调整 (例如固定 CPU 频率, 保留大页内存等)
- 运行核间通讯测试: `./scripts/run_c2c_bench_store_load.sh`
- 运行带竞争的核间通讯测试: `./scripts/run_c2c_bench_chan.sh`
- 启动监控: `./scripts/run_monitor.sh`
- 运行 CPU 计算性能测试: `./scripts/run_test_cpu.sh`
- 运行 CPU 缓存测试: `./scripts/run_test_cache.sh`
- 运行内存测试: `./scripts/run_test_vm.sh`
- 运行 IO 测试: `./scripts/run_test_io.sh`
- 运行烤机测试:
  - 综合的压测, 模拟真实极限压力: `./scripts/run_burn_in_1.sh`
  - 单独压测 CPU, 考察发热量: `./scripts/run_burn_in_2.sh`
