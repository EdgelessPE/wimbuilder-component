goto :eof
rem ���������������ļ����ܻ��DISM�����������������
if "x%opt[FirPE.AddDrver]%"=="xtrue" (
  echo ������������
  call PERegPorter Tmp unload
  DISM /image:"%WB_ROOT%\_Factory_\target\WIN10XPE\mounted" /Add-Driver /Driver:%cd%\Driver /forceunsigned /Recurse
  call PERegPorter Tmp load
)

rem ����PE
if "x%opt[FirPE.PESlim]%"=="xtrue" (
  echo ���ھ���PE
  if "x%opt[PESlim.mode]%"=="x" set opt[PESlim.mode]=1
  call %cd%\bin\һ������Win10PE.cmd %X% %opt[PESlim.mode]%

  if not "x%opt[PESlim.mode]%"=="1" (
    rem ���StartIsBack�ļ��������ɾ���Ĵ��ļ���ע�⣺���û�д���StartIsBack�ļ�������ᵼ�º����� 
    Del /A /F /Q "%X%\Windows\System32\twinui.dll"
    Del /A /F /Q "%X%\Windows\System32\cdp.dll"
    Del /A /F /Q "%X%\Windows\System32\dsreg.dll" 
    Del /A /F /Q "%X%\Windows\System32\twinui.pcshell.dll"

    rem ɾ����Դ��������������ܣ���Ӱ����Դ���������������֣�
    Del /A /F /Q "%X%\Windows\System32\UIRibbonRes.dll"
    Del /A /F /Q "%X%\Windows\System32\zh-CN\UIRibbonRes.dll.mui"
    Del /A /F /Q "%X%\Windows\System32\UIRibbon.dll"
    Del /A /F /Q "%X%\Windows\System32\zh-CN\UIRibbon.dll.mui"
    copy /y "%cd%\bin\shellstyle.dll" "%X%\Windows\System32\shellstyle.dll"
    rem ����ʾ�˵�
    Reg add "HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "AlwaysShowMenus" /t REG_DWORD /d "0" /f
    Reg add "HKLM\Tmp_DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "AlwaysShowMenus" /t REG_DWORD /d "0" /f
    rd /q /s "%X%\Windows\Resources\Themes\aero\Shell"

    rem ����ɾ�������ļ�
    Del /A /F /Q "%X%\Windows\System32\ieframe.dll"
    Del /A /F /Q "%X%\Windows\System32\zh-CN\ieframe.dll.mui"
    Del /A /F /Q "%X%\Windows\SystemResources\ieframe.dll.num"

    Del /A /F /Q "%X%\Windows\System32\Windows.Gaming.Input.dll"

    rem �����Դ���Ļ����
    rd /q /s "%X%\Program Files\Common Files"
    md "%X%\Program Files\Common Files"
    
    rem ɾ��WinSxS-servicingstack��ע�⣺ɾ����Ŀ¼���޷�DISM����������
    call :delFolder "%X%\Windows\WinSxS\amd64_microsoft-windows-servicingstack_*"
    Del /A /F /Q "%X%\Windows\WinSxS\manifests\amd64_microsoft-windows-servicingstack_*.manifest"
    call :delFolder "%X%\Windows\WinSxS\x86_microsoft-windows-servicingstack_*"
    Del /A /F /Q "%X%\Windows\WinSxS\manifests\x86_microsoft-windows-servicingstack_*.manifest"

    rem ɾ�����뷨����ļ���ע�⣺���û�д������뷨��������޷��������뷨ָʾ����
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
rem ɾ���ļ��У�֧��ͨ�����
for /f %%i in ('dir /ad /s /b %1') do (rd /s /q %%i)
goto :eof