title Edgeless Patch Running...

::挂载Tmp（鲁棒需要）
call PERegPorter.bat Tmp LOAD

::读取配置
set /p workshop=<.\_config\workshop.txt

::创建目录
md "%x%\Program Files\Edgeless\system_hooks\onDiskFound"
md "%x%\Program Files\Edgeless\system_hooks\beforeLocalBoost"
md "%x%\Program Files\Edgeless\system_hooks\beforePluginLoading"
md "%x%\Program Files\Edgeless\system_hooks\onDesktopShown"
md "%x%\Program Files\Edgeless\system_hooks\onBootFinished"
md "%x%\Program Files\Edgeless\system_hooks\onExit"

::配置脚本运行宏
set run=.\_utils\pecmd.exe load .\_scripts\
set append1=.\_utils\pecmd.exe load .\_scripts\
set append2=
set finish=.\_utils\pecmd.exe load run.wcs

{{commands}}

::执行run.wcs
::%finish%
title Edgeless Patch Finished
::pause
goto :eof

