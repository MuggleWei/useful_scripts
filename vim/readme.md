## 编译vim
由于ubuntu18的默认vim版本, 会导致最新的YCM不支持, 所以需要手动编译
* git clone https://github.com/vim/vim.git
* 将configure_vim_compile.sh移动到 vim源码目录中
* 修改configure_vim_compile.sh中的python3路径
* 安装依赖项
```
sudo apt install build-essential libncurses5-dev libncursesw5-dev python3-dev curl

若不安装依赖项, 之后可能需要处理以下情况:
* 若提示curl命令不存在, 则运行一下 sudo apt install curl, 接着重新运行一下configure_vim_compile.sh
* 若提示没有找到make, 则运行一下 sudo apt install build-essential, 接着重新运行一下configure_vim_compile.sh
* 若提示需要安装ncurses, 则运行一下 sudo apt install libncurses5-dev libncursesw5-dev, 接着重新运行一下configure_vim_compile.sh
* 若提示Python.h: No such file or directory, 则运行一下 sudo apt install python3-dev, 接着重新运行一下configure_vim_compile.sh
```
* 运行configure_vim_compile.sh
* make
* sudo make install

## 配置vim
执行vim_config.sh, 自动配置, vundle和vim-plug二选一
* vundle: 老的配置
* vim-plug: 新的配置
