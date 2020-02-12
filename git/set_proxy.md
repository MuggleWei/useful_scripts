假设本地的代理端口为1080  

git使用代理:
```
git config --global http.proxy 'socks5://127.0.0.1:1080'
git config --global https.proxy 'socks5://127.0.0.1:1080'
注意: 其中的global可以替换为local
```

git取消代理
```
git config --global --unset http.proxy
git config --global --unset https.proxy
```

git针对特定网站(比如github)设置代理
```
git config --global http.https://github.com.proxy socks5://127.0.0.1:1080
```