::挂载Tmp（鲁棒需要）
call PERegPorter.bat Tmp LOAD

::清理
del /f /q run.wcs

::脚本运行宏
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
  %append1%apple.wcs%append2%
)

if "x%opt[Edgeless.files_dynamic]%"=="xtrue" (
  %append1%files_dynamic.wcs%append2%
)

if "x%opt[Edgeless.files_easydown]%"=="xtrue" (
  %append1%files_easydown.wcs%append2%
)

if "x%opt[Edgeless.files_Imdisk]%"=="xtrue" (
  %append1%files_Imdisk.wcs%append2%
)

if "x%opt[Edgeless.files_downloader]%"=="xtrue" (
  %append1%files_downloader.wcs%append2%
)

if "x%opt[Edgeless.files_ept]%"=="xtrue" (
  %append1%files_ept.wcs%append2%
)

if "x%opt[Edgeless.files_loader]%"=="xtrue" (
  %append1%files_loader.wcs%append2%
)

if "x%opt[Edgeless.files_localboost]%"=="xtrue" (
  %append1%files_localboost.wcs%append2%
)

if "x%opt[Edgeless.files_addin]%"=="xtrue" (
  %append1%files_addin.wcs%append2%
)

if "x%opt[Edgeless.files_log]%"=="xtrue" (
  %append1%files_log.wcs%append2%
)

if "x%opt[Edgeless.files_update]%"=="xtrue" (
  %append1%files_update.wcs%append2%
)

if "x%opt[Edgeless.files_theme]%"=="xtrue" (
  %append1%files_theme.wcs%append2%
)

if "x%opt[Edgeless.files_udisk]%"=="xtrue" (
  %append1%files_udisk.wcs%append2%
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

if "x%opt[Edgeless.patch_vc]%"=="xtrue" (
  %append1%patch_vc.wcs%append2%
)

if "x%opt[Edgeless.patch_mklink]%"=="xtrue" (
  %append1%patch_mklink.wcs%append2%
)


goto :eof