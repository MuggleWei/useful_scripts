:: for windows use go get
@echo off

set http_proxy=socks5://127.0.0.1:1080
set https_proxy=socks5://127.0.0.1:1080

go get -u -v %*

echo ...

pause