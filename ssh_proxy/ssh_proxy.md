## ssh反向代理

### 场景
* 机器A, A地点的机器, 无固定公网ip
* 机器B, B地点的机器, 无固定公网ip
* 机器C, 拥有固定公网ip的云主机

当前需要从机器A, 通过机器C, 来访问机器B

### 步骤
前期准备
* 修改机器C上的ssh配置, 开启GatewayPorts 为yes或指定用户

步骤
* 从B通过ssh将自己的端口反向代理到C上
```
ssh -NR <bind_host>:<bind_port>:<local_host>:<local_port> <username>@<remote_host>

-R: 指定将外网主机端口数据转发到本机
-N: 指定ssh不执行任何命令
<bind_host>:<bind_port>  反向代理绑定的地址, bind_host可省略, 默认使用localhost
<local_host>:<local_port>  本地的ssh地址
<username>@<remote_host>  远程机器的ssh登录

例子:
ssh -NR localhost:10102:localhost:22 mugglewei@xxx.xxx.xxx.xxx
```

* 从A机器ssh登录到C机器
```
ssh <username>@<remote_host>
```

* 在C机器上登录B机器
```
ssh -p <B绑定时指定的bind_port> <B机器的username>@<B绑定时指定的host>

例子:
ssh -p 10102 buser@localhost
```
