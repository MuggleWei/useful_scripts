# 使用自签名证书
本目录解释和使用了私钥以及自签名证书

## 概念
基础概念可参考[ssl证书, 私钥以及CSR](./ssl_certificates.md)

## 使用
| 文件 | 说明 |
| ---- | ---- |
| [gen.sh](./gen.sh) | 一个生成私钥和自签名证书 |
| [server.go](./server/server.go) | 一个使用私钥和自签名证书的web服务 |
| [client.py](./client/client.py) | 一个rest客户端, 用于展示如何使用自签名证书 |
| [tcpdump.sh](./tcpdump.sh) | 用于抓包, 通过切换hello.go中被注释掉的代码, 来确认数据确实被加密了 |

## 游览器添加信任证书
以win10下的chrome为例子, chrome接受windows本地信任证书, win键 -> 输入cert -> 管理计算机证书 -> 受信任人 -> 所有任务 -> 导入. 之后使用chrome访问, 便不会跳出警告
