title Edgeless Patch Running...

::挂载Tmp（鲁棒需要）
call PERegPorter.bat Tmp LOAD

::读取配置
set /p workshop=<.\_config\workshop.txt

::创建目录
md "%x%\Program Files\Edgeless\system_hooks\onDiskFound"
md "%x%\Program Files\Edgeless\system_hooks\beforeLocalBoost"
md "%x%\Program Files\Edgeless\system_hooks\beforePluginLoading"
md "%x%\Program Files\Edgeless\system_hooks\onPluginLoaded"
md "%x%\Program Files\Edgeless\system_hooks\onDesktopShown"
md "%x%\Program Files\Edgeless\system_hooks\onBootFinished"

::配置脚本运行宏
set run=.\_utils\pecmd.exe load .\_scripts\
set append1=.\_utils\pecmd.exe load .\_scripts\
set append2=
set finish=.\_utils\pecmd.exe load run.wcs

::main配置
if "x%opt[Edgeless.main_pecmd]%"=="xtrue" (
  copy /y .\_vendor\Files_pecmd\Pecmd.ini "%x%\Windows\System32\"
  copy /y .\_vendor\Files_pecmd\Launcher.bat "%x%\Program Files\"
)

if "x%opt[Edgeless.main_oem]%"=="xtrue" (
  %append1%main_oem.wcs%append2%
  type .\_commands\main_oem.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDesktopShown\_Preset.wcs"
)

if "x%opt[Edgeless.main_version]%"=="xtrue" (
  copy /y .\_config\version.txt "%x%\Program Files\"
)

if "x%opt[Edgeless.main_wp]%"=="xtrue" (
  copy /y .\_vendor\Files\user-200.png "%x%\ProgramData\Microsoft\User Account Pictures\"
  del /f /q "%x%\ProgramData\Microsoft\User Account Pictures\*.accountpicture-ms"
  reg delete HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.accountpicture-ms /va /f
  reg delete HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\AccountPicture /v SourceId /f

  copy /y .\_vendor\Files\img0.jpg "%x%\Windows\Web\Wallpaper\Windows\"
  set "opt[shell.wallpaper]=%cd%\_vendor\Files\img0.jpg"
)

if "x%opt[Edgeless.main_checkUpdate]%"=="xtrue" (
  del /f /q %x%\Windows\SystemResources\systemcpl.dll.mun
  copy /y .\_vendor\Bin_Update\systemcpl.dll.mun %x%\Windows\SystemResources\systemcpl.dll.mun
)

if "x%opt[Edgeless.main_activate]%"=="xtrue" (
  del /f /q %x%\Windows\System32\zh-CN\systemcpl.dll.mui
  copy /y .\_vendor\Bin_Activate\systemcpl.dll.mui %x%\Windows\System32\zh-CN\systemcpl.dll.mui
)

reg add "HKLM\Tmp_Software\Microsoft\Windows\Shell\Bags\1\Desktop" /f /v "IconSize" /t REG_DWORD /d %opt[Edgeless.main_desktopIconSize]%

if "x%opt[Edgeless.main_explorerRibbon]%"=="xtrue" (
  %append1%main_explorerRibbon.wcs%append2%
)

if "x%opt[Edgeless.main_displayHiddenFiles]%"=="xtrue" (
  %append1%main_displayHiddenFiles.wcs%append2%
)

if "x%opt[Edgeless.main_rightClickMenu]%"=="xtrue" (
  type .\_commands\main_rightClickMenu.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDesktopShown\_Preset.wcs"
)

if "x%opt[Edgeless.main_fixManage]%"=="xtrue" (
  type .\_commands\main_fixManage.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDesktopShown\_Preset.wcs"
)

if "x%opt[Edgeless.main_dpi]%"=="xtrue" (
  %append1%main_dpi.wcs%append2%
)

if "x%opt[Edgeless.main_7zPolish]%"=="xtrue" (
  %append1%main_7zPolish.wcs%append2%
)

if "x%opt[Edgeless.main_initStartIsBack]%"=="xtrue" (
  del /f /s /q "%x%\Program Files\StartIsBack"
  rd /s /q "%x%\Program Files\StartIsBack"
  xcopy /s /r /y .\_vendor\Soft_SIB\* "%x%\Program Files\"
  type .\_commands\main_initStartIsBack.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDesktopShown\_Preset.wcs"
)

if "x%opt[Edgeless.main_cleanCursors]%"=="xtrue" (
  %append1%main_cleanCursors.wcs%append2%
)

if "x%opt[Edgeless.main_orderdrv]%"=="xtrue" (
  xcopy /s /r /y .\_vendor\File_OrderDrv\* "%x%\Windows\System32\"
)

if "x%opt[Edgeless.main_enhancedType]%"=="xtrue" (
  type .\_commands\main_enhancedType.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDiskFound\_Preset.wcs"
)

if "x%opt[Edgeless.main_wcs]%"=="xtrue" (
  copy /y .\_vendor\Exec_Xcmd\xcmd.exe %x%\Windows\System32\xcmd.exe
  type .\_commands\main_wcs.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDiskFound\_Preset.wcs"
  %append1%main_wcs.wcs%append2%
)

if "x%opt[Edgeless.main_7z]%"=="xtrue" (
  %append1%main_7z.wcs%append2%
)

if "x%opt[Edgeless.main_7zf]%"=="xtrue" (
  type .\_commands\main_7zf.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDesktopShown\_Preset.wcs"
  %append1%main_7zf.wcs%append2%
)

if "x%opt[Edgeless.main_7zl]%"=="xtrue" (
  type .\_commands\main_7zl.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDesktopShown\_Preset.wcs"
  %append1%main_7zl.wcs%append2%
)

if "x%opt[Edgeless.main_eth]%"=="xtrue" (
  type .\_commands\main_eth.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDesktopShown\_Preset.wcs"
  %append1%main_eth.wcs%append2%
)

if "x%opt[Edgeless.main_iso]%"=="xtrue" (
  md "%x%\Users\Imdisk"
  xcopy /s /r /y "%workshop%\Users\Imdisk\*" "%x%\Users\Imdisk\"
  type .\_commands\main_iso.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDesktopShown\_Preset.wcs"
  type .\_commands\main_iso_removeImdiskMenu.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDesktopShown\_Preset.wcs"
  %append1%main_iso.wcs%append2%
)

if "x%opt[Edgeless.main_explainPartialTypes]%"=="xtrue" (
  type .\_commands\main_explainPartialTypes.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDesktopShown\_Preset.wcs"
)

if "x%opt[Edgeless.main_explainOpenWithNotepad]%"=="xtrue" type .\_commands\main_explainOpenWithNotepad.wcs>>"%x%\Program Files\Edgeless\system_hooks\onBootFinished\_Preset.wcs"


::Apple
if "x%opt[Edgeless.apple]%"=="xtrue" (
  %append1%apple.wcs%append2%
  xcopy /s /r /y .\_vendor\Lib_Apple\* "%x%\Windows\System32\drivers\"
)


::File
::xcopy /s /r /y .\core\Update\source\* .\

if "x%opt[Edgeless.file_system32]%"=="xtrue" (
  xcopy /s /r /y .\_vendor\File_System32\* "%x%\Windows\System32\"
)

if "x%opt[Edgeless.file_users]%"=="xtrue" (
  xcopy /s /r /y .\_vendor\File_Users\* "%x%\Users\"
)

if "x%opt[Edgeless.files_dynamic]%"=="xtrue" (
  md "%x%\Program Files\Edgeless\dynamic_creator"
  xcopy /s /r /y "%workshop%\Program Files\Edgeless\dynamic_creator\*" "%x%\Program Files\Edgeless\dynamic_creator\"
)

if "x%opt[Edgeless.files_easydown]%"=="xtrue" (
  md "%x%\Program Files\Edgeless\EasyDown"
  xcopy /s /r /y "%workshop%\Program Files\Edgeless\EasyDown\*" "%x%\Program Files\Edgeless\EasyDown\"
)

if "x%opt[Edgeless.files_Imdisk]%"=="xtrue" (
  md "%x%\Program Files\Edgeless\Imdisk"
  xcopy /s /r /y "%workshop%\Program Files\Edgeless\Imdisk\*" "%x%\Program Files\Edgeless\Imdisk\"
)

if "x%opt[Edgeless.files_downloader]%"=="xtrue" (
  md "%x%\Program Files\Edgeless\plugin_downloader"
  xcopy /s /r /y "%workshop%\Program Files\Edgeless\plugin_downloader\*" "%x%\Program Files\Edgeless\plugin_downloader\"
)

if "x%opt[Edgeless.files_ept]%"=="xtrue" (
  md "%x%\Program Files\Edgeless\plugin_ept"
  xcopy /s /r /y "%workshop%\Program Files\Edgeless\plugin_ept\*" "%x%\Program Files\Edgeless\plugin_ept\"
)

if "x%opt[Edgeless.files_loader]%"=="xtrue" (
  md "%x%\Program Files\Edgeless\plugin_loader"
  xcopy /s /r /y "%workshop%\Program Files\Edgeless\plugin_loader\*" "%x%\Program Files\Edgeless\plugin_loader\"
)

if "x%opt[Edgeless.files_localboost]%"=="xtrue" (
  md "%x%\Program Files\Edgeless\plugin_localboost"
  xcopy /s /r /y "%workshop%\Program Files\Edgeless\plugin_localboost\*" "%x%\Program Files\Edgeless\plugin_localboost\"
)

if "x%opt[Edgeless.files_addin]%"=="xtrue" (
  md "%x%\Program Files\Edgeless\system_addin"
  xcopy /s /r /y "%workshop%\Program Files\Edgeless\system_addin\*" "%x%\Program Files\Edgeless\system_addin\"
)

if "x%opt[Edgeless.files_log]%"=="xtrue" (
  md "%x%\Program Files\Edgeless\system_log"
  xcopy /s /r /y "%workshop%\Program Files\Edgeless\system_log\*" "%x%\Program Files\Edgeless\system_log\"
)

if "x%opt[Edgeless.files_update]%"=="xtrue" (
  md "%x%\Program Files\Edgeless\system_update"
  xcopy /s /r /y "%workshop%\Program Files\Edgeless\system_update\*" "%x%\Program Files\Edgeless\system_update\"
)

if "x%opt[Edgeless.files_theme]%"=="xtrue" (
  md "%x%\Program Files\Edgeless\theme_processer"
  xcopy /s /r /y "%workshop%\Program Files\Edgeless\theme_processer\*" "%x%\Program Files\Edgeless\theme_processer\"
)

if "x%opt[Edgeless.files_udisk]%"=="xtrue" (
  md "%x%\Program Files\Edgeless\udisk"
  xcopy /s /r /y "%workshop%\Program Files\Edgeless\udisk\*" "%x%\Program Files\Edgeless\udisk\"
)

if "x%opt[Edgeless.files_setx]%"=="xtrue" (
  copy /y .\_vendor\Files\setx.exe %x%\Windows\System32\
)

if "x%opt[Edgeless.files_dpinst]%"=="xtrue" (
  copy /y .\_vendor\Files\dpinst.exe "%x%\Program Files\Edgeless\system_addin\"
  copy /y .\_vendor\Files\dpinst.xml "%x%\Program Files\Edgeless\system_addin\"
)

if "x%opt[Edgeless.files_input]%"=="xtrue" (
  xcopy /s /r /y .\_vendor\Bin_NLS\* %x%\Windows\System32\
)

if "x%opt[Edgeless.files_firsttimeaid]%"=="xtrue" (
  copy /y .\_vendor\Files\应急包.7z "%x%\Program Files\"
)


::Patch
if "x%opt[Edgeless.patch_vc]%"=="xtrue" (
  %append1%patch_vc.wcs%append2%
  xcopy /s /r /y .\_vendor\Lib_VC9\* "%x%\"
)

@REM if "x%opt[Edgeless.patch_mklink]%"=="xtrue" (
@REM   %append1%patch_mklink.wcs%append2%
@REM )

::Optimization
if "x%opt[Edgeless.opt_cn]%"=="xtrue" (
  type .\_commands\opt_cn.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDiskFound\_Preset.wcs"
)

if "x%opt[Edgeless.opt_pin]%"=="xtrue" (
  copy /y .\_vendor\File_PinIcons\00-InitPinIcons.lua "%x%\PEMaterial\Autoruns\Startup\"
)

if "x%opt[Edgeless.opt_keyboard]%"=="xtrue" (
  type .\_commands\opt_keyboard.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDesktopShown\_Preset.wcs"
)

::执行run.wcs
::%finish%
title Edgeless Patch Finished
::pause
goto :eof