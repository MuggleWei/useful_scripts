## git ssh 使用代理
有的时候, git clone 走 ssh 类型会失败, 此时需要在 `~/.ssh/config` 中, 配置 ssh 也走代理, 例如  
```
Host github.com
	User git
	HostName github.com
	IdentityFile ~/.ssh/github_priv_key
	ProxyCommand nc -x 127.0.0.1:1080 %h %p
```

当在 Windows 下时, 由于不存在 `nc` 命令, 可以使用以下命令代替
```
ProxyCommand connect -S 127.0.0.1:1080 %h %p
```
