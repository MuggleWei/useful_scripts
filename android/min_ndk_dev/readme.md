#  最小 NDK 开发调试

## 概述
本文章描述最小 ndk 开发调试的步骤

## 环境准备
这里分为 **最小安装** 和 **完整安装** 两种, 最小安装便是本文章所用到的, 完整安装是安装 Android 开发所需的工具

### 最小安装
最小安装: 只安装 NDK 编译/调试所需的工具  
* 下载 `Android NDK` 到, 并解压到目录 `/opt/android/android-ndk-${version}`
* 下载 `Android platform tools`, 并解压到目录 `/opt/android/platform-tools-${version}`
* 在 `~/.bashrc` 中增加
  ```
  export ANDROID_NDK_ROOT=/opt/android/android-ndk-${version}
  export ANDROID_PLT_TOOLS=/opt/android/platform-tools-${version}
  ```

### 完整安装
完整安装: 安装 Android 开发所需的工具
* 下载 `Android Command line tools`, 并解压到目录 `~/.local/opt/android/cmdline-tools/latest`
* 解压后, `/opt/android/cmdline-tools/latest` 目录中应该包含 `bin`, `lib` 等
* 在 `~/.bashrc` 中增加
  ```
  export ANDROID_SDK_ROOT=$HOME/.local/opt/android
  export ANDROID_HOME=$HOME/.local/opt/android
  ```
* 安装组件(需要确认组件当前最新的 stable 版本)
  ```
  $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager --install  "platform-tools" "build-tools;36.0.0" "platforms;android-36" "ndk;29.0.14206865"
  ```
* 在 `~/.bashrc` 中增加
  ```
  export ANDROID_NDK_ROOT=$ANDROID_SDK_ROOT/ndk/${version}
  export ANDROID_PLT_TOOLS=$ANDROID_SDK_ROOT/platform-tools
  ```

## 测试程序
这里使用一个简单打印 `hello world` 的测试程序来验证编译, 调试环节

### 编译
进入 `hello` 目录, 运行 `build_android.sh` 生成 `dist` 目录

### 连接手机
- 连接手机
- 开启 USB 调试并允许 ADB 调试
- 确认设备连接
  ```
  $ANDROID_PLT_TOOLS/adb devices
  ```

### 调试
- 发送程序至手机
  ```
  $ANDROID_PLT_TOOLS/adb push dist/bin/hello /data/local/tmp/
  ```
- 找到 `lldb-server`
  ```
  cd $ANDROID_NDK_ROOT
  find . -name "lldb-server"
  ```
- 选择合适的 `lldb-server` 发送至手机
  ```
  $ANDROID_PLT_TOOLS/adb push ./toolchains/llvm/prebuilt/linux-x86_64/lib/clang/21/lib/linux/aarch64/lldb-server /data/local/tmp/
  ```
- 进入手机, 开启 `lldb-server`
  ```
  $ANDROID_PLT_TOOLS/adb shell
  cd /data/local/tmp  # 这里注意, 在 /data 目录中 ls 会没有权限, 直接进入完整路径即可
  ./lldb-server platform --listen '*:5039' --server
  ```
- 新开窗口, 在主机上连接 `lldb-server`
  ```
  $ANDROID_PLT_TOOLS/adb forward tcp:5039 tcp:5039
  ```
- 找到 `lldb`
  ```
  cd $ANDROID_NDK_ROOT
  find . -name "lldb"
  ```
- 选择合适的 `lldb`, 在主机上启动调试
  ```
  $ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/linux-x86_64/bin/lldb.sh

  platform select remote-android
  platform connect connect://localhost:5039
  target create /data/local/tmp/hello
  breakpoint set --name main
  process launch
  ```
- 调试完成后, 退出手机上的 `lldb-server`, 接着清理本地的连接
  ```
  $ANDROID_PLT_TOOLS/adb forward --list
  $ANDROID_PLT_TOOLS/adb forward --remove-all
  ```
