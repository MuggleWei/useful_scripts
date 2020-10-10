## 配置vim
执行vim_config.sh, 自动配置

## 编译vim
由于ubuntu18的默认vim版本, 会导致最新的YCM不支持, 所以需要手动编译
* git clone https://github.com/vim/vim.git
* 将configure_vim_compile.sh移动到 vim源码目录中
* 修改configure_vim_compile.sh中的python3路径
* 运行configure_vim_compile.sh
* 若提示需要安装ncurses, 则运行一下 sudo apt install libncurses5-dev libncursesw5-dev, 接着重新运行一下configure_vim_compile.sh
* make
* sudo make install
