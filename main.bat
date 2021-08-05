::挂载Tmp（鲁棒需要）
call PERegPorter.bat Tmp LOAD

::清理
del /f /q run.wcs

::读取配置
set /p workshop=<.\_config\workshop.txt

::配置脚本运行宏
set run=.\_utils\pecmd.exe load .\_scripts\
set append1=type 
set append2=>>run.wcs
set finish=.\_utils\pecmd.exe load run.wcs

::main配置
if "x%opt[Edgeless.main_oem]%"=="xtrue" (
  %append1%main_oem.wcs%append2%
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
  type .\_commands\main_rightClickMenu.wcs>>"%x%\Program Files\Edgeless\system_hooks\4-onDesktopShown\_Preset.wcs"
)

if "x%opt[Edgeless.main_fixManage]%"=="xtrue" (
  type .\_commands\main_fixManage.wcs>>"%x%\Program Files\Edgeless\system_hooks\4-onDesktopShown\_Preset.wcs"
)

if "x%opt[Edgeless.main_dpi]%"=="xtrue" (
  %append1%main_dpi.wcs%append2%
)

if "x%opt[Edgeless.main_7zPolish]%"=="xtrue" (
  %append1%main_7zPolish.wcs%append2%
)

if "x%opt[Edgeless.main_initStartIsBack]%"=="xtrue" (
  %append1%main_initStartIsBack.wcs%append2%
)

if "x%opt[Edgeless.main_cleanCursors]%"=="xtrue" (
  %append1%main_cleanCursors.wcs%append2%
)

if "x%opt[Edgeless.main_wcs]%"=="xtrue" (
  copy /y .\_vendor\Exec_Xcmd\xcmd.exe %x%\Windows\System32\xcmd.exe
  type .\_commands\main_wcs.wcs>>"%x%\Program Files\Edgeless\system_hooks\4-onDesktopShown\_Preset.wcs"
  %append1%main_wcs.wcs%append2%
)

if "x%opt[Edgeless.main_7z]%"=="xtrue" (
  %append1%main_7z.wcs%append2%
)

if "x%opt[Edgeless.main_7zf]%"=="xtrue" (
  type .\_commands\main_7zf.wcs>>"%x%\Program Files\Edgeless\system_hooks\4-onDesktopShown\_Preset.wcs"
  %append1%main_7zf.wcs%append2%
)

if "x%opt[Edgeless.main_7zl]%"=="xtrue" (
  type .\_commands\main_7zl.wcs>>"%x%\Program Files\Edgeless\system_hooks\4-onDesktopShown\_Preset.wcs"
  %append1%main_7zl.wcs%append2%
)

if "x%opt[Edgeless.main_eth]%"=="xtrue" (
  type .\_commands\main_eth.wcs>>"%x%\Program Files\Edgeless\system_hooks\4-onDesktopShown\_Preset.wcs"
  %append1%main_eth.wcs%append2%
)

if "x%opt[Edgeless.main_iso]%"=="xtrue" (
  md "%x%\Users\Imdisk"
  xcopy /s /r /y "%workshop%\Users\Imdisk\*" "%x%\Users\Imdisk\"
  type .\_commands\main_iso.wcs>>"%x%\Program Files\Edgeless\system_hooks\4-onDesktopShown\_Preset.wcs"
  %append1%main_iso.wcs%append2%
)

if "x%opt[Edgeless.main_explainPartialTypes]%"=="xtrue" (
  %append1%main_explainPartialTypes.wcs%append2%
)

if "x%opt[Edgeless.main_explainOpenWithNotepad]%"=="xtrue" (
  type .\_commands\main_explainOpenWithNotepad.wcs>>"%x%\Program Files\Edgeless\system_hooks\4-onDesktopShown\_Preset.wcs"
)


::Apple
if "x%opt[Edgeless.apple]%"=="xtrue" (
  ::%append1%apple.wcs%append2%
)


::File
::xcopy /s /r /y .\core\Update\source\* .\
md "%x%\Program Files\Edgeless\"

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
  %append1%files_setx.wcs%append2%
)

if "x%opt[Edgeless.files_dpinst]%"=="xtrue" (
  %append1%files_dpinst.wcs%append2%
)

if "x%opt[Edgeless.files_smartctl]%"=="xtrue" (
  %append1%files_smartctl.wcs%append2%
)

if "x%opt[Edgeless.files_input]%"=="xtrue" (
  %append1%files_input.wcs%append2%
)

if "x%opt[Edgeless.files_firsttimeaid]%"=="xtrue" (
  %append1%files_firsttimeaid.wcs%append2%
)


::Patch
if "x%opt[Edgeless.patch_vc]%"=="xtrue" (
  %append1%patch_vc.wcs%append2%
  xcopy /s /r /y .\_vendor\Lib_VC9\* "%x%\"
)

if "x%opt[Edgeless.patch_mklink]%"=="xtrue" (
  ::%append1%patch_mklink.wcs%append2%
)

::执行run.wcs
%finish%

goto :eof