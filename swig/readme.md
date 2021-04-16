## swig使用
这里以自动绑定python为例子
* 安装swig
* 准备好要封装的动态库和头文件(本例子中是cc_module中的foo)
```
本例中执行 build_foo.sh
```
* 通过swig生成封装使用的c++和py文件, 并编译, 重命名
```
在本例中执行 gen_pyfoo.sh
```
* 测试自动封装的结果
```
在本例中执行 python example_pyfoo.py
```
