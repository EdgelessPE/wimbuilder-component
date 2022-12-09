# Edgeless Wimbuilder2 Component
此仓库为 Edgeless 4.x 版本使用的 [Wimbuilder2](https://github.com/slorelee/wimbuilder2) 组件，你可以使用此仓库的内容直接构建一个开源版本的 Edgeless

## 使用方法
* 下载 Windows 10/11 系统镜像
* 下载最新版本的 Edgeless 镜像
* 下载最新版本的 [Wimbuilder2](https://slore.lanzoux.com/b00z5zy6b)
* 克隆本仓库：`git clone https://github.com/EdgelessPE/wimbuilder-component.git`
* 解压 Wimbuilder2，在解压后的目录中以管理员身份运行 cmd 并执行以下命令，注意替换变量 `EWC_DIR` 为实际的 `wimbuilder-component` 所在目录
    ```batch
    set EWC_DIR=%cd%\wimbuilder-component
    mklink /d .\Projects\WIN10XPE\10-Edgeless %EWC_DIR%\ 
    mklink .\Projects\WIN10XPE\_Assets_\preset\Edgeless.js %EWC_DIR%\Edgeless.js
    ```
* 运行 `WimBuilder.cmd`，在 `准备` 页面中选择挂载的系统镜像，并选择一个合适的映像版本；在 `定制` 页面中选择 `Edgeless` 预设，然后在 `构建` 页面中开始构建
* 编辑 Edgeless 镜像，替换 `source\boot.wim` 文件为 `.\_Factory_\target\WIN10XPE\build\boot.wim`

## 构建脚本
> （WIP）此刻构建脚本尚未就绪，你可以稍后再来查看

当需要执行一键构建操作时，可以使用此仓库中提供的一键构建脚本，注意需要预先安装以下程序并将主程序暴露到 PATH 变量中：
* Git
* 7-Zip
* UltraISO