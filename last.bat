@echo off

rem ɾ������PE�����Ա������ֲ��������
if "x%opt[FirPE.DelOtherWinPEFile]%"=="xtrue" (
  echo ����ɾ������PE����
  call :DelOthersPEFiles
)

rem �޸������޸�PEWinSxS�ļ�ȱʧ
if  not exist %X%\Windows\WinSxS\x86* (
  call %cd%\bin\WinSxS.cmd
)

rem ���ӹ���
if "x%opt[AddFeatures.NetDriver]%"=="xtrue" (
  echo ������ǿԭ����������
  call %cd%\bin\��ǿ��������.cmd
) else (
  rem ������������
  call AddFiles \Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\Microsoft-Windows-Client-Desktop-Required-Package*.cat
)

rem �����ļ�
if "x%opt[FirPE.AddFile]%"=="xtrue" (
  call :ApplySubPatch ".\AddFile"
)

rem ����������PE��ʶ
copy /y "%cd%\bin\ucert.sys" "%X%\Windows\System32\drivers\ucert.sys"
set ucertPath=%X%\Windows\System32\DriverStore\FileRepository\ucert.inf_amd64_223D64613F2E8812
md "%ucertPath%"
copy /y "%cd%\bin\ucert.sys" "%ucertPath%\ucert.sys"

rem ��汾Ϊ32Ϊ����ж��⴦��
if not "%WB_PE_ARCH%"=="x64" (
  echo ���ڽ��� WinPE X32 ����
  xcopy /C /S /Y "%cd%\X_32\*" "%X%"
  move /y "%X%\Windows\SysWOW64\*" "%X%\Windows\System32"
  for /r "%X%\Program Files (x86)" %%i in (*) do move "%%i" "%X%\Program Files"

  rem ����������PE��ʶ ��32λ��
  rd /q /s "%ucertPath%"
  set ucertPath=%X%\Windows\System32\DriverStore\FileRepository\ucert.inf_amd64_223D64613F2E8812
  md "%ucertPath%"
  copy /y "%cd%\bin\ucert.sys" "%ucertPath%\ucert.sys"

  rem ɾ�������ļ�
  rd /q /s "%X%\Windows\SysWOW64"
  rd /q /s "%X%\Program Files (x86)"
  for /f %%i in ('dir /ad /b %X%\Windows\WinSxS\amd64*') do (rd /s /q "%X%\Windows\WinSxS\%%i")
  for /f %%i in ('dir /ad /b %X%\Windows\WinSxS\Manifests\amd64*') do (rd /s /q "%X%\Windows\WinSxS\Manifests\%%i")

  rem ����X��4GB����ԭ��fbws.sys��
  reg add HKLM\Tmp_System\ControlSet001\Services\FBWF /v WinPECacheThreshold /t REG_DWORD /d 4095 /f
)

rem ��ȡ�ļ�Ȩ��
echo ���ڻ�ȡ�ļ�Ȩ��
takeown /f "%X%" /r /d y>nul
cacls "%X%" /T /E /G Everyone:F>nul

rem ���� FirPE ��������֤
Reg add "HKLM\Tmp_DEFAULT\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "Autorun" /t REG_SZ /d "PECMD IFEX X:\Windows\System32\startnet.cmd,EXEC !!X:\Windows\System32\startnet.cmd ! SHUT R" /f

rem ���� WindowsPE ��ʶ
reg query "HKLM\Tmp_SOFTWARE\Microsoft\Windows NT\CurrentVersion\WinPE" /v Version 2>nul | findstr . && echo ��������PE�汾�� ||(
echo ��������PE�汾��
REG ADD "HKLM\Tmp_SOFTWARE\Microsoft\Windows NT\CurrentVersion\WinPE" /v Version /t REG_SZ /d %WB_PE_VER%
)

rem ����ע���
if "x%opt[FirPE.SlimRegistry]%"=="xtrue" (
  echo ���ھ���ע���
  call %cd%\bin\һ������ע���.cmd
  regedit /s %WB_PROJECT_PATH%\00-Configures\Build\lite.reg
)

rem �Ż�ע���
if "x%opt[FirPE.ModifyRegistry]%"=="xtrue" (
  echo �����Ż�ע���

  rem ���� ����վ
  Reg delete "HKLM\Tmp_DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\BitBucket" /f
  Reg add "HKLM\Tmp_DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\BitBucket" /f
  SetACL.exe -on "HKLM\Tmp_DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\BitBucket"  -ot reg -actn setprot -op "dacl:p_c;sacl:p_c"
  SetACL.exe -on "HKLM\Tmp_DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\BitBucket"   -ot reg -actn clear -clr "dacl,sacl"

  reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\systemrestore" /v DisableConfig /t reg_dword /d 1 /f
  reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\systemrestore" /v DisableSR /t reg_dword /d 1 /f

  rem �Ż�ע���
  FOR %%R IN (Regs\*.REG) DO (REGEDIT /s %%R)

  rem ɾ���ɵ�PECMD�����ļ�
  Del /A /F /Q "%X%\Windows\System32\Pecmd.ini"
  Del /A /F /Q "%X%\Windows\System32\PecmdAdmin.ini"

  Del /A /F /Q "%X%\Windows\System32\winpeshl.exe"
  Del /A /F /Q "%X%\Windows\System32\winpeshl.ini"
)

rem ���µ���SOFTWAREע���ˢ�������
echo �������µ���ע���
Del /A /F /Q Tmp_SOFTWARE
REG SAVE HKEY_LOCAL_MACHINE\Tmp_SOFTWARE Tmp_SOFTWARE /y /c
reg unload HKLM\Tmp_SOFTWARE
copy /y Tmp_SOFTWARE "%X%\Windows\System32\config\SOFTWARE"
reg load HKLM\Tmp_SOFTWARE %X%\Windows\System32\config\SOFTWARE
Del /A /F /Q Tmp_SOFTWARE

echo FirPE�����������
goto :eof

:ApplySubPatch
echo Applying Patch:%~1\main.bat
pushd "%~1"
call main.bat
popd
goto :EOF

rem ɾ������PE�ļ�
:DelOthersPEFiles
rd /q /s "%X%\PETools"
rd /q /s "%X%\Tools"
rd /q /s "%X%\PESOFT"
rd /q /s "%X%\123SOFT"
rd /q /s "%X%\XYLYUSBTOOLS"
rd /q /s "%X%\Program Files\Haozip"
rd /q /s "%X%\Program Files\XiaoPE"
rd /q /s "%X%\Program Files\LegnaPE"
rd /q /s "%X%\Program Files\Core"
rd /q /s "%X%\Program Files\Ico"

rem ɾ�����ù���
rd /q /s "%X%\Program Files\yong"
rd /q /s "%X%\Program Files\Freewb"
rd /q /s "%X%\Program Files\Freeime"
rd /q /s "%X%\Program Files\AomeiPartAssistant"
rd /q /s "%X%\Program Files\RegShot2"
rd /q /s "%X%\Program Files\WinSnap"
rd /q /s "%X%\Program Files\FireFox"
rd /q /s "%X%\Program Files\AIDA64"
rd /q /s "%X%\Program Files\ThunderMini"
rd /q /s "%X%\Program Files\�ѹ����"
rd /q /s "%X%\Program Files\7-data"
rd /q /s "%X%\Program Files\DISM++"
rd /q /s "%X%\Program Files\Others"
rd /q /s "%X%\Program Files\Office2007"
rd /q /s "%X%\Program Files\Potplayer"
rd /q /s "%X%\Program Files\TcQQ"
rd /q /s "%X%\Program Files\wimtool"
rd /q /s "%X%\Program Files\everything"
rd /q /s "%X%\Program Files\Imagine"
rd /q /s "%X%\Program Files\DiskGenius"
rd /q /s "%X%\Program Files\Ghost"
rd /q /s "%X%\Program Files\CGI"
rd /q /s "%X%\Program Files\NTPassword"
rd /q /s "%X%\Program Files\Snapshot"
rd /q /s "%X%\Program Files\WinHex"
rd /q /s "%X%\Program Files\WinNTSetup"

Del /A /F /Q "%X%\Program Files\bootice.exe"
Del /A /F /Q "%X%\Program Files\version.txt"
Del /A /F /Q "%X%\Program Files\config.bat"
Del /A /F /Q "%X%\Program Files\PETools.ini"
Del /A /F /Q "%X%\Program Files\StartMenu.reg"

Del /A /F /Q "%X%\Windows\System32\peset.exe"
Del /A /F /Q "%X%\Windows\System32\peset.ini"
Del /A /F /Q "%X%\Windows\System32\0*"
Del /A /F /Q "%X%\Windows\System32\wait.cmd"
Del /A /F /Q "%X%\Windows\System32\pever.exe"
Del /A /F /Q "%X%\Windows\System32\9xpe.exe"
Del /A /F /Q "%X%\Windows\System32\EXLOAD64.exe"
Del /A /F /Q "%X%\Windows\System32\Xload*.exe"

goto :eof