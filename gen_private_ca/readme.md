# 使用自签名证书
本目录解释和使用了私钥以及自签名证书

## 概念
基础概念可参考[ssl证书, 私钥以及CSR](./ssl_certificates.md)

## 使用
| 文件 | 说明 |
| ---- | ---- |
| [gen.sh](./gen.sh) | 一个生成私钥和自签名证书 |
| [hello.go](./server.go) | 一个使用私钥和自签名证书的web服务 |
| [client.py](./client.py) | 一个rest客户端, 用于展示如何使用自签名证书 |
| [tcpdump.sh](./tcpdump.sh) | 用于抓包, 通过切换hello.go中被注释掉的代码, 来确认数据确实被加密了 |
