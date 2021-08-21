package main

import (
	"fmt"
	"net/http"
)

func main() {
	// 创建一个多路复用器
	mux := http.NewServeMux()

	// 静态文件处理器
	files := http.FileServer(http.Dir("public"))
	mux.Handle("/static/", http.StripPrefix("/static/", files))

	// 回调函数
	mux.HandleFunc("/", index)

	server := &http.Server{
		Addr:    "0.0.0.0:10102",
		Handler: mux,
	}
	// server.ListenAndServe()
	server.ListenAndServeTLS("server.crt", "server.key")
}

func index(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "hello, %s", r.URL.Path[1:])
}
