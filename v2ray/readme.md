## 构建及配置

本文件内容完全摘自v2ray自官网

## 构建

### 手动构建
manual_compile.sh

### 脚本构建
wget https://raw.githubusercontent.com/v2fly/v2ray-core/master/release/user-package.sh
chmod u+x user-package.sh
./user-package.sh

## 配置
以手动构建为例, 将生成到文件夹放在 服务器/客户端中

* 在服务器端, 将 server_config.json 改为 config.json, 放入文件夹中并修改配置文件中的参数, 并运行 nohup ./v2ray &
* 在客户端, 将 client_config.json 改为 config.json, 放入文件夹中并修改配置文件中的参数, 并运行 nohup ./v2ray &

## 注意事项
v2ray配置文件中的 inbounds表示下游到v2ray中的数据, outbounds表示从v2ray到上游的数据, 如果之用一次代理, 可简单看成
```
客户端data ---> | in | 客户端v2ray | out | ---> | in | 服务器v2ray | out | ---> 真实目标地址
```
所以要注意, 服务器端到inbounds要与客户端到outbounds对应起来
