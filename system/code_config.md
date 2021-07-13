## 初始配置基础编程工具
* sudo apt install cmake build-essential
* 下载java, maven, golang
* 安装golang
```
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzvf go${version}.linux-amd64.tar.gz
```
* 安装java和maven
```
sudo tar -xzvf jdk-${version}_linux-x64_bin.tar.gz -C /opt/
sudo unzip apache-maven-${version}-bin.zip -d /opt/
```
* 配置PATH, 在/etc/profile中增加
```
export JAVA_HOME=/opt/jdk-${version}
export MAVEN_HOME=/opt/apache-maven-${version}
export PATH=/usr/local/go/bin:$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH
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
* 安装vim以及插件
```
参考vim目录
```
