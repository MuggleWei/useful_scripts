""" 下载必备代码库 """
import os
import subprocess


def run_subprocess(args):
    """
    运行子进程并实时输出
    :param args: 执行的命令
    """
    with subprocess.Popen(args, stdout=subprocess.PIPE) as p:
        try:
            for line in p.stdout:
                if not line:
                    break
                print("{}".format(line.decode("utf-8")))
        except Exception as e:
            print("{} failed: {}".format(args, e))


if __name__ == "__main__":
    # 需要备份的代码库
    source_list = [
        # 自己的代码库
        "https://github.com/MuggleWei/mugglec.git",
        "https://github.com/MuggleWei/Hakuna_Matata.git",
        "https://github.com/MuggleWei/useful_scripts.git",
        "https://github.com/MuggleWei/mugglewei.github.io.git",
        "https://github.com/MuggleWei/learning_compass.git",
        "https://github.com/MuggleWei/babeltrader.git",
        "https://github.com/MuggleWei/mugglecpp.git",
        "https://github.com/MuggleWei/latency-benchmark.git",
        "https://github.com/MuggleWei/callback_benchmark.git",
        "https://github.com/MuggleWei/srclient.git",
        "https://github.com/MuggleWei/webtoy.git",
        "https://github.com/MuggleWei/goev.git",
        "https://github.com/MuggleWei/hpb.git",
        "https://github.com/MuggleWei/hpkg.git",

        # 代码
        "https://github.com/python/cpython.git",
        "https://github.com/vim/vim.git",
        "https://github.com/neovim/neovim.git",
        "https://github.com/Kitware/CMake.git",
        "https://github.com/wolfSSL/wolfssl.git",
        "https://github.com/openssl/openssl.git",
        "https://github.com/Mbed-TLS/mbedtls.git",
        "https://github.com/gpg/gnupg.git",
        "https://github.com/gpg/libgcrypt.git",
        "https://github.com/gpg/libgpg-error.git",
        "https://github.com/madler/zlib.git",
        "https://github.com/facebook/zstd.git",
        "https://github.com/mcmilk/7-Zip-zstd.git",
        "https://github.com/the-tcpdump-group/libpcap.git",
        "https://github.com/libevent/libevent.git",
        "https://github.com/sqlite/sqlite.git",
        "https://github.com/google/googletest.git",
        "https://github.com/gperftools/gperftools.git"
        "https://github.com/protocolbuffers/protobuf.git",
        "https://github.com/gflags/gflags.git",
        "https://github.com/danmar/cppcheck.git",
        "https://github.com/leethomason/tinyxml2.git",
        "https://github.com/Tencent/rapidjson.git",
        "https://github.com/bkaradzic/bgfx.git",
        "https://github.com/ocornut/imgui.git",
        "https://github.com/ArthurSonzogni/FTXUI.git",
        "https://github.com/tcltk/tcl.git",  # 编译某些项目时需要此库
        "https://github.com/openai/gpt-2.git",

        # 学习/博客/例子
        # "https://github.com/jiji262/wooyun_articles.git", # 2.5G 太占硬盘了 :(
        "https://github.com/wolfSSL/wolfssl-examples.git",

        # 日常生活
        "https://github.com/shadowsocks/shadowsocks-libev.git",
        "https://github.com/adityatelange/hugo-PaperMod.git",
        "https://github.com/KaTeX/KaTeX.git",
        "https://github.com/mdaines/viz.js.git",
    ]

    # 当前工作目录下的目录
    cur_dirs = os.listdir(".")

    # 遍历清单, 获取状态
    cur_dir = os.getcwd()
    for src in source_list:
        name = src.split("/")[-1][:-4]
        if name in cur_dirs:
            print("----------------------------------------------")
            print("{}: already exists, git pull".format(name))
            # 进入文件夹
            os.chdir(name)

            # 运行git pull
            args = ["git", "pull"]
            run_subprocess(args=args)

            # 返回原目录
            os.chdir(cur_dir)
        else:
            print("----------------------------------------------")
            print("{}: clone".format(name))

            # 运行git pull
            args = ["git", "clone", src]
            run_subprocess(args=args)
