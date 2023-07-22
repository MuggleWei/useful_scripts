# 迁移

本文档说明如何迁移 gitolite 服务器, 具体可参考官方文档: [moving servers](https://gitolite.com/gitolite/install#moving-servers)  
这里假设使用 git 为管理员用户, 并且有名为 `foo` 和 `bar` 的两位用户

* 在迁移之前，先从旧服务器上保存以下的文件
	* 管理员的公钥私钥和用户的公钥私钥
	* 最新版本的 `gitolite-admin`: 执行 `git clone` 以获取
	* 除了 `gitolite-admin` 和 `testing` 之外的所有库: 从 `repositories` 当中直接拷贝出来
	* `.gitolite.rc`: 从根目录中获取

此时, 我们准备的迁移文件夹大致如下
```
gitolite_migrate
├── keys
│   ├── git
│   ├── git.pub
│   ├── foo
│   ├── foo.pub
│   ├── bar
│   └── bar.pub
├── gitolite-admin
├── .gitolite.rc
└── repositories
    ├── mugglewei-foo.git
    ├── mugglewei-bar.git
    │
	....
    │
    └── mugglewei-baz.git
```

* 将上述文件夹打包为 `gitolite_migrate.zip`, 并传至新的机器上
* 将 `moving.sh` 放入 `gitolite_migrate.zip` 的同级目录, 并以管理员身份运行此脚本: `sudo ./moving.sh git`; 注意, 此步骤中需要下载 gitolite 源码, 若在无法访问 github 的网络条件下会失败, 可开启并改动 `moving.sh` 中设置 git proxy 的那行
* 将上一步释放出来的 `keys` 文件夹(此时在 `/home/git/gitolite_migrate/` 当中)中的密钥放至适合的位置, 并配置 ssh, 例如
 ```
 Host local.gitolite.admin.com
 	HostName 127.0.0.1
 	Port 22
 	IdentityFile ~/.ssh/git
 	IdentitiesOnly yes

 Host local.gitolite.com
 	HostName 127.0.0.1
 	Port 22
 	IdentityFile ~/.ssh/foo
 	IdentitiesOnly yes
 ```
* 将上一步释放出来的 `gitolite-admin` 放至合适的位置, 进入目录并更改远程库地址: `git remote set-url origin <new-url>`, 并强制推送: `git push -f`; 注意, 这里要现在 sshd_config 中, 将 git 添加为 AllowUsers
* 执行 `setup`: `sudo -H -u git env PATH=$PATH:/home/$user_name/bin gitolite setup`
