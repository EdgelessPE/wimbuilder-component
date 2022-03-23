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

::调用精简脚本
if "x%opt[Edgeless.Slim]%" neq "x0" (
  call .\Slim\FirPE_Slim.cmd %x% %opt[Edgeless.Slim]%
  title Edgeless Patch Running...
)


::main配置
if "x%opt[Edgeless.main_pecmd]%"=="xtrue" (
  copy /y .\_vendor\Files_pecmd\Pecmd.ini "%x%\Windows\System32\"
  copy /y .\_vendor\Files_pecmd\OnShutdown.wcs "%x%\Windows\System32\"
  @REM copy /y .\_vendor\Files_pecmd\Launcher.bat "%x%\Program Files\"
  copy /y .\_vendor\Files_pecmd\_Config.wcs "%x%\Program Files\Edgeless\system_hooks\onDesktopShown\_Config.wcs"
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

if "x%opt[Edgeless.main_pinBrowsers]%"=="xtrue" (
  type .\_commands\main_pinBrowsers.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDesktopShown\_Preset.wcs"
)

reg add "HKLM\Tmp_Software\Microsoft\Windows\Shell\Bags\1\Desktop" /f /v "IconSize" /t REG_DWORD /d %opt[Edgeless.main_desktopIconSize]%

if "x%opt[Edgeless.main_explorerRibbon]%"=="xtrue" (
  %append1%main_explorerRibbon.wcs%append2%
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
  type .\_commands\main_initStartIsBack.wcs>>"%x%\Program Files\Edgeless\system_hooks\beforeLocalBoost\_Preset.wcs"
)

if "x%opt[Edgeless.main_cleanCursors]%"=="xtrue" (
  %append1%main_cleanCursors.wcs%append2%
)

if "x%opt[Edgeless.main_orderdrv]%"=="xtrue" (
  xcopy /s /r /y .\_vendor\File_OrderDrv\* "%x%\Windows\System32\"
)

if "x%opt[Edgeless.main_emoji]%"=="xtrue" (
    call AddFiles \Windows\fonts\seguiemj.ttf
)

if "x%opt[Edgeless.main_enhancedType]%"=="xtrue" (
  type .\_commands\main_enhancedType.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDiskFound\_Preset.wcs"
)

if "x%opt[Edgeless.main_wcs]%"=="xtrue" (
  copy /y .\_vendor\Exec_Xcmd\xcmd.exe %x%\Windows\System32\xcmd.exe
  %append1%main_wcs.wcs%append2%
)

if "x%opt[Edgeless.main_7z]%"=="xtrue" (
  %append1%main_7z.wcs%append2%
)

if "x%opt[Edgeless.main_7zf]%"=="xtrue" (
  %append1%main_7zf.wcs%append2%
)

if "x%opt[Edgeless.main_7zl]%"=="xtrue" (
  %append1%main_7zl.wcs%append2%
)

if "x%opt[Edgeless.main_eth]%"=="xtrue" (
  %append1%main_eth.wcs%append2%
)

if "x%opt[Edgeless.main_iso]%"=="xtrue" (
  md "%x%\Users\Imdisk"
  xcopy /s /r /y "%workshop%\Users\Imdisk\*" "%x%\Users\Imdisk\"
  type .\_commands\main_iso_removeImdiskMenu.wcs>>"%x%\Program Files\Edgeless\system_hooks\onBootFinished\_Preset.wcs"
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
  call AddFiles \Windows\System32\msvc*.dll
  call AddFiles \windows\System32\mfc40.dll
  call AddFiles \windows\System32\mfc40u.dll
  call AddFiles \windows\System32\mfc42.dll
  call AddFiles \windows\System32\mfc42u.dll
  call AddFiles \windows\System32\mfcore.dll
  call AddFiles \Windows\System32\vcruntime*.dll
  call AddFiles \Windows\System32\vcomp*.dll
  call AddFiles \Windows\System32\atl*.dll
  call AddFiles \Windows\System32\Drivers\fbwf.sys
  call AddFiles \Windows\System32\fontsub.dll
  call AddFiles \Windows\System32\dxva2.dll
  call AddFiles \Windows\System32\opengl32.dll
  call AddFiles \Windows\System32\glu32.dll
  call AddFiles \Windows\System32\httpapi.dll
  call AddFiles \Windows\System32\d3d8.dll
  call AddFiles \Windows\System32\d3d8thk.dll
  call AddFiles \Windows\System32\d3d9.dll
  call AddFiles \Windows\System32\d3d10.dll
  call AddFiles \Windows\System32\d3d10_1.dll
  call AddFiles \Windows\System32\d3d10_1core.dll
  call AddFiles \Windows\System32\d3d10core.dll
  call AddFiles \Windows\System32\d3d10level9.dll
  call AddFiles \Windows\System32\d3d10warp.dll
  call AddFiles \Windows\System32\d3d11.dll
  call AddFiles \Windows\System32\d3d11on12.dll
  call AddFiles \Windows\System32\d3d12.dll
  call AddFiles \Windows\System32\d3dcompiler_47.dll
  call AddFiles \Windows\System32\mfc140d.dll
  call AddFiles \Windows\System32\mfc140ud.dll
  call AddFiles \Windows\System32\mfc140.dll
  call AddFiles \Windows\System32\mfc140u.dll
  call AddFiles \Windows\System32\mfc140enu.dll
  call AddFiles \Windows\System32\mfc140chs.dll
)

if "x%opt[Edgeless.file_syswow64]%"=="xtrue" (
  xcopy /s /r /y .\_vendor\Lib_SysWOW64\* "%x%\Windows\SysWOW64\"
  call AddFiles \Windows\SysWOW64\msvb*.dll
  call AddFiles \Windows\SysWOW64\msvc*.dll
  call AddFiles \Windows\SysWOW64\msvcp140_1.dll
  call AddFiles \windows\SysWOW64\mfc40.dll
  call AddFiles \windows\SysWOW64\mfc40u.dll
  call AddFiles \windows\SysWOW64\mfc42.dll
  call AddFiles \windows\SysWOW64\mfc42u.dll
  call AddFiles \windows\SysWOW64\mfcore.dll
  call AddFiles \Windows\SysWOW64\atl*.dll
  call AddFiles \Windows\SysWOW64\vcruntime*.dll
  call AddFiles \Windows\SysWOW64\vcomp*.dll
  call AddFiles @windows\SysWOW64\msvf*.dll
  call AddFiles @windows\SysWOW64\msvidc*.dll
  call AddFiles \Windows\SysWOW64\fontsub.dll
  call AddFiles \Windows\SysWOW64\dxva2.dll
  call AddFiles \Windows\SysWOW64\opengl32.dll
  call AddFiles \Windows\SysWOW64\glu32.dll
  call AddFiles \Windows\SysWOW64\httpapi.dll
  call AddFiles \windows\SysWOW64\d3d8.dll
  call AddFiles \windows\SysWOW64\d3d8thk.dll
  call AddFiles \windows\SysWOW64\d3d9.dll
  call AddFiles \windows\SysWOW64\d3d10.dll
  call AddFiles \windows\SysWOW64\d3d10_1.dll
  call AddFiles \windows\SysWOW64\d3d10warp.dll
  call AddFiles \windows\SysWOW64\d3d10core.dll
  call AddFiles \windows\SysWOW64\d3d10level9.dll
  call AddFiles \windows\SysWOW64\d3d10_1core.dll
  call AddFiles \windows\SysWOW64\d3d11.dll
  call AddFiles \windows\SysWOW64\d3d12.dll
  call AddFiles \windows\SysWOW64\d3dcompiler_47.dll
  call AddFiles \windows\SysWOW64\d3d11on12.dll
  call AddFiles \windows\SysWOW64\hhctrl.dll
  call AddFiles \Windows\SysWOW64\mfc140d.dll
  call AddFiles \Windows\SysWOW64\mfc140ud.dll
  call AddFiles \Windows\SysWOW64\mfc140.dll
  call AddFiles \Windows\SysWOW64\mfc140u.dll
  call AddFiles \Windows\SysWOW64\mfc140enu.dll
  call AddFiles \Windows\SysWOW64\mfc140chs.dll
  call AddFiles \Windows\SysWOW64\cryptui.dll
  call AddFiles \Windows\SysWOW64\sfc.dll
  call AddFiles \Windows\SysWOW64\sfc_os.dll
)

if "x%opt[Edgeless.file_systemResources]%"=="xtrue" (
  xcopy /s /r /y .\_vendor\Lib_SystemResources\* "%x%\Windows\SystemResources\"
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
  type .\_commands\files_ept.wcs>>"%x%\Program Files\Edgeless\system_hooks\onDesktopShown\_Preset.wcs"
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
  type .\_commands\opt_keyboard.wcs>>"%x%\Program Files\Edgeless\system_hooks\beforeLocalBoost\_Preset.wcs"
  %append1%opt_keyboard.wcs%append2%
)

if "x%opt[Edgeless.opt_taskmgr]%"=="xtrue" (
  copy /y .\_vendor\File_Taskmgr\Taskmgr.exe.mui "%x%\Windows\System32\ZH-CN\"
)

if "x%opt[Edgeless.opt_remove_rtf]%"=="xtrue" (
  %append1%opt_remove_rtf.wcs%append2%
)

if "x%opt[Edgeless.opt_remove_undo]%"=="xtrue" (
  %append1%opt_remove_undo.wcs%append2%
)

if "x%opt[Edgeless.opt_loadDrivers]%"=="xtrue" (
  type .\_commands\opt_loadDrivers.wcs>>"%x%\Program Files\Edgeless\system_hooks\onBootFinished\_Preset.wcs"
)

if "x%opt[Edgeless.opt_cnUser]%"=="xtrue" (
  xcopy /s /r /y /h .\_vendor\File_User\* "%x%\Users\Default\"
  attrib +s "%x%\Users\Default\Desktop"
  attrib +s "%x%\Users\Default\Documents"
  attrib +s "%x%\Users\Default\Downloads"
  attrib +s "%x%\Users\Default\Pictures"
)

if "x%opt[Edgeless.opt_firefox]%"=="xtrue" (
  call AddFiles \Windows\System32\Windows.UI.FileExplorer.dll
)

if "x%opt[Edgeless.opt_ExplorerRibbon]%"=="xtrue" (
  %append1%opt_ExplorerRibbon.wcs%append2%
)

if "x%opt[Edgeless.opt_autoAllPrograms]%"=="xtrue" (
  %append1%opt_autoAllPrograms.wcs%append2%
)

if "x%opt[Edgeless.opt_fastShutdown]%"=="xtrue" (
  %append1%opt_fastShutdown.wcs%append2%
)

if "x%opt[Edgeless.opt_hideBootWindow]%"=="xtrue" (
  %append1%opt_hideBootWindow.wcs%append2%
)

if "x%opt[Edgeless.opt_minPENetwork]%"=="xtrue" (
  %append1%opt_minPENetwork.wcs%append2%
)

if "x%opt[Edgeless.opt_netDelay]%"=="xtrue" (
  %append1%opt_netDelay.wcs%append2%
)

if "x%opt[Edgeless.opt_removeNewShortcut]%"=="xtrue" (
  %append1%opt_removeNewShortcut.wcs%append2%
)

if "x%opt[Edgeless.opt_removeSearchIndex]%"=="xtrue" (
  %append1%opt_removeSearchIndex.wcs%append2%
)

if "x%opt[Edgeless.opt_transparentCMD]%"=="xtrue" (
  %append1%opt_transparentCMD.wcs%append2%
)

::执行run.wcs
::%finish%
title Edgeless Patch Finished
::pause
goto :eof