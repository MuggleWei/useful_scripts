gen.sh是一个生成私有证书，用于https访问的一个小脚本。hello.go用于说明如何使用生成的私钥和私有证书。tcpdump.sh用于抓包，通过这个，切换hello.go中被注释掉的http访问代码，可以确认，数据确实被加密了。
