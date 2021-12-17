## 初始配置基础编程工具
* sudo apt install cmake build-essential
* 下载java, maven, golang, node
* 安装golang
```
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzvf go${version}.linux-amd64.tar.gz
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
* 配置PATH, 在/etc/profile中增加
```
export JAVA_HOME=/opt/jdk-${version}
export MAVEN_HOME=/opt/apache-maven-${version}
export NODE_HOME=/opt/node-${version}-linux-x64
export PATH=/usr/local/go/bin:$JAVA_HOME/bin:$MAVEN_HOME/bin:$NODE_HOME/bin:$PATH
```
* 将用户目录的bin在~/.bashrc中加入path中(python3默认的脚本安装路径是这个, 安装python的langserver会用到)
```
export PATH=$PATH:$HOME/.local/bin
```
* (可选)配置用户go可执行文件, 在~/.bashrc中增加
```
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
```
* (可选)配置go proxy, 在~/.bashrc中增加
```
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct
go env -w GOPRIVATE=*.${私有库地址}  # 排除私有库
```
* 设置软件源
```
搜索 阿里/腾讯/清华 对应的镜像源
```
* 安装python3常用组件以及设置源
```
sudo apt-get install -y python3-pip python3-venv
python3 -m pip install pip -U
python3 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```
* 安装vim和nvim以及插件
```
参考vim和nvim目录
```
