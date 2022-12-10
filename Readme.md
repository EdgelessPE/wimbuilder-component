# Edgeless Wimbuilder2 Component for WIN10XPE
此仓库为 Edgeless 4.x 版本使用的 [Wimbuilder2](https://github.com/slorelee/wimbuilder2) 组件，你可以使用此仓库的内容自行构建一个半开源版本的 Edgeless

## 使用方法
* 下载 Windows 10/11 系统镜像
* 下载最新版本的 Edgeless 镜像
* 下载最新版本的 [Wimbuilder2](https://slore.lanzoux.com/b00z5zy6b)
* 克隆本仓库：`git clone https://github.com/EdgelessPE/wimbuilder-component.git`
* 解压 Wimbuilder2至 `Wimbuilder2` 目录，以管理员身份运行 cmd 并执行以下命令，注意替换变量 `EWC_DIR` 为实际的 `wimbuilder-component` 所在目录
    ```batch
    set EWC_DIR=%cd%\wimbuilder-component
    cd Wimbuilder2
    mklink /d .\Projects\WIN10XPE\10-Edgeless %EWC_DIR%\ 
    mklink .\Projects\WIN10XPE\_Assets_\preset\Edgeless.js %EWC_DIR%\Edgeless.js
    ```
    若需要生成 ISO 脚本则继续执行以下命令
    ```batch
    mklink .\test\Make_ISO.cmd %EWC_DIR%\build\Make_ISO.cmd
    ```
* 运行 `WimBuilder.cmd`，在 `准备` 页面中选择挂载的系统镜像，并选择一个合适的映像版本；在 `定制` 页面中选择 `Edgeless` 预设，然后在 `构建` 页面中开始构建
* 修改 `.\test\Make_ISO.cmd`，编辑开头处的环境变量值然后运行此脚本生成 ISO 镜像；或是手动编辑 Edgeless 镜像，替换 `source\boot.wim` 文件为 `.\_Factory_\target\WIN10XPE\build\boot.wim`

## 致谢
本仓库的诞生离不开：
* [杉](https://github.com/834772509)
* [Hydration](https://github.com/hydrati)
* [slqwqxd](https://github.com/slqwqxd)
* [undefined](https://github.com/undefined-ux)