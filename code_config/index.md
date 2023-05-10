## 初始配置基础编程工具
* 设置源
```
搜索 阿里/腾讯/清华 对应的镜像源
```
* 安装 Basic tool
```
# archlinux
sudo pacman -S base-devel

# ubuntu
sudo apt install cmake build-essential
```
* 下载java, maven, golang, node
* 安装golang
```
sudo rm -rf /opt/go && sudo tar -C /opt -xzvf go${version}.linux-amd64.tar.gz
```
* 安装java和maven
```
sudo tar -xzvf jdk-${version}_linux-x64_bin.tar.gz -C /opt/
sudo unzip apache-maven-${version}-bin.zip -d /opt/
```
* 安装node
```
sudo tar -xvf node-${version}-linux-x64.tar.xz -C /opt/
```
* 安装rust
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
* 配置PATH
在 /etc/profile 中增加
```
export GOLANG_HOME=/opt/go
export JAVA_HOME=/opt/jdk-${version}
export MAVEN_HOME=/opt/apache-maven-${version}
export NODE_HOME=/opt/node-${version}-linux-x64
export PATH=$GOLANG_HOME/bin:$JAVA_HOME/bin:$MAVEN_HOME/bin:$NODE_HOME/bin:$PATH
```
* 将用户目录的bin在~/.bashrc中加入path中(python3默认的脚本安装路径是这个, 安装python的langserver会用到)
```
export PATH=$PATH:$HOME/.local/bin
```
* (python配置)安装python3常用组件以及设置源
```
sudo apt-get install -y python3-pip python3-venv
python3 -m pip install pip -U
python3 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```
* (go配置)配置用户go可执行文件, 在~/.bashrc中增加
```
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
```
* (go配置)配置go proxy, 在~/.bashrc中增加
```
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct
go env -w GOPRIVATE=*.${私有库地址}  # 排除私有库
```
* (rust配置)在 ~/.bashrc 中增加
```
source "$HOME/.cargo/env"
```
注意，如果在 ~/.bashrc 中有 `exec fish` 之类的调用其他 `shell` 的情况, 需要确保 `source` 语句在其之前  
* (rust配置)配置rust的cargo代理, 创建 ~/.cargo/config 并写入
```
[http]
proxy = "127.0.0.1:1080"

[https]
proxy = "127.0.0.1:1080"

```
* 安装vim和nvim以及插件
```
参考vim和nvim目录
```
* (可选)配置fish shell
```
sudo pacman -S fish

# 在 ~/.bashrc 的末尾加入
exec fish

# 退出重新进入之后查看可选的主题
fish_config theme list

# 选择一个主题, 例如 "ayu Dark"
fish_config theme choose "ayu Dark"
```
