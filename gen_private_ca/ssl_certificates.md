- [ssl证书, 私钥以及CSR](#ssl证书-私钥以及csr)
  - [证书签名请求(CSR)](#证书签名请求csr)
  - [生成CSR](#生成csr)
    - [生成私钥和CSR](#生成私钥和csr)
    - [从已有的私钥中生成CSR](#从已有的私钥中生成csr)
    - [从现有的证书和私钥生成CSR](#从现有的证书和私钥生成csr)
  - [生成SSL证书](#生成ssl证书)
    - [生成自签名证书](#生成自签名证书)
    - [从已有的私钥中生成自签名证书](#从已有的私钥中生成自签名证书)
  - [查看证书](#查看证书)
    - [查看CSR条目](#查看csr条目)
    - [查看证书条目](#查看证书条目)
    - [验证证书由CA签署](#验证证书由ca签署)
  - [私钥](#私钥)
    - [创建私钥](#创建私钥)
    - [验证私钥](#验证私钥)
    - [验证私钥是否与证书和CSR匹配](#验证私钥是否与证书和csr匹配)
    - [加密私钥](#加密私钥)
    - [解密私钥](#解密私钥)
  - [转换证书格式](#转换证书格式)
    - [将PEM转换为DER](#将pem转换为der)
    - [将DER转换为PEM](#将der转换为pem)
    - [将PEM转换为PKCS7](#将pem转换为pkcs7)
    - [将PKCS7转换为PEM](#将pkcs7转换为pem)
  - [参考](#参考)

# ssl证书, 私钥以及CSR
本文件摘自 参考文章[<sup>1</sup>](#ref1)   

## 证书签名请求(CSR)
想从 <b>证书颁发机构</b>(CA)(certificate authority)获得SSL证书, 必须生成一个 <b>证书签名请求</b>(CSR)(certificate signing request), 一个CSR主要是由公钥和一些附加信息组成  

当生成一个CSR时, 会被提示提供有关证书的信息, 这些信息被称为 <b>专有名</b>(DN)(Distinguised Name), DN 中的一个重要域是 <b>通用名</b>(CN)(Common Name), 它应该是你打算使用证书的主机的 <b>完全限定域名</b>(FQDN)(Fully Qualified Domain Name), 当创建 CSR 时, 也可以通过命令行或文件传递信息来跳过交互式提示输入.  

下面是一个 CSR 信息提示的例子:  
```
---
Country Name (2 letter code) [AU]:US
State or Province Name (full name) [Some-State]:New York
Locality Name (eg, city) []:Brooklyn
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Example Brooklyn Company
Organizational Unit Name (eg, section) []:Technology Division
Common Name (e.g. server FQDN or YOUR name) []:examplebrooklyn.com
Email Address []:
```

如果你想非交互式的输入这些信息, 可以通过 OpenSSL -subj 选项实现, 下面是一个例子
```
-subj "/C=US/ST=New York/L=Brooklyn/O=Example Brooklyn Company/CN=examplebrooklyn.com"
```

## 生成CSR
本节讲介绍OpenSSL中有关生成CSR的命令

### 生成私钥和CSR
如果你想使用 HTTPS, 并且想要向CA申请一个SSL证书, 那么你需要生成CSR并发送给 CA, 请求由CA签名的SSL证书. 如果你的CA支持SHA-2, 请添加 -sha256 选项, 用SHA-2签署CSR  

下面的命令会创建一个2048位的私钥(domain.key)和一个CSR(domain.csr)
```
openssl req \
    -newkey rsa:2048 -nodes -keyout domain.key \
    -out domain.csr
```
其中:
* 若不想交互式回答, 可加入-subj选项 或 使用openssl.cnf
* -newkey rsa:2048 指定密钥为2048位, 使用RSA算法
* -nodes 指定私钥没有用密码加密
* -new 被隐式包含, 表示一个CSR将被生成

### 从已有的私钥中生成CSR
如果你已经有了一个私钥, 需要用此私钥生成一个CSR, 可使用
```
openssl req \
    -key domain.key \
    -new -out domain.csr
```
该命令基于现有的私钥(domain.key)创建一个新的 CSR(domain.csr), 其中
* -key 指定一个现有的私钥
* -new 表示一个CSR将被生成

### 从现有的证书和私钥生成CSR
如果你想更新现有的证书, 但由于某些原因, 你或你的 CA 没有原始的 CSR, 可使用这个方法
```
openssl x509 \
    -in domain.crt \
    -signkey domain.key \
    -x509toreq -out domain.csr
```
该命令基于现有的证书(domain.crt)和私钥(domain.key)创建一个新的CSR(domain.csr), 其中
* -x509toreq 指定你使用一个X509证书来制作CSR

## 生成SSL证书
如果你想使用SSL证书, 但你不需要CA签名的证书, 一个可行的(和免费的)解决方案是签署你自己的证书  
你可以自己签发的一种常见证书是 <b>自签名证书</b>(self-signed certificate), 自签证书是用自己的私钥签署的证书. 自签证书和CA签名证书一样可以用来加密数据, 但是你的用户会显示一个警告, 说这个证书不被他们的计算机或浏览器信任. 因此, 只有当你不需要向用户证明你的服务身份时, 才可以使用自签名证书(例如非生产或非公开服务器)  

### 生成自签名证书
下面命令可以从头开始创建一个 2048 位的私钥(domain.key)和一个自签名证书(domain.crt)
```
openssl req \
    -newkey rsa:2048 -nodes -keyout domain.key \
    -x509 -days 365 -out domain.crt
```
其中
* -x509 告诉req子命令创建一个自签名的证书
* -days 365 指定证书的有效期为365天

一个临时的CSR会被生成, 以收集与证书相关的信息

### 从已有的私钥中生成自签名证书
如果你已经有了一个私钥, 并想用它来生成自签名证书, 可以
```
openssl req \
    -key domain.key \
    -new \
    -x509 -days 365 -out domain.crt
```

## 查看证书
证书和CSR文件是以PEM格式编码的, 并不适合被人类读  
本节介绍的OpenSSL命令将输出PEM编码文件的实际条目  

### 查看CSR条目
```
openssl req -text -noout -verify -in domain.csr
```

### 查看证书条目
```
openssl x509 -text -noout -in domain.crt
```

### 验证证书由CA签署
使用此命令验证证书(domain.crt)是否由特定的CA证书(ca.crt)签署
```
openssl verify \
    -verbose -CAFile ca.crt \
    domain.crt
```

## 私钥

### 创建私钥
使用该命令创建一个受密码保护的 2048 位私钥(domain.key)
```
openssl genrsa -des3 -out domain.key 2048
```

### 验证私钥
使用此命令检查私钥(domain.key)是否为有效密钥
```
openssl rsa -check -in domain.key
```

### 验证私钥是否与证书和CSR匹配
```
openssl rsa  -noout -modulus -in domain.key | openssl md5
openssl x509 -noout -modulus -in domain.crt | openssl md5
openssl req  -noout -modulus -in domain.csr | openssl md5
```
如果每条命令的输出都是相同的, 那么私钥、证书和 CSR 就极有可能是相关的

### 加密私钥
这需要一个未加密的私钥(unencrypted.key), 并输出它的加密版本(encrypted.key)
```
openssl rsa -des3 \
    -in unencrypted.key \
    -out encrypted.key
```
输入你所需的密码, 以加密私钥

### 解密私钥
```
openssl rsa \
    -in encrypted.key \
    -out decrypted.key
```
在提示时, 输入加密密钥的密码

## 转换证书格式
OpenSSL可以用来将证书在各种格式间转换

### 将PEM转换为DER
```
openssl x509 \
    -in domain.crt \
    -outform der -out domain.der
```

### 将DER转换为PEM
```
openssl x509 \
    -inform der -in domain.der \
    -out domain.crt
```

### 将PEM转换为PKCS7
```
openssl crl2pkcs7 -nocrl \
    -certfile domain.crt \
    -certfile ca-chain.crt \
    -out domain.p7b
```

### 将PKCS7转换为PEM
```
openssl pkcs7 \
    -in domain.p7b \
    -print_certs -out domain.crt
```

## 参考
- <a id="ref1">[1]</a> [openssl essentials working with ssl certificates private keys and csrs](https://www.digitalocean.com/community/tutorials/openssl-essentials-working-with-ssl-certificates-private-keys-and-csrs)
