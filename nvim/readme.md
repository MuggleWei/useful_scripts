# 编译neovim
运行`build_nvim.sh`, 将会在脚本所在目录中下载neovim及其依赖, 并且编译

# 配置neovim
运行`config_nvim.sh`配置neovim, 有几点需要注意的
* 如果在`build_nvim.sh`使用前设置了proxy, 需要全部取消
* 如果需要curl使用proxy, 需要指定, 例如`./config_nvim.sh 127.0.0.1:1080`
