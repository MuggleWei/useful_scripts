### 登录通知
在~/.bashrc或者/etc/profile中, 加入
source login_notify.sh
当有人登录服务器时, 便会执行login_notify中的通知操作, 通知操作需要实现, 当前只是简单的写入文件中
