goto :eof
rem 增加驱动（精简文件可能会把DISM增加驱动给精简掉）
if "x%opt[FirPE.AddDrver]%"=="xtrue" (
  echo 正在增加驱动
  call PERegPorter Tmp unload
  DISM /image:"%WB_ROOT%\_Factory_\target\WIN10XPE\mounted" /Add-Driver /Driver:%cd%\Driver /forceunsigned /Recurse
  call PERegPorter Tmp load
)

rem 精简PE
if "x%opt[FirPE.PESlim]%"=="xtrue" (
  echo 正在精简PE
  if "x%opt[PESlim.mode]%"=="x" set opt[PESlim.mode]=1
  call %cd%\bin\一键精简Win10PE.cmd %X% %opt[PESlim.mode]%

  if not "x%opt[PESlim.mode]%"=="1" (
    rem 变更StartIsBack文件依赖后可删除的大文件（注意：如果没有处理StartIsBack文件依赖则会导致黑屏） 
    Del /A /F /Q "%X%\Windows\System32\twinui.dll"
    Del /A /F /Q "%X%\Windows\System32\cdp.dll"
    Del /A /F /Q "%X%\Windows\System32\dsreg.dll" 
    Del /A /F /Q "%X%\Windows\System32\twinui.pcshell.dll"

    rem 删除资源管理器功能区框架（会影响资源管理器功能区布局）
    Del /A /F /Q "%X%\Windows\System32\UIRibbonRes.dll"
    Del /A /F /Q "%X%\Windows\System32\zh-CN\UIRibbonRes.dll.mui"
    Del /A /F /Q "%X%\Windows\System32\UIRibbon.dll"
    Del /A /F /Q "%X%\Windows\System32\zh-CN\UIRibbon.dll.mui"
    copy /y "%cd%\bin\shellstyle.dll" "%X%\Windows\System32\shellstyle.dll"
    rem 不显示菜单
    Reg add "HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "AlwaysShowMenus" /t REG_DWORD /d "0" /f
    Reg add "HKLM\Tmp_DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "AlwaysShowMenus" /t REG_DWORD /d "0" /f
    rd /q /s "%X%\Windows\Resources\Themes\aero\Shell"

    rem 风险删除部分文件
    Del /A /F /Q "%X%\Windows\System32\ieframe.dll"
    Del /A /F /Q "%X%\Windows\System32\zh-CN\ieframe.dll.mui"
    Del /A /F /Q "%X%\Windows\SystemResources\ieframe.dll.num"

    Del /A /F /Q "%X%\Windows\System32\Windows.Gaming.Input.dll"

    rem 精简自带屏幕键盘
    rd /q /s "%X%\Program Files\Common Files"
    md "%X%\Program Files\Common Files"
    
    rem 删除WinSxS-servicingstack（注意：删除此目录后将无法DISM增加驱动）
    call :delFolder "%X%\Windows\WinSxS\amd64_microsoft-windows-servicingstack_*"
    Del /A /F /Q "%X%\Windows\WinSxS\manifests\amd64_microsoft-windows-servicingstack_*.manifest"
    call :delFolder "%X%\Windows\WinSxS\x86_microsoft-windows-servicingstack_*"
    Del /A /F /Q "%X%\Windows\WinSxS\manifests\x86_microsoft-windows-servicingstack_*.manifest"

    rem 删除输入法相关文件（注意：如果没有处理输入法依赖则会无法运行输入法指示器）
    rd /q /s "%X%\Windows\IME"
    rd /q /s "%X%\Windows\System32\IME"
    rd /q /s "%X%\Windows\System32\InputMethod"
    Del /A /F /Q "%X%\Windows\System32\MTF.dll"
    Del /A /F /Q "%X%\Windows\System32\MTFServer.dll"
    rem Del /A /F /Q "%X%\Windows\System32\msctfp.dll"
    Del /A /F /Q "%X%\Windows\System32\msctfuimanager.dll"
    Del /A /F /Q "%X%\Windows\System32\TextInputMethodFormatter.dll"
    Del /A /F /Q "%X%\Windows\System32\input.dll"
    Del /A /F /Q "%X%\Windows\System32\InputService.dll"
    Del /A /F /Q "%X%\Windows\System32\InputLocaleManager.dll"
  )
)
goto :eof

:delFolder
rem 删除文件夹（支持通配符）
for /f %%i in ('dir /ad /s /b %1') do (rd /s /q %%i)
goto :eof