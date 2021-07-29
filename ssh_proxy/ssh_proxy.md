## ssh反向代理

### 场景
* 机器A, A地点的机器, 无固定公网ip
* 机器B, B地点的机器, 无固定公网ip
* 机器C, 拥有固定公网ip的云主机

当前需要从机器A, 通过机器C, 来访问机器B

### 步骤
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

# 常见问题
* 直接从外网ip访问B
```
上面步骤是通过先登录C机器, 再访问B机器的
若想直接通过外网ip访问, 可以更改C机器上ssh配置中的GatewayPorts 为yes或用户指定信息, 从而实现直接访问
```
* 断线问题
```
直接使用ssh命令会出现断线问题, 推荐直接使用脚本调用ssh来断线重连
```
