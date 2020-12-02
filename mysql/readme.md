## 从zip文件解压并配置 (windows)
* 下载zip包
* 解压到一个目录中, 比如说 D:/MySQL/mysql-8.0.22-winx64, 并进入目录
* 将本目录中的my.ini拷贝到刚刚解压的目录中, 并更改my.ini中相对于的目录
* 初始化
```
bin\mysqld --defaults-file=my.ini --initialize --console
输出的最后一行, 会给出默认创建的root用户和密码

随后第一次root登录, 记得更改密码
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root-password';
```
* 运行服务
```
bin\mysqld --defaults-file=my.ini --console
```