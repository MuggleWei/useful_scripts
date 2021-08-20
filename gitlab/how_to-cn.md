# 手动安装
* 进入 https://packages.gitlab.com/gitlab/gitlab-ce 下载合适的包
* 执行下载, 注意替换下方的具体包名
 ```
 pkg=gitlab-ce_14.1.3-ce.0_amd64.deb
 wget --content-disposition https://packages.gitlab.com/gitlab/gitlab-ce/packages/ubuntu/focal/${pkg}/download.deb
 ```
* 安装
 ```
 dpkg -i ${pkg}
 ```

# 配置
* 修改配置文件 /etc/gitlab/gitlab.rb
```
external_url 'http://gitlab.mugglewei.com'  //修改成你需要的域名
```

* 生成自签名证书并配置

* 重新加载配置
```
sudo gitlab-ctl reconfigure
```

常用命令
| 命令 | 说明 |
| ---- | ---- |
| sudo gitlab-ctl reconfigure | 重新加载配置，每次修改/etc/gitlab/gitlab.rb文件之后执行 |
| sudo gitlab-ctl status | 查看 GitLab 状态 |
| sudo gitlab-ctl start | 启动 GitLab |
| sudo gitlab-ctl stop | 停止 GitLab |
| sudo gitlab-ctl restart | 重启 GitLab |
| sudo gitlab-ctl tail | 查看日志 |

# 首次登录
* 更改root密码
重新加载配置后, 查看 /etc/gitlab/initial_root_password 获取root首次登录的默认密码  
登录之后点击右上角的头像, 选择 Perferences, 然后在User Settings -> Password中更改密码  
