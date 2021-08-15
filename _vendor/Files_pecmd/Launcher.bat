::注意：此文件将会在未来被二进制加载器取代
exit
@REM @echo off
@REM if not exist X:\Windows\System32 exit
@REM cd /d X:\Windows\System32
@REM echo %date% >>X:\Users\Log.txt
@REM echo %time% Launcher-运行 >>X:\Users\Log.txt
@REM set /p EL_VER=<"%ProgramFiles%\version.txt"
@REM echo %time% Launcher-版本号：%EL_VER% >>X:\Users\Log.txt
@REM :begin
@REM for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\version_Disk.txt echo %%1>Upath.txt
@REM for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\version.txt echo %%1>Upath.txt
@REM set /p Upath=<Upath.txt
@REM echo %time% Launcher-使用%Upath%作为Edgeless盘符 >>X:\Users\Log.txt

@REM if not defined Upath (
@REM   echo %time% Launcher-Upath未定义 >>X:\Users\Log.txt
@REM   if not exist x:\users\autoretry goto autoretry
@REM   echo %time% Launcher-弹出警告窗口（未发现启动盘） >>X:\Users\Log.txt
@REM   start /wait 0wait.cmd
@REM   if exist "X:\users\skipsetup" goto skipsetup
@REM   echo %time% Launcher-用户选择重试（关闭窗口） >>X:\Users\Log.txt
@REM   goto begin
@REM )

::如果存在更新的Launcher文件则调用
::如果要基于本文件制作Launcher.cmd，请务必删除此处的判断语句！
@REM set runWarn=0
@REM if exist %Upath%:\Edgeless\Launcher.cmd (
@REM   echo %time% Launcher-存在外置Launcher >>X:\Users\Log.txt
@REM   if exist %Upath%:\Edgeless\Config\Developer echo %time% Launcher-存在禁用警告开关 >>X:\Users\Log.txt
@REM   if not exist %Upath%:\Edgeless\Config\Developer set runWarn=1
@REM   if exist %Upath%:\Edgeless\Config\Developer set runWarn=2
@REM )
@REM if %runWarn%==1 pecmd exec =X:\Windows\System32\0warn.wcs
@REM if %runWarn%==2 pecmd exec X:\Windows\System32\0warn.wcs
@REM if exist %Upath%:\Edgeless\Launcher.cmd (
@REM   if exist X:\Users\useins echo %time% Launcher-用户取消使用外置 >>X:\Users\Log.txt
@REM   if not exist X:\Users\useins echo %time% Launcher-用户确认使用外置 >>X:\Users\Log.txt
@REM   if exist X:\Users\useins goto ctn
@REM   call %Upath%:\Edgeless\Launcher.cmd
@REM   exit
@REM )
@REM :ctn

::检查错误日志文件
::if exist %Upath%:\Edgeless\ErrorLog.txt (
::  echo %time% Launcher-检测到错误日志文件，将会跳过插件包加载 >>X:\Users\Log.txt
::  set errorTip=0
::)

::建立错误日志文件
::echo %time% Edgeless加载任务开始于%date% %time% >%Upath%:\Edgeless\ErrorLog.txt

::读取分辨率配置信息
@REM if exist "%Upath%:\Edgeless\分辨率.txt" (
@REM   if not exist %Upath%:\Edgeless\Config md %Upath%:\Edgeless\Config
@REM   move /y "%Upath%:\Edgeless\分辨率.txt" "%Upath%:\Edgeless\Config\分辨率.txt"
@REM )
@REM if exist "%Upath%:\Edgeless\Config\分辨率.txt" set /p disp=<"%Upath%:\Edgeless\Config\分辨率.txt"
@REM if exist "%Upath%:\Edgeless\Config\分辨率.txt" echo %time% Launcher-读取自定义分辨率：%disp% >>X:\Users\Log.txt


::拷贝自定义壁纸
@REM if exist "%Upath%:\Edgeless\wp.jpg" (
@REM echo %time% Launcher-拷贝壁纸 >>X:\Users\Log.txt
@REM copy "%Upath%:\Edgeless\wp.jpg" X:\Users\WallPaper\User.jpg
@REM if not exist "%Upath%:\Edgeless\wp.jpg" echo %time% Launcher-拷贝壁纸失败 >>X:\Users\Log.txt
@REM )

::补充Windows文件夹内容
@REM if exist %Upath%:\Edgeless\Windows echo %time% Launcher-开始补充Windows文件夹 >>X:\Users\Log.txt
@REM if exist %Upath%:\Edgeless\Windows xcopy /s /r /y "%Upath%:\Edgeless\Windows\*" "X:\Windows\*"

::必要组件包处理模块
::if exist "%Upath%:\Edgeless\Nes_Inport.7z" (
::echo %time% Launcher-开始加载必要组件包 >>X:\Users\Log.txt
::call "X:\Program Files\Edgeless\dynamic_creator\dynamic_tip.cmd" 4000 Edgeless初始化 正在加载必要组件包
::"%ProgramFiles%\7-Zip_x64\7z.exe" x "%Upath%:\Edgeless\Nes_Inport.7z" -o"X:\Program Files\Edgeless" -aoa
::)
::if not exist "%Upath%:\Edgeless\Nes_Inport.7z" echo %time% Launcher-未发现必要组件包 >>X:\Users\Log.txt
::if not exist "%Upath%:\Edgeless\Nes_Inport.7z" call "X:\Program Files\Edgeless\dynamic_creator\dynamic_msgbox.cmd" Edgeless初始化程序 警告：没有发现必要组件包Nes_Inport.7z，Edgeless将会失去必要的工具依赖！
::if exist "%ProgramFiles%\Edgeless\Nes.ini" pecmd load "%ProgramFiles%\Edgeless\Nes.ini"

::设置壁纸
@REM if exist X:\Users\WallPaper\User.jpg (
@REM pecmd wall X:\Users\WallPaper\User.jpg
@REM )

::插件包安装模块
::if defined errorTip (
::  echo %time% Launcher-存在错误文件，跳过插件包加载 >>X:\Users\Log.txt
::  goto endPluginLoad
::)
::if exist "%Upath%:\Edgeless\Resource\*.7z" (
::echo %time% Launcher-开始载入插件包 >>X:\Users\Log.txt
::call "X:\Program Files\Edgeless\dynamic_creator\dynamic_tip.cmd" 5000 Edgeless初始化 正在加载插件包
::echo %time% Launcher-插件包列表 >>X:\Users\Log.txt
::dir /b %Upath%:\Edgeless\Resource\*.7z >>X:\Users\Log.txt
::"%ProgramFiles%\7-Zip_x64\7z.exe" x %Upath%:\Edgeless\Resource\*.7z  -y -aos -o"%ProgramFiles%\Edgeless"
::echo %time% Launcher-外置批处理列表 >>X:\Users\Log.txt
::dir /b "%ProgramFiles%\Edgeless\*.cmd" >>X:\Users\Log.txt
::dir /b "%ProgramFiles%\Edgeless\*.wcs" >>X:\Users\Log.txt
::dir /b "%ProgramFiles%\Edgeless\*.cmd" >"%ProgramFiles%\Edgeless\cmdlist.txt"
::for /f  "usebackq" %%a in  ("%ProgramFiles%\Edgeless\cmdlist.txt") do (
::start "" /D "X:\Program Files\Edgeless\" "%%a"
::echo %time% Launcher-运行%%a >>X:\Users\Log.txt
::pecmd exec !"%ProgramFiles%\Edgeless\%%a"
::pecmd wait 100
::  )
::dir /b "%ProgramFiles%\Edgeless\*.wcs" >"%ProgramFiles%\Edgeless\wcslist.txt"
::for /f  "usebackq" %%a in  ("%ProgramFiles%\Edgeless\wcslist.txt") do (
::start "" /D "%ProgramFiles%\Edgeless\" "%%a"
::echo %time% Launcher-运行%%a >>X:\Users\Log.txt
::xcmd load "%ProgramFiles%\Edgeless\%%a"
::pecmd wait 100
::  )
::del /f /q "%ProgramFiles%\Edgeless\cmdlist.txt"
::del /f /q "%ProgramFiles%\Edgeless\wcslist.txt"
::如果用户将启动盘制作工具当成插件包，则为其添加快捷方式
::if exist "%ProgramFiles%\Edgeless\启动盘制作工具\制作启动盘.exe" echo %time% Launcher-用户将制作工具当做了插件包 >>X:\Users\Log.txt
::if exist "%ProgramFiles%\Edgeless\启动盘制作工具\制作启动盘.exe" pecmd link "X:\Users\Default\Desktop\制作启动盘","X:\Program Files\Edgeless\启动盘制作工具\制作启动盘.exe",,"X:\Users\Icon\shortcut\usbburner.ico",0
::)
:endPluginLoad

@REM call "X:\Program Files\Edgeless\dynamic_creator\dynamic_tip.cmd" 2000 Edgeless初始化 正在生效用户配置

::关联ISO组件
@REM if exist %Upath%:\Edgeless\Config\DisableSmartISO echo %time% Launcher-响应禁用智能虚拟光驱 >>X:\Users\Log.txt
@REM if not exist %Upath%:\Edgeless\Config\DisableSmartISO reg add "HKCR\.iso" /f /ve /t REG_SZ /d "Imdisk.iso"
@REM reg add "HKCR\Imdisk.iso" /f /ve /t REG_SZ /d "ISO"
@REM reg add "HKCR\Imdisk.iso\DefaultIcon" /f /ve /t REG_SZ /d "%%SystemRoot%%\System32\shell32.dll,188"
@REM reg add "HKCR\Imdisk.iso\shell" /f /ve /t REG_SZ /d ""
@REM reg add "HKCR\Imdisk.iso\shell\open" /f /ve /t REG_SZ /d ""
@REM reg add "HKCR\Imdisk.iso\shell\open\command" /f /ve /t REG_SZ /d "X:\Users\Imdisk\SmartISO.exe \"%%1\""

@REM ::响应禁用U盘管理开关
@REM if exist %Upath%:\Edgeless\Config\DisableUSBManager echo %time% Launcher-响应禁用U盘管理开关 >>X:\Users\Log.txt
@REM if exist %Upath%:\Edgeless\Config\DisableUSBManager md X:\Users\DisableUSBManager

@REM ::响应默认按钮为重启开关
@REM if exist %Upath%:\Edgeless\Config\RebootDefault echo %time% Launcher-响应默认按钮为重启开关 >>X:\Users\Log.txt
@REM if exist %Upath%:\Edgeless\Config\RebootDefault reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "Start_PowerButtonAction" /t REG_DWORD /d 4

@REM ::响应禁用回收站开关
@REM if exist %Upath%:\Edgeless\Config\DisableRecycleBin echo %time% Launcher-响应禁用回收站开关 >>X:\Users\Log.txt
@REM if exist %Upath%:\Edgeless\Config\DisableRecycleBin pecmd RECY *:\,0

@REM ::处理全局自动应答
@REM if exist %Upath%:\Edgeless\Config\AutoUnattend echo %time% Launcher-处理全局自动应答开关 >>X:\Users\Log.txt
@REM if exist %Upath%:\Edgeless\Config\AutoUnattend pecmd file X:\Users\Imdisk\AutoUnattend.xml=>X:\AutoUnattend.xml

@REM ::响应展开资源管理器功能区
@REM if exist %Upath%:\Edgeless\Config\UnfoldRibbon echo %time% Launcher-响应展开资源管理器功能区开关 >>X:\Users\Log.txt
@REM if exist %Upath%:\Edgeless\Config\UnfoldRibbon reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /f /v "ExplorerRibbonStartsMinimized" /t REG_DWORD /d 2

@REM ::响应挂载所有分区
@REM if exist %Upath%:\Edgeless\Config\MountEveryPartition echo %time% Launcher-响应显示所有分区 >>X:\Users\Log.txt
@REM if exist %Upath%:\Edgeless\Config\MountEveryPartition pecmd SHOW =1 *

@REM ::过期插件包检测与提醒
@REM if exist %Upath%:\Edgeless\Config\NoOutDateCheck echo %time% Launcher-响应禁用过期插件包检测开关 >>X:\Users\Log.txt
@REM if not exist %Upath%:\Edgeless\Config\NoOutDateCheck pecmd exec !"%ProgramFiles%\Edgeless\plugin_outdatedcheck\compare.cmd"

@REM ::调节分辨率
@REM if defined disp (
@REM   if "%disp%"=="DisableAutoSuit" echo %time% Launcher-检查到DisableAutoSuit，跳过分辨率设置 >>X:\Users\Log.txt
@REM   if "%disp%"=="DisableAutoSuit" goto endAutoSuit
@REM )
@REM xcmd disp %disp%
@REM echo %time% Launcher-设置分辨率结束 >>X:\Users\Log.txt
@REM :endAutoSuit

@REM ::Edgeless文件夹整理
@REM cd /d "%ProgramFiles%\Edgeless"
@REM if not exist 安装程序 md 安装程序
@REM move /y *.cmd 安装程序
@REM move /y *.wcs 安装程序
@REM move /y Nes.ini 安装程序
@REM cd 安装程序
@REM echo 本目录存放插件包的安装程序 > 说明.txt
@REM echo 如需使用，请将其移到上级目录后运行 >> 说明.txt
@REM echo %time% Launcher-程序正常退出 >>X:\Users\Log.txt

@REM ::删除错误日志文件
@REM for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\ErrorLog.txt del /f /q %%1:\Edgeless\ErrorLog.txt

::运行错误原因提示
::if defined errorTip call "X:\Program Files\Edgeless\dynamic_creator\dynamic_msgbox.cmd" Edgeless初始化程序 Edgeless已自动修复上一次启动错误，原因是您的机器内存过小而插件包过多导致奔溃，建议禁用部分插件包！
exit

@REM :skipsetup
@REM echo %time% Launcher-用户选择SkipSetup，程序退出 >>X:\Users\Log.txt
@REM call "X:\Program Files\Edgeless\plugin_loader\load.cmd" "X:\Program Files\应急包.7z"
@REM rd x:\users\autoretry
@REM cd /d X:\Windows\System32
@REM pecmd link "X:\Users\Default\Desktop\重新加载","X:\Program Files\Launcher.bat"
@REM exit

@REM :autoretry
@REM md x:\users\autoretry
@REM pecmd wait 2500
@REM echo %time% Launcher-进行第一次重试 >>X:\Users\Log.txt
@REM goto begin