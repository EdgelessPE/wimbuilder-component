@echo off
title Running FirPE Slim...
REM ��ʾ��
REM     �� for %%f in () do () ����У����ļ��б���ʹ��remע����Ч��
setlocal enabledelayedexpansion
if "%1"=="" (
  if "%2"=="" (
    rem �޲�������
    set /p X=������ Win10PE -X64  �Ĺ���λ�ã�
    echo ��ѡ�񾫼�ʽ
    echo ===================================
    echo 1: ��ȫ���򣨻�����Ӱ��ʹ�ã�
    echo 2: ��ͨ���򣨸���wimboo�ļ��б�
    echo 3: ���޾��򣨾�����350MB���ң�
    echo 4: ά�����򣨾����������硢��������
    echo ===================================
    set /p M=��������Ҫ�ľ���ʽ��
    call :start
    echo Win10PE������ϣ���������˳�
    pause
    exit
  )
) else (
  rem �������ã�%1ΪWin10PE����·����%2Ϊ���򷽰�
  set X=%1
  set M=%2
  call :start
  echo Win10PE�������
  title Finish FirPE Slim
  goto :eof
)

:start
if "%M%"=="1" call :SafeSlim
if "%M%"=="2" call :NormlSlim
if "%M%"=="3" call :LimitSlim
if "%M%"=="4" call :MaintainSlim
echo =============
rem ��������Ŀ¼
md "%X%\Program Files (x86)\Common Files"
md "%X%\Windows\Cursors"
goto :eof

rem ==================================================================
:SafeSlim
echo ��ȫ���򣨻�����Ӱ��ʹ�ã�

rem ɾ������Ŀ¼

  rd /q /s "%X%\sources"
::  rd /q /s "%X%\PEMaterial"
  rd /q /s "%X%\Temp"

  rd /q /s "%X%\Users\Default\Favorites"
  rd /q /s "%X%\Users\Default\Links"
  rd /q /s "%X%\Users\Default\Music"
  rd /q /s "%X%\Users\Default\Saved Games"
  rd /q /s "%X%\Users\Default\Videos"
  rd /q /s "%X%\Users\Public\Music"
  rd /q /s "%X%\Users\Public\Videos"
  rd /q /s "%X%\Program Files\Windows NT"
  rd /q /s "%X%\Program Files\Common Files\System\Ole DB\en-US"
  rd /q /s "%X%\Program Files\Common Files\Microsoft Shared\Triedit\en-US"
  rd /q /s "%X%\Program Files\Common Files\System\ado\en-US"
  rd /q /s "%X%\Program Files\Common Files\System\msadc\en-US"

  rd /q /s "%X%\Windows\appcompat"
  rd /q /s "%X%\Windows\apppatch\AppPatch64"
  rd /q /s "%X%\Windows\CbsTemp"
  rd /q /s "%X%\Windows\DiagTrack"
  rd /q /s "%X%\Windows\en-US"
  rd /q /s "%X%\Windows\Help"
  rd /q /s "%X%\Windows\InfusedApps"
  rd /q /s "%X%\Windows\LiveKernelReports"
  rd /q /s "%X%\Windows\Logs"
  rd /q /s "%X%\Windows\Microsoft.Net"
  rd /q /s "%X%\Windows\Program Files (x86)\Microsoft.NET"
  rd /q /s "%X%\Windows\PLA"
  rd /q /s "%X%\Windows\PolicyDefinitions"
  rd /q /s "%X%\Windows\temp"
  rd /q /s "%X%\Windows\tracing"
  rd /q /s "%X%\Windows\media"
  rd /q /s "%X%\Windows\SchCache"
  rd /q /s "%X%\Windows\Vss"
  rd /q /s "%X%\Windows\WaaS"
  rd /q /s "%X%\Windows\Web\Screen"
  rd /q /s "%X%\Windows\INF\en-US"

  rd /q /s "%X%\Windows\resources\Themes\aero\Shell\NormalColor\en-US"

  rd /q /s "%X%\Windows\servicing\Packages"
  rd /q /s "%X%\Windows\servicing\Sessions"
  rd /q /s "%X%\Windows\servicing\SQM"
  rd /q /s "%X%\Windows\servicing\zh-CN"

  rd /q /s "%X%\Windows\WinSxS\Backup"
  rd /q /s "%X%\Windows\WinSxS\Catalogs"
  rd /q /s "%X%\Windows\WinSxS\FileMaps"
  rd /q /s "%X%\Windows\WinSxS\InstallTemp"
  rd /q /s "%X%\Windows\WinSxS\Temp"

  rd /q /s "%X%\Windows\Boot\DVD"
  rd /q /s "%X%\Windows\Boot\PXE\en-US"
  rd /q /s "%X%\Windows\Boot\PXE\bg-BG"
  rd /q /s "%X%\Windows\Boot\PXE\cs-CZ"
  rd /q /s "%X%\Windows\Boot\PXE\da-DK"
  rd /q /s "%X%\Windows\Boot\PXE\de-DE"
  rd /q /s "%X%\Windows\Boot\PXE\el-GR"
  rd /q /s "%X%\Windows\Boot\PXE\en-GB"
  rd /q /s "%X%\Windows\Boot\PXE\es-ES"
  rd /q /s "%X%\Windows\Boot\PXE\es-MX"
  rd /q /s "%X%\Windows\Boot\PXE\et-EE"
  rd /q /s "%X%\Windows\Boot\PXE\fi-FI"
  rd /q /s "%X%\Windows\Boot\PXE\fr-CA"
  rd /q /s "%X%\Windows\Boot\PXE\fr-FR"
  rd /q /s "%X%\Windows\Boot\PXE\hr-HR"
  rd /q /s "%X%\Windows\Boot\PXE\hu-HU"
  rd /q /s "%X%\Windows\Boot\PXE\it-IT"
  rd /q /s "%X%\Windows\Boot\PXE\ja-JP"
  rd /q /s "%X%\Windows\Boot\PXE\ko-KR"
  rd /q /s "%X%\Windows\Boot\PXE\lt-LT"
  rd /q /s "%X%\Windows\Boot\PXE\lv-LV"
  rd /q /s "%X%\Windows\Boot\PXE\nb-NO"
  rd /q /s "%X%\Windows\Boot\PXE\nl-NL"
  rd /q /s "%X%\Windows\Boot\PXE\pl-PL"
  rd /q /s "%X%\Windows\Boot\PXE\pt-BR"
  rd /q /s "%X%\Windows\Boot\PXE\pt-PT"
  rd /q /s "%X%\Windows\Boot\PXE\qps-ploc"
  rd /q /s "%X%\Windows\Boot\PXE\ro-RO"
  rd /q /s "%X%\Windows\Boot\PXE\ru-RU"
  rd /q /s "%X%\Windows\Boot\PXE\sk-SK"
  rd /q /s "%X%\Windows\Boot\PXE\sl-SI"
  rd /q /s "%X%\Windows\Boot\PXE\sr-Latn-RS"
  rd /q /s "%X%\Windows\Boot\PXE\sv-SE"
  rd /q /s "%X%\Windows\Boot\PXE\tr-TR"
  rd /q /s "%X%\Windows\Boot\PXE\uk-UA"
  rd /q /s "%X%\Windows\Boot\PXE\zh-TW"
  rd /q /s "%X%\Windows\Boot\PXE\qps-plocm"
  rd /q /s "%X%\Windows\Boot\EFI"
  rd /q /s "%X%\Windows\Boot\Resources\en-US"
  rd /q /s "%X%\Windows\Boot\Misc"
  rd /q /s "%X%\Windows\Boot\PCAT"

  rd /q /s "%X%\Windows\System32\0409"
  rd /q /s "%X%\Windows\System32\ar-SA"
  rd /q /s "%X%\Windows\System32\bg-BG"
  rd /q /s "%X%\Windows\System32\cs-CZ"
  rd /q /s "%X%\Windows\System32\da-DK"
  rd /q /s "%X%\Windows\System32\de-DE"
  rd /q /s "%X%\Windows\System32\el-GR"
  rd /q /s "%X%\Windows\System32\en-GB"
  rd /q /s "%X%\Windows\System32\es-ES"
  rd /q /s "%X%\Windows\System32\es-MX"
  rd /q /s "%X%\Windows\System32\et-EE"
  rd /q /s "%X%\Windows\System32\fi-FI"
  rd /q /s "%X%\Windows\System32\fr-CA"
  rd /q /s "%X%\Windows\System32\fr-FR"
  rd /q /s "%X%\Windows\System32\he-IL"
  rd /q /s "%X%\Windows\System32\hr-HR"
  rd /q /s "%X%\Windows\System32\hu-HU"
  rd /q /s "%X%\Windows\System32\it-IT"
  rd /q /s "%X%\Windows\System32\ja-JP"
  rd /q /s "%X%\Windows\System32\ko-KR"
  rd /q /s "%X%\Windows\System32\lt-LT"
  rd /q /s "%X%\Windows\System32\lv-LV"
  rd /q /s "%X%\Windows\System32\nb-NO"
  rd /q /s "%X%\Windows\System32\nl-NL"
  rd /q /s "%X%\Windows\System32\pl-PL"
  rd /q /s "%X%\Windows\System32\pt-BR"
  rd /q /s "%X%\Windows\System32\pt-PT"
  rd /q /s "%X%\Windows\System32\ro-RO"
  rd /q /s "%X%\Windows\System32\ru-RU"
  rd /q /s "%X%\Windows\System32\sk-SK"
  rd /q /s "%X%\Windows\System32\sl-SIv"
  rd /q /s "%X%\Windows\System32\sr-Latn-RS"
  rd /q /s "%X%\Windows\System32\sv-SE"
  rd /q /s "%X%\Windows\System32\sl-SI"
  rd /q /s "%X%\Windows\System32\th-TH"
  rd /q /s "%X%\Windows\System32\tr-TR"
  rd /q /s "%X%\Windows\System32\uk-UA"
  rd /q /s "%X%\Windows\System32\zh-TW"
  rd /q /s "%X%\Windows\System32\AdvancedInstallers"
  rd /q /s "%X%\Windows\System32\catroot2"
  rd /q /s "%X%\Windows\System32\DiagSvcs"
  rd /q /s "%X%\Windows\System32\downlevel"
  rd /q /s "%X%\Windows\System32\DriverState"
  rd /q /s "%X%\Windows\System32\en-US"
  rd /q /s "%X%\Windows\System32\GroupPolicy"
  rd /q /s "%X%\Windows\System32\GroupPolicyUsers"
  rd /q /s "%X%\Windows\System32\icsxml"
  rd /q /s "%X%\Windows\System32\installer"
  rd /q /s "%X%\Windows\System32\IME"
  rd /q /s "%X%\Windows\System32\InputMethod"
  rd /q /s "%X%\Windows\System32\LogFiles"
  rd /q /s "%X%\Windows\System32\migration"
  rd /q /s "%X%\Windows\System32\MUI"
  rd /q /s "%X%\Windows\System32\NetworkList"
  rd /q /s "%X%\Windows\System32\oobe"
  rd /q /s "%X%\Windows\System32\ras"
  rd /q /s "%X%\Windows\System32\RasToast"
  rd /q /s "%X%\Windows\System32\Recovery"
  rd /q /s "%X%\Windows\System32\restore"
  rd /q /s "%X%\Windows\System32\setup"
  rd /q /s "%X%\Windows\System32\SMI"
  rd /q /s "%X%\Windows\System32\spp"
  rd /q /s "%X%\Windows\System32\Sysprep"
  rd /q /s "%X%\Windows\System32\WCN"
  rd /q /s "%X%\Windows\System32\winevt"
  rd /q /s "%X%\Windows\System32\WindowsPowerShell"
  rd /q /s "%X%\Windows\System32\CatRoot\{127D0A1D-4EF2-11D1-8608-00C04FC295EE}"
  rd /q /s "%X%\Windows\System32\drivers\en-US"
  rd /q /s "%X%\Windows\System32\drivers\DriverData"
  rd /q /s "%X%\Windows\System32\drivers\UMDF\en-US"
  rd /q /s "%X%\Windows\System32\DriverStore\en-US"
  rd /q /s "%X%\Windows\System32\Dism\en-US"
  rd /q /s "%X%\Windows\System32\Macromed"
  rd /q /s "%X%\Windows\System32\spool\PRINTERS"
  rd /q /s "%X%\Windows\System32\spool\prtprocs"
  rd /q /s "%X%\Windows\System32\spool\SERVERS"
  rd /q /s "%X%\Windows\System32\spool\tools"

  rd /s /q "%X%\Windows\SysWOW64\AdvancedInstallers"
  rd /s /q "%X%\Windows\SysWOW64\config"
  rd /s /q "%X%\Windows\SysWOW64\Dism"
  rd /s /q "%X%\Windows\SysWOW64\downlevel"
  rd /s /q "%X%\Windows\SysWOW64\drivers"
  rd /s /q "%X%\Windows\SysWOW64\DriverStore"
  rd /q /s "%X%\Windows\SysWOW64\en-US"
  rd /s /q "%X%\Windows\SysWOW64\IME"
  rd /s /q "%X%\Windows\SysWOW64\wbem"
  rd /s /q "%X%\Windows\SysWOW64\InputMethod"
  rd /s /q "%X%\Windows\SysWOW64\Macromed"
  rd /s /q "%X%\Windows\SysWOW64\migration"
  rd /s /q "%X%\Windows\SysWOW64\MUI"
  rd /s /q "%X%\Windows\SysWOW64\oobe"
  rd /s /q "%X%\Windows\SysWOW64\SMI"
  rd /s /q "%X%\Windows\SysWOW64\WCN"
  rd /s /q "%X%\Windows\SysWOW64\en-US\Licenses"
  rd /s /q "%X%\Windows\SysWOW64\zh-CN\Licenses"

rem ���� System32 ����ļ�����ȫ����
set list=KBDUS.DLL
set Folder="%X%\Windows\System32"
for /f "delims=" %%i in ('dir /b /a-d %Folder%\KB*.DLL^|findstr /i /v "%list% %~nx0"') do ( del /a /f /q "%Folder%\%%i" )

set list=KD.DLL KDCOM.DLL
set Folder="%X%\Windows\System32"
for /f "delims=" %%i in ('dir /b /a-d %Folder%\KD*.DLL^|findstr /i /v "%list% %~nx0"') do ( del /a /f /q "%Folder%\%%i" )

@REM rem set list=C_10008.NLS C_1252.NLS C_20127.NLS C_437.NLS C_936.NLS locale.nls l_intl.nls normidna.nls C_437.NLS c_950.nls C_1251.NLS C_1252.NLS C_1258.NLS C_20127.NLS
@REM set list=locale.nls l_intl.nls normidna.nls C_1251.NLS C_1252.NLS C_1258.NLS C_20127 C_437.NLS C_850.NLS C_936.NLS C_950.NLS C_1361.NLS C_10001.NLS C_10002.NLS C_10003.NLS C_10008.NLS C_20000.NLS C_20001.NLS C_20002.NLS C_20003.NLS C_20004.NLS C_20005.NLS C_20261.NLS C_20932.NLS C_20936.NLS C_20949.NLS C_21025.NLS C_21027.NLS
@REM rem set list=locale.nls l_intl.nls normidna.nls C_10008.NLS C_1250.NLS C_1251.NLS C_1252.NLS C_1253.NLS C_1254.NLS C_1255.NLS C_1256.NLS C_1257.NLS C_1258.NLS C_20127.NLS C_28591.NLS C_437.NLS C_874.NLS C_932.NLS C_936.NLS C_949.NLS C_950.NLS
@REM set Folder="%X%\Windows\System32"
@REM for /f "delims=" %%i in ('dir /b /a-d %Folder%\*.NLS^|findstr /i /v "%list% %~nx0"') do ( del /a /f /q "%Folder%\%%i" )

Del /A /F /Q "%X%\Windows\System32\6*"

rem ���� SysWOW64 ����ļ�����ȫ����
set list=KBDUS.DLL
set Folder="%X%\Windows\SysWOW64"
for /f "delims=" %%i in ('dir /b /a-d %Folder%\KB*.DLL^|findstr /i /v "%list% %~nx0"') do ( del /a /f /q "%Folder%\%%i" )

rem ɾ������ע����ļ�
Del /A /F /Q "%X%\Windows\System32\config\BBI"
Del /A /F /Q "%X%\Windows\System32\config\BCD-Template"
Del /A /F /Q "%X%\Windows\System32\config\ELAM"
Del /A /F /Q "%X%\Windows\System32\config\COMPONENTS"
Del /A /F /Q "%X%\Windows\System32\config\*.log*"
Del /A /F /Q "%X%\Windows\System32\config\*.blf"
Del /A /F /Q "%X%\Windows\System32\config\*.regtrans-ms"
rd /q /s "%X%\Windows\System32\config\Journal"
rd /q /s "%X%\Windows\System32\config\RegBack"
rd /q /s "%X%\Windows\System32\config\TxR"
rd /q /s "%X%\Windows\System32\config\systemprofile"

rem ����CatRootĿ¼
Del /A /F /Q "%X%\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\*ZH-CN*

rem �������壨�б����������ļ�ɾ����
set list=marlett.ttf micross.ttf msyh.ttc segmdl2.ttf simsun.ttc svgasys.fon tahoma.ttf vga936.fon vgafix.fon vgaoem.fon vgasys.fon segoeuib.ttf
set Folder="%X%\Windows\Fonts"
for /f "delims=" %%i in ('dir /b /a-d %Folder%\*.*^|findstr /i /v "%list% %~nx0"') do ( del /a /f /q "%Folder%\%%i" )
del /a /f /q "%X%\Windows\cvgafix.fon"
del /a /f /q "%X%\Windows\cvgasys.fon"
del /a /f /q "%X%\Windows\hvgafix.fon"
del /a /f /q "%X%\Windows\hvgasys.fon"
del /a /f /q "%X%\Windows\jvgafix.fon"
del /a /f /q "%X%\Windows\jvgasys.fon"
set list=msyhn_boot.ttf msyh_boot.ttf segoen_slboot.ttf segoe_slboot.ttf
set Folder="%X%\Windows\Boot\Fonts"
for /f "delims=" %%i in ('dir /b /a-d %Folder%\*.*^|findstr /i /v "%list% %~nx0"') do ( del /a /f /q "%Folder%\%%i" )

rem ����boot�ļ�
Del /A /F /Q "%X%\Windows\boot\BootDebuggerFiles.ini"
set list=bootmgr.exe
set Folder="%X%\Windows\Boot\PXE"
for /f "delims=" %%i in ('dir /b /a-d %Folder%\*.*^|findstr /i /v "%list% %~nx0"') do ( del /a /f /q "%Folder%\%%i" )

set list=bootmgr.exe.mui
set Folder="%X%\Windows\Boot\PXE\zh-CN\"
for /f "delims=" %%i in ('dir /b /a-d %Folder%\*.*^|findstr /i /v "%list% %~nx0"') do ( del /a /f /q "%Folder%\%%i" )

rem ɾ�� Ӱ��ػ��ٶ��ļ�
Del /A /F /Q "%X%\Windows\System32\authui.dll"
Del /A /F /Q "%X%\Windows\System32\zh-CN\authui.dll.mui"
Del /A /F /Q "%X%\Windows\SystemResources\authui.dll.num"

Del /A /F /Q "%X%\Windows\System32\imapi2.dll"
Del /A /F /Q "%X%\Windows\System32\zh-CN\imapi2.dll.mui"
Del /A /F /Q "%X%\Windows\SystemResources\imapi2.dll.num"

rem ����servicing�ļ�
::Del /A /F /Q "%X%\Windows\servicing\*.*"

rem ɾ�� Speeh��TTS���棩
rd /s /q "%X%\Windows\Speech"
rd /s /q "%X%\Windows\System32\Speech"
Del /A /F /Q "%X%\Windows\System32\SRH.dll"
Del /A /F /Q "%X%\Windows\System32\srhelper.dll"
Del /A /F /Q "%X%\Windows\System32\srms*.dat"

Del /A /F /Q "%X%\Windows\System32\TtlsAuth.dll"
Del /A /F /Q "%X%\Windows\System32\zh-CN\TtlsAuth.dll.mui"
Del /A /F /Q "%X%\Windows\System32\TtlsCfg.dll"
Del /A /F /Q "%X%\Windows\System32\zh-CN\TtlsCfg.dll.mui"

rem ɾ�� ��Ļ�����ˡ��Ŵ�
Del /A /F /Q "%X%\Windows\System32\Narrator*"
Del /A /F /Q "%X%\Windows\System32\zh-CN\Narrator*"
Del /A /F /Q "%X%\Windows\System32\Magnify*"
Del /A /F /Q "%X%\Windows\System32\zh-CN\Magnify*"

rem ɾ�� �ڴ���ϲ���
::Del /A /F /Q "%X%\Windows\System32\MdSched*"
::Del /A /F /Q "%X%\Windows\System32\zh-CN\MdSched*"

rem ɾ��ϵͳ��ԭ
Del /A /F /Q "%X%\Windows\System32\rstrui*"
Del /A /F /Q "%X%\Windows\System32\zh-CN\rstrui*"

rem ɾ�� ������֤����
Del /A /F /Q "%X%\Windows\System32\verifiergui*"
Del /A /F /Q "%X%\Windows\System32\zh-CN\verifiergui*"

rem ɾ�� Windows ������񲶻���
Del /A /F /Q "%X%\Windows\System32\wdscapture*"
Del /A /F /Q "%X%\Windows\System32\zh-CN\wdscapture*"

rem ɾ�� ���ѻָ�
Del /A /F /Q "%X%\Windows\System32\bmrui*"
Del /A /F /Q "%X%\Windows\System32\zh-CN\bmrui*"

rem ɾ�� �޸�����
Del /A /F /Q "%X%\Windows\System32\recdisc*"
Del /A /F /Q "%X%\Windows\System32\zh-CN\recdisc*"

rem ɾ�� MSI
::Del /A /F /Q "%X%\Windows\System32\msi.dll"
::Del /A /F /Q "%X%\Windows\System32\zh-CN\msi.dll.mui"

rem ���� WMI
rd /q /s "%X%\Windows\System32\wbem\AutoRecover"
rd /q /s "%X%\Windows\System32\wbem\en-US"
rd /q /s "%X%\Windows\System32\wbem\Logs"
rd /q /s "%X%\Windows\System32\wbem\tmf"

rem ע�⣺��װԭ��Win7��Ҫɾ�� wbemprox.dll������ᱨ�ڴ����
rem ���ǣ�ɾ����ϵͳ����CPU���ڴ潫�޷���ʾ����

@REM set list=cimwin32.dll esscli.dll fastprox.dll repdrvfs.dll Repository texttable.xsl wbemcore.dll wbemess.dll wbemsvc.dll WMIC.exe WmiPrvSD.dll WmiPrvSE.exe WMIsvc.dll wmiutils.dll xsl-mappings.xml wbemprox.dll
@REM set Folder="%X%\Windows\System32\wbem"
@REM for /f "delims=" %%i in ('dir /b /a-d %Folder%\*.*^|findstr /i /v "%list% %~nx0"') do ( del /a /f /q "%Folder%\%%i" )

@REM set list=cimwin32.dll.mui wbemcore.dll.mui WMIC.exe.mui WMIsvc.dll.mui wmiutils.dll.mui
@REM set Folder="%X%\Windows\System32\wbem\zh-CN\"
@REM for /f "delims=" %%i in ('dir /b /a-d %Folder%\*.*^|findstr /i /v "%list% %~nx0"') do ( del /a /f /q "%Folder%\%%i" )

rem ����PENetwork
::Move "%X%\Program Files\PENetwork_x64" "%X%\Program Files\PENetwork"
for %%f in (
  EULA-AutoIt3.txt
  License.txt
  PENetwork_cs-CZ.lng
  PENetwork_de-DE.lng
  PENetwork_en-US.lng
  PENetwork_es-ES.lng
  PENetwork_es-Hn.lng
  PENetwork_fr-FR.lng
  PENetwork_hu-HU.lng
  PENetwork_it-IT.lng
  PENetwork_ja-JP.lng
  PENetwork_ko-KR.lng
  PENetwork_pl-PL.lng
  PENetwork_pt-BR.lng
  PENetwork_pt-PT.lng
  PENetwork_ru-RU.lng
  PENetwork_sv-SE.lng
  PENetwork_tr-TR.lng
  PENetwork_zh-TW.lng
) do (
  Del /A /F /Q "%X%\Program Files\PENetwork\%%f"
)

rem ����7-ZIP
Del /A /F /Q "%X%\Program Files\7-Zip\7-zip.chm"
Del /A /F /Q "%X%\Program Files\7-Zip\History.txt"
Del /A /F /Q "%X%\Program Files\7-Zip\History.txt"
Del /A /F /Q "%X%\Program Files\7-Zip\License.txt"
Del /A /F /Q "%X%\Program Files\7-Zip\readme.txt"
Del /A /F /Q "%X%\Program Files\7-Zip\Uninstall.exe"

set list=zh-cn.txt
set Folder="%X%\Program Files\7-Zip\Lang"
for /f "delims=" %%i in ('dir /b /a-d %Folder%\*.*^|findstr /i /v "%list% %~nx0"') do ( del /a /f /q "%Folder%\%%i" )

rem ���� StartIsBack
::rd /q /s "%X%\Program Files\StartIsBack\Orbs"
::Del /A /F /Q "%X%\Program Files\StartIsBack\StartIsBackCfg.exe"
Del /A /F /Q "%X%\Program Files\StartIsBack\startscreen.exe"
Del /A /F /Q "%X%\Program Files\StartIsBack\UpdateCheck.exe"
Del /A /F /Q "%X%\Program Files\StartIsBack\StartIsBackARM64.dll"

rem ���� Windows �ļ�
Del /A /F /Q "%X%\setup.exe"
Del /A /F /Q "%X%\Windows\hh.exe"
Del /A /F /Q "%X%\Windows\zh-CN\hh.exe.mui"
Del /A /F /Q "%X%\Windows\notepad.exe"
Del /A /F /Q "%X%\Windows\zh-CN\notepad.exe.mui"

rem ����NVIDIA����
for /f %%i in ('dir /ad /b %X%\Windows\System32\DriverStore\FileRepository\nv_*') do (rd /s /q "%X%\Windows\System32\DriverStore\FileRepository\%%i")

goto :eof

rem ==================================================================
:NormlSlim
echo ��ͨ���򣨸���wimboo�ļ��б�
REM ���ð�ȫ����
call :SafeSlim

rem ɾ��IE���������������
rd /q /s "%X%\Program Files\Internet Explorer"
rd /q /s "%X%\Program Files (x86)\Internet Explorer"
Del /A /F /Q "%X%\Windows\System32\IESettingSync.exe"
Del /A /F /Q "%X%\Windows\System32\iemigplugin.dll"

rem ɾ�� Windows Photo Viewer �������ã�
rd /q /s "%X%\Program Files\Windows Photo Viewer"
rd /q /s "%X%\Windows\System32\spool"

rem ���� SysWOW64 �ļ�
rem ע�⣺������ ����֮�����ڴ����ϵͳ���Դ򲻿������ֵ��ļ��򲻿� ��Ϊ SysWOW64 Ŀ¼ȱ���ļ�����������

rem ���б����������ļ�ɾ����
REM set list=aclui.dll actxprxy.dll advapi32.dll atl.dll atl100.dll atl71.dll attrib.exe AudioSes.dll authz.dll avicap32.dll avifil32.dll avrt.dll bcrypt.dll bcryptprimitives.dll cabinet.dll cfgmgr32.dll chcp.com clb.dll cmd.exe cmdext.dll combase.dll comdlg32.dll coml2.dll credui.dll crtdll.dll crypt32.dll cryptbase.dll cryptdll.dll cryptsp.dll d3d10warp.dll d3d11.dll d3d9.dll DataExchange.dll davhlpr.dll dbgcore.dll dbghelp.dll dciman32.dll dcomp.dll devenum.dll devobj.dll dhcpcsvc.dll dhcpcsvc6.dll dinput.dll dinput8.dll directmanipulation.dll dllhost.exe dnsapi.dll dpapi.dll dsound.dll dui70.dll duser.dll dwmapi.dll DWrite.dll dxgi.dll DXCORE.DLL edputil.dll en-US ExplorerFrame.dll find.exe FirewallAPI.dll fltLib.dll fontsub.dll fwbase.dll FWPUCLNT.DLL gdi32.dll gdi32full.dll glu32.dll hhctrl.ocx hid.dll iertutil.dll imagehlp.dll imageres.dll imm32.dll IPHLPAPI.DLL jscript.dll KBDUS.DLL kernel.appcore.dll kernel32.dll KernelBase.dll ksuser.dll mfc42.dll mlang.dll MMDevAPI.dll mpr.dll msacm32.dll msacm32.drv msasn1.dll mscms.dll msctf.dll msctfuimanager.dll msi.dll msimg32.dll msIso.dll msls31.dll msv1_0.dll msvcp100.dll msvcp110.dll msvcp120.dll msvcp140.dll msvcp60.dll msvcp71.dll msvcp_win.dll msvcr100.dll msvcr110.dll msvcr120.dll msvcr71.dll msvcrt.dll msvfw32.dll mswsock.dll msxml3.dll msxml3r.dll ncrypt.dll ncryptsslp.dll netapi32.dll netutils.dll nsi.dll ntasn1.dll ntdll.dll ntdsapi.dll NtlmShared.dll ntmarta.dll odbc32.dll ole32.dll oleacc.dll oleaccrc.dll oleaut32.dll oledlg.dll olepro32.dll opengl32.dll pdh.dll powrprof.dll profapi.dll propsys.dll psapi.dll quartz.dll rasapi32.dll rasman.dll reg.exe regedit.exe regsvr32.exe riched20.dll riched32.dll rpcrt4.dll rsaenh.dll rundll32.exe samcli.dll schannel.dll sechost.dll secur32.dll SensApi.dll setupapi.dll SHCore.dll shell32.dll shellstyle.dll shfolder.dll shlwapi.dll spfileq.dll spinf.dll srvcli.dll sspicli.dll stdole2.tlb stdole32.tlb StructuredQuery.dll sxs.dll ucrtbase.dll UIAnimation.dll UIAutomationCore.dll ulib.dll urlmon.dll user32.dll userenv.dll usp10.dll uxtheme.dll umpdc.dll vcomp100.dll vcruntime140.dll version.dll wdmaud.drv wevtapi.dll wimgapi.dll win32u.dll winbrand.dll windows.storage.dll WindowsCodecs.dll winhttp.dll wininet.dll winmm.dll winmmbase.dll winnsi.dll winspool.drv wintrust.dll WinTypes.dll winsta.dll wkscli.dll Wldap32.dll ws2_32.dll wsock32.dll wtsapi32.dll xmllite.dll TextShaping.dll msftedit.dll wldp.dll mfc42u.dll wdscore.dll msdmo.dll wow32.dll wowreg32.exe Windows.FileExplorer.Common.dll
REM set Folder="%X%\Windows\SysWOW64"
REM for /f "delims=" %%i in ('dir /b /a-d %Folder%\*.*^|findstr /i /v "%list% %~nx0"') do ( del /a /f /q "%Folder%\%%i" )

REM rem ���� SysWOW64\zh-CN �ļ����б����������ļ�ɾ����
REM set list=advpack.dll.mui avicap32.dll.mui avifil32.DLL.mui comdlg32.dll.mui comctl32.dll.mui dsreg.dll.mui FWPUCLNT.DLL.mui gpapi.dll.mui IEAdvpack.dll.mui iernonce.dll.mui iertutil.dll.mui iesetup.dll.mui ieui.dll.mui jscript9.dll.mui msvfw32.dll.mui ntdll.dll.mui occache.dll.mui reg.exe.mui SC.EXE.mui shell32.dll.mui svchost.exe.mui sxs.dll.mui urlmon.dll.mui user32.dll.mui wimgapi.dll.mui Wldap32.dll.mui msftedit.dll.mui wldp.dll.mui propsys.dll.mui windows.storage.dll.mui wdscore.dll.mui mfc42u.dll.mui msdmo.dll.mui
REM set Folder="%X%\Windows\SysWOW64\zh-CN"
REM for /f "delims=" %%i in ('dir /b /a-d %Folder%\*.*^|findstr /i /v "%list% %~nx0"') do ( del /a /f /q "%Folder%\%%i" )


for %%f in (
  adsldp.dll
  adsldpc.dll
  apphelp.dll
  asycfilt.dll
  atlthunk.dll
  BCP47Langs.dll
  BCP47mrm.dll
  browcli.dll
  chs_singlechar_pinyin.dat
  clbcatq.dll
  clip.exe
  comctl32.dll
  console.dll
  ConsoleLogon.dll
  CoreMessaging.dll
  CoreUIComponents.dll
  CredentialUIBroker.exe
  CredProv2faHelper.dll
  CredProvDataModel.dll
  credprovhost.dll
  credprovs.dll
  credprovslegacy.dll
  cscapi.dll
  ctfmon.exe
  d2d1.dll
  D3D12.dll
  dbgeng.dll
  DbgModel.dll
  ddraw.dll
  devicengccredprov.dll
  devrtl.dll
  dfscli.dll
  diagnosticdataquery.dll
  difxapi.dll
  dlnashext.dll
  driverquery.exe
  dsrole.dll
  dtdump.exe
  dusmapi.dll
  eventcls.dll
  expand.exe
  fdWCN.dll
  FlightSettings.dll
  fveapi.dll
  fveapibase.dll
  fvecerts.dll
  fwpolicyiomgr.dll
  GdiPlus.dll
  globinputhost.dll
  gpapi.dll
  hlink.dll
  ieframe.dll
  InfDefaultInstall.exe
  input.dll
  InputHost.dll
  InputSwitch.dll
  KerbClientShared.dll
  KeyCredMgr.dll
  LanguageOverlayUtil.dll
  linkinfo.dll
  logoncli.dll
  lz32.dll
  mfperfhelper.dll
  mibincodec.dll
  mimofcodec.dll
  mmres.dll
  msctfime.ime
  MsCtfMonitor.dll
  msctfp.dll
  msdelta.dll
  msiexec.exe
  msihnd.dll
  msiltcfg.dll
  msimsg.dll
  msisip.dll
  mskeyprotect.dll
  msutb.dll
  msvbvm60.dll
  msvcirt.dll
  msvcp110_win.dll
  msvcp120_clr0400.dll
  msvcp140_clr0400.dll
  msvcr100_clr0400.dll
  msvcr120_clr0400.dll
  msvcrt20.dll
  msvcrt40.dll
  MSWB7.dll
  msxml6.dll
  msxml6r.dll
  MTF.dll
  MuiUnattend.exe
  ncryptprov.dll
  ndadmin.exe
  net.exe
  net1.exe
  NetDriverInstall.dll
  netmsg.dll
  netprofm.dll
  NetSetupEngine.dll
  newdev.dll
  newdev.exe
  ngclocal.dll
  NOISE.DAT
  normaliz.dll
  npmproxy.dll
  ntlanman.dll
  ntshrui.dll
  OnDemandConnRouteHelper.dll
  OneCoreCommonProxyStub.dll
  OneCoreUAPCommonProxyStub.dll
  PkgMgr.exe
  policymanager.dll
  poqexec.exe
  rasadhlp.dll
  rdrleakdiag.exe
  regedt32.exe
  rmclient.dll
  rtutils.dll
  samlib.dll
  slc.dll
  SSShim.dll
  svchost.exe
  sxsstore.dll
  sxstrace.exe
  syssetup.dll
  TextInputFramework.dll
  TextInputMethodFormatter.dll
  thumbcache.dll
  TrustedSignalCredProv.dll
  twinapi.appcore.dll
  twinapi.dll
  tzres.dll
  ucrtbase_clr0400.dll
  uReFSv1.dll
  vbscript.dll
  vssapi.dll
  vsstrace.dll
  WcnApi.dll
  wcnwiz.dll
  webio.dll
  win32k.sys
  win32kfull.sys
  Windows.Globalization.dll
  Windows.Internal.UI.Logon.ProxyStub.dll
  Windows.Networking.HostName.dll
  Windows.UI.Core.TextInput.dll
  Windows.UI.CredDialogController.dll
  Windows.Web.dll
  windowsperformancerecordercontrol.dll
  winhttpcom.dll
  Winlangdb.dll
  winnlsres.dll
  wmi.dll
  wmiclnt.dll
  WordBreakers.dll
) do (
  Del /A /F /Q "%X%\Windows\SysWOW64\%%f"
  Del /A /F /Q "%X%\Windows\SysWOW64\zh-CN\%%f.mui"
)

rem ɾ�� ���࿪ʼ�˵���Ŀ
rd /q /s "%X%\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
md "%X%\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
rd /q /s "%X%\ProgramData\Microsoft\Windows\Start Menu\Programs"
md "%X%\ProgramData\Microsoft\Windows\Start Menu\Programs"

rem ɾ�� ���������Ŀ
rd /q /s "%X%\Users\Default\Desktop"
md "%X%\Users\Default\Desktop"
rd /q /s "%X%\Users\Public\Desktop"
md "%X%\Users\Public\Desktop"

rem ɾ��desktop.ini
Del /A /F /Q  "%X%\Program Files (x86)\desktop.ini"

rem ���� windows.StateRepository ������Ӱ���½��ļ���
Del /A /F /Q  "%X%\Windows\System32\Windows.StateRepository.dll"
Del /A /F /Q  "%X%\Windows\System32\Windows.StateRepositoryBroker.dll"
Del /A /F /Q  "%X%\Windows\System32\Windows.StateRepositoryClient.dll"
Del /A /F /Q  "%X%\Windows\System32\zh-CN\Windows.StateRepository.dll.mui"

rem ɾ�� �Ҽ����͵� ѹ��(zipped)�ļ���
Del /A /F /Q  "%X%\Users\Default\AppData\Roaming\Microsoft\Windows\SendTo\ѹ��(zipped)�ļ���"

rem ɾ�� ����cpl�ļ�
Del /A /F /Q "%X%\Windows\System32\Firewall.cpl"
Del /A /F /Q "%X%\Windows\System32\zh-CN\Firewall.cpl*"
Del /A /F /Q "%X%\Windows\System32\intl.cpl"
Del /A /F /Q "%X%\Windows\System32\zh-CN\intl.cpl*"

rem ���� WinSxS Ŀ¼
Del /A /F /Q "%X%\Windows\WinSxS\migration.xml"

REM ɾ�� Windows �Զ����ļ�
Del /A /F /Q %X%\Windows\bfsvc.exe
Del /A /F /Q %X%\Windows\system.ini
Del /A /F /Q %X%\Windows\win.ini

REM ɾ�� System32 �Զ����ļ�
Del /A /F /Q %X%\Windows\System32\hiderun.exe
Del /A /F /Q %X%\Windows\System32\MBR2GPT.EXE
Del /A /F /Q %X%\Windows\System32\OskTray.exe
Del /A /F /Q %X%\Windows\System32\startnet.cmd
Del /A /F /Q %X%\Windows\System32\InitializeNetwork.cmd
Del /A /F /Q %X%\Windows\System32\IME_Cmd.cmd
Del /A /F /Q %X%\Windows\System32\@VpnToastIcon.png
Del /A /F /Q %X%\Windows\System32\setup.bmp

rem ����System32����ļ�
for %%f in (
  xwizard.exe
  xpsrchvw.exe
  wusa.exe
  wuapp.exe
  wsmprovhost.exe
  WSManHTTPConfig.exe
  write.exe
  winrshost.exe
  winrs.exe
  wiaacmgr.exe
  whoami.exe
  where.exe
  wextract.exe
  wermgr.exe
  WerFaultSecure.exe
  WerFault.exe
  wecutil.exe
  waitfor.exe
  w32tm.exe
  vssadmin.exe
  vmnetdhcp.exe
  vmnat.exe
  verifier.exe
  verclsid.exe
  Utilman.exe
  UserAccountControlSettings.exe
  user.exe
  upnpcont.exe
  unregmp2.exe
  unlodctr.exe
  tzutil.exe
  typeperf.exe
  TsWpfWrp.exe
  TSTheme.exe
  TRACERT.EXE
  tracerpt.exe
  TpmInit.exe
  timeout.exe
  tcmsetup.exe
  taskkill.exe
  taskeng.exe
  SystemPropertiesProtection.exe
  SystemPropertiesDataExecutionPrevention.exe
  systeminfo.exe
  syskey.exe
  SyncHost.exe
  srdelayed.exe
  shrpubw.exe
  setx.exe
  setupugc.exe
  setupSNK.exe
  setup16.exe
  SetIEInstalledDate.exe
  sethc.exe
  secinit.exe
  SearchProtocolHost.exe
  SearchIndexer.exe
  SearchFilterHost.exe
  sdiagnhost.exe
  sdchange.exe
  sdbinst.exe
  schtasks.exe
  sbunattend.exe
  runonce.exe
  RunLegacyCPLElevated.exe
  runas.exe
  rrinstaller.exe
  RpcPing.exe
  Robocopy.exe
  RmClient.exe
  RMActivate_ssp_isv.exe
  RMActivate_ssp.exe
  RMActivate_isv.exe
  RMActivate.exe
  resmon.exe
  relog.exe
  rekeywiz.exe
  RegisterIEPKEYs.exe
  ReAgentc.exe
  rdrleakdiag.exe
  PushPrinterConnections.exe
  psr.exe
  proquota.exe
  printui.exe
  print.exe
  prevhost.exe
  PresentationHost.exe
  powercfg.exe
  poqexec.exe
  PkgMgr.exe
  perfmon.exe
  perfhost.exe
  pcaui.exe
  PATHPING.EXE
  OptionalFeatures.exe
  openfiles.exe
  odbcconf.exe
  odbcad32.exe
  ocsetup.exe
  ntprint.exe
  ntkrnlpa.exe
  nslookup.exe
  NAPSTAT.EXE
  mtstocom.exe
  mstsc.exe
  msra.exe
  msinfo32.exe
  mshta.exe
  zh-CN\mshta.exe.mui
  msfeedssync.exe
  msdt.exe
  MRINFO.EXE
  mobsync.exe
  MigAutoPlay.exe
  mfpmp.exe
  Magnify.exe
  logman.exe
  logagent.exe
  lodctr.exe
  LocationNotifications.exe
  label.exe
  ktmutil.exe
  isoburn.exe
  iscsicpl.exe
  iscsicli.exe
  instnm.exe
  iexpress.exe
  ieUnatt.exe
  icsunattend.exe
  icardagt.exe
  hh.exe
  help.exe
  grpconv.exe
  gpupdate.exe
  gpscript.exe
  gpresult.exe
  getmac.exe
  ftp.exe
  forfiles.exe
  fontview.exe
  fixmapi.exe
  finger.exe
  fc.exe
  extrac32.exe
  explorer.exe
  expand.exe
  eventvwr.exe
  eventcreate.exe
  eudcedit.exe
  esentutl.exe
  EhStorAuthn.exe
  efsui.exe
  dxdiag.exe
  DWWIN.EXE
  dvdupgrd.exe
  dvdplay.exe
  driverquery.exe
  dpnsvr.exe
  dplaysvr.exe
  DpiScaling.exe
  dpapimig.exe
  DisplaySwitch.exe
  diskperf.exe
  diantz.exe
  dfrgui.exe
  DevicePairingWizard.exe
  ddodiag.exe
  dcomcnfg.exe
  dccw.exe
  cttunesvr.exe
  cttune.exe
  credwiz.exe
  ComputerDefaults.exe
  compact.exe
  comp.exe
  colorcpl.exe
  cmmon32.exe
  cmdl32.exe
  cmdkey.exe
  cliconfg.exe
  cleanmgr.exe
  cipher.exe
  charmap.exe
  certutil.exe
  certreq.exe
  CertEnrollCtrl.exe
  bthudtask.exe
  bootcfg.exe
  bitsadmin.exe
  autofmt.exe
  autoconv.exe
  autochk.exe
  auditpol.exe
  atieah32.exe
  AtBroker.exe
  at.exe
  amdocl_ld32.exe
  amdocl_as32.exe
  AdapterTroubleshooter.exe
  winpe.jpg
  winre.jpg
) do (
  Del /A /F /Q "%X%\Windows\System32\%%f"
  Del /A /F /Q "%X%\Windows\System32\zh-CN\%%f.mui"
  Del /A /F /Q "%X%\Windows\SystemResources\%%f.num"
)

rem ���� System32 ���dll
for %%f in (
  atmlib.dll 
  basecsp.dll 
  BdeHdCfgLib.dll 
  bderepair.dll 
  bdesvc.dll 
  bootstr.dll 
  catsrvps.dll 
  colorcnv.dll 
  cryptdlg.dll 
  cryptext.dll 
  devdispitemprovider.dll 
  devicedisplaystatusmanager.dll 
  devicesetupstatusprovider.dll 
  devinv.dll 
  Dot3Conn.dll 
  dot3gpui.dll 
  dot3hc.dll 
  dot3ui.dll 
  dpx.dll 
  dtsh.dll 
  efssvc.dll 
  fhsrchapi.dll 
  fhsrchph.dll 
  fontext.dll 
  fveapibase.dll 
  fveskybackup.dll 
  fvewiz.dll 
  icardres.dll 
  ifsutilx.dll 
  inetcomm.dll 
  InkEd.dll 
  input64.dll 
  iscsicpl.dll 
  iscsidsc.dll 
  iscsied.dll 
  iscsiexe.dll 
  iscsilog.dll 
  iscsium.dll 
  iscsiwmi.dll 
  iscsiwmiv2.dll 
  itircl.dll 
  itss.dll 
  jscript9diag.dll 
  LockingHooks.dll 
  lpksetupproxyserv.dll 
  mcicda.dll 
  mciseq.dll 
  mciwave.dll 
  mfc100.dll 
  mfc100chs.dll 
  mfc100cht.dll 
  mfc100deu.dll 
  mfc100enu.dll 
  mfc100esn.dll 
  mfc100fra.dll 
  mfc100ita.dll 
  mfc100jpn.dll 
  mfc100kor.dll 
  mfc100rus.dll 
  mfc100u.dll 
  mfc110.dll 
  mfc110chs.dll 
  mfc110cht.dll 
  mfc110deu.dll 
  mfc110enu.dll 
  mfc110esn.dll 
  mfc110fra.dll 
  mfc110ita.dll 
  mfc110jpn.dll 
  mfc110kor.dll 
  mfc110rus.dll 
  mfc110u.dll 
  mfc120.dll 
  mfc120chs.dll 
  mfc120cht.dll 
  mfc120deu.dll 
  mfc120enu.dll 
  mfc120esn.dll 
  mfc120fra.dll 
  mfc120ita.dll 
  mfc120jpn.dll 
  mfc120kor.dll 
  mfc120rus.dll 
  mfc120u.dll 
  mfcm100.dll 
  mfcm100u.dll 
  mfcm110.dll 
  mfcm110u.dll 
  mfcm120.dll 
  mfcm120u.dll 
  mfcsubs.dll 
  modemui.dll 
  MSDartCmn.dll 
  msdrm.dll 
  msicofire.dll 
  msisip.dll 
  msiwer.dll 
  msobjs.dll 
  msscntrs.dll 
  msshooks.dll 
  mssitlb.dll 
  mssph.dll 
  mssphtb.dll 
  mssrch.dll 
  mssvp.dll 
  mstextprediction.dll 
  mstscax.dll 
  NaturalLanguage6.dll 
  nlahc.dll 
  nlmgp.dll 
  nlmproxy.dll 
  nlmsprep.dll 
  pdhui.dll 
  PlaySndSrv.dll 
  powercpl.dll 
  prm0009.dll 
  provcore.dll 
  Query.dll 
  raschapext.dll 
  rascustom.dll 
  rastlsext.dll 
  ReAgent.dll 
  RMapi.dll 
  serwvdrv.dll 
  setbcdlocale.dll 
  sfc_os.dll 
  simauth.dll 
  simcfg.dll 
  smartcardcredentialprovider.dll 
  smartcardsimulator.dll 
  smsdeviceaccessrevocation.dll 
  smsrouter.dll 
  stclient.dll 
  storagewmi_passthru.dll 
  Tabbtn.dll 
  TabbtnEx.dll 
  TabSvc.dll 
  tpmcompc.dll 
  TpmTasks.dll 
  tpmvsc.dll 
  tquery.dll 
  tsbyuv.dll 
  UIAutomationCoreRes.dll 
  uicom.dll 
  umdmxfrm.dll 
  umpowmi.dll 
  unimdmat.dll 
  uniplat.dll 
  usbceip.dll 
  usbperf.dll 
  usbui.dll 
  UserLanguageProfileCallback.dll 
  UserLanguagesCpl.dll 
  ustprov.dll 
  vaultcli.dll 
  vcamp110.dll 
  vcamp120.dll 
  vccorlib110.dll 
  vccorlib120.dll 
  verifier.dll 
  WcnEapAuthProxy.dll 
  WcnEapPeerProxy.dll 
  WcnNetsh.dll 
  Wdfres.dll 
  webcheck.dll 
  WEBSOCKET.DLL 
  wecapi.dll 
  Windows.Shell.Search.UriHandler.dll 
  Windows.UI.Input.Inking.dll 
  wisp.dll 
  wmiprop.dll 
  workerdd.dll 
  wshqos.dll 
  wuapi.dll 
  wuaueng.dll 
  xmlfilter.dll 
) do (
  Del /A /F /Q "%X%\Windows\System32\%%f"
  Del /A /F /Q "%X%\Windows\System32\zh-CN\%%f.mui"
  Del /A /F /Q "%X%\Windows\SystemResources\%%f.num"
)

rem ���� System32 ���dll������ɾ����ͨ���Ա�PE�ó���(��һ�ζԱ�)
for %%f in (
  WMADMOE.DLL
  WMADMOD.DLL
  StorageUsage.dll
  Windows.Internal.Shell.Broker.dll
  TDLMigration.dll
  StartTileData.dll
  tier2punctuations.dll
  Chakrathunk.dll
  Chakradiag.dll
  Chakra.dll
  XAudio2_9.dll
  SpatialAudioLicenseSrv.exe
  remoteaudioendpoint.dll
  audioresourceregistrar.dll
  wersvc.dll
  tzres.dll
  winquic.dll
  microsoft-windows-kernel-processor-power-events.dll
  winresume.exe
  winresume.efi
  mf3216.dll
  mapistub.dll
  mapi32.dll
  IndexedDbLegacy.dll
  webplatstorageserver.dll
  werui.dll
  Faultrep.dll
  SetWG.exe
  l3codeca.acm
  dlnashext.dll
  WMASF.DLL
  fvenotify.exe
  OpcServices.dll
  AppxPackaging.dll
  fmapi.dll
  storagewmi.dll
  delegatorprovider.dll
  WiFiConfigSP.dll
  wfdprov.dll
  dafWfdProvider.dll
  dafWCN.dll
  wpx.dll
  wdsutil.dll
  upgWow_bulk.xml
  upgradeagent.xml
  upgradeagent.dll
  upgrade_frmwrk.xml
  upgrade_data.xml
  upgrade_comp.xml
  upgrade_bulk.xml
  uninstall_data.xml
  uninstall.xml
  unbcl.dll
  SFPATWT.inf
  SFPATWB.inf
  SFPATW8.inf
  SFPATW7.inf
  SFPATRS1.inf
  SFPAT.inf
  sflistwt.woa.dat
  SFLISTWT.dat
  sflistwb.woa.dat
  SFLISTWB.dat
  sflistw8.woa.dat
  SFLISTW8.dat
  SFLISTW7.dat
  SFLISTRS1.dat
  SFLCID.dat
  SFCN.dat
  setupplatform.exe
  setupplatform.dll
  setupplatform.cfg
  ReserveManager.dll
  pnppropmig.dll
  osfilter.inf
  oscomps.xml
  oscomps.woa.xml
  offline.xml
  MXEAgent.dll
  migsys.dll
  migstore.dll
  migres.dll
  migisol.dll
  mighost.exe
  migcore.dll
  migapp.xml
  hwexclude.txt
  hwcompat.txt
  hwcompat.dll
  csiagent.dll
  cmi2migxml.dll
  pngfilt.dll
  msoert2.dll
  msimtf.dll
  mshtmled.dll
  mlang.dat
  INETRES.dll
  imgutil.dll
  d3d11on12.dll
  d3d10core.dll
  d3d10.dll
  XAudio2_8.dll
  Windows.Devices.Midi.dll
  CompPkgSrv.exe
  DetailedReading-Default.xml
  tbs.dll
  repair-bde.exe
  manage-bde.exe
  fverecoverux.dll
  wdstptc.dll
  wdsmcast.exe
  WdsImage.dll
  WdsDiag.dll
  wdscsl.dll
  wdsclient.exe
  wbengine.exe
  wbadmin.exe
  VSSVC.exe
  sysreset.exe
  sxproxy.dll
  srcore.dll
  srclient.dll
  spp.dll
  ResetPluginHost.exe
  resetengmig.dll
  ResetEngInterfaces.exe
  ResetEngine.exe
  ResetEngine.dll
  reseteng.dll
  ReInfo.dll
  hbaapi.dll
  CloudRecSvc.exe
  CloudRecApi.dll
  bootux.dll
  BootRec.exe
  BootMenuUX.dll
  blbres.dll
  blb_ps.dll
  TpmCoreProvisioning.dll
  TpmCertResources.dll
  tcpmib.dll
  scrobj.dll
  Register-CimProvider.exe
  psmodulediscoveryprovider.mof
  PSModuleDiscoveryProvider.dll
  prvdmofcomp.dll
  provthrd.dll
  miutils.dll
  mimofcodec.dll
  mibincodec.dll
  mi.dll
  framedyn.dll
  dskquota.dll
  bcdprov.dll
  prfh0804.dat
  prfc0804.dat
  prfi0804.dat
  prfd0804.dat
  msvcp140_clr0400.dll
  msvcr100_clr0400.dll
  msvcr120_clr0400.dll
  msvcp120_clr0400.dll
  WfHC.dll
  p2pnetsh.dll
  WorkFoldersShell.dll
  wkspbrokerAx.dll
  psisrndr.ax
  psisdecd.dll
  MSDvbNP.ax
  bdaplgin.ax
  msyuv.dll
  msvidc32.dll
  msrle32.dll
  iyuv_32.dll
  msiltcfg.dll
  fwcfg.dll
  authfwcfg.dll
  icsigd.dll
  FirewallControlPanel.dll
  cngprovider.dll
  choice.exe
  PlayToDevice.dll
  sort.exe
  dusmapi.dll
  twext.dll
  shwebsvc.dll
  credssp.dll
  cngcredui.dll
  wsepno.dll
  keymgr.dll
  SMBHelperClass.dll
  rtm.dll
  prnfldr.dll
  mprdim.dll
  mprddm.dll
  iprtrmgr.dll
  iprtprio.dll
  ipnathlp.dll
  netid.dll
  iphlpsvc.dll
  fsmgmt.msc
  appinfoext.dll
  shpafact.dll
  LanguagePackDiskCleanup.dll
  LanguageComponentsInstaller.dll
  gptext.dll
  fundisc.dll
  AuthFWWizFwk.dll
  AuthFWGP.dll
  wdi.dll
  dmcmnutils.dll
  ddrawex.dll
  msaudite.dll
  wksprtPS.dll
  msctfime.ime
  zipfldr.dll
  makecab.exe
  Windows.UI.Cred.dll
  Magnification.dll
  accessibilitycpl.dll
  WindowManagement.dll
  globinputhost.dll
  chs_singlechar_pinyin.dat
  WordBreakers.dll
  Windows.UI.Core.TextInput.dll
  mssprxy.dll
  Windows.Perception.Stub.dll
  appinfo.dll
  twinui.appcore.dll
  ProximityServicePal.dll
  ProximityService.dll
  ProximityCommonPal.dll
  ProximityCommon.dll
  Windows.UI.dll
  ShellCommonCommonProxyStub.dll
  MSWB7.dll
  msvcirt.dll
  wlanpref.dll
  wlandlg.dll
  l2gpstore.dll
  dot3msm.dll
  dot3gpclnt.dll
  dot3dlg.dll
  dot3cfg.dll
  dot3api.dll
  wcnwiz.dll
  wcncsvc.dll
  wcmapi.dll
  fdWCN.dll
  midimap.dll
  LanguageOverlayUtil.dll
  LanguageOverlayServer.dll
  ChsStrokeDS.dll
  perfh009.dat
  perfc009.dat
  perfi009.dat
  perfd009.dat
  DefaultQuestions.json
  TSSessionUX.dll
  ConsoleLogon.dll
  Windows.Storage.OneCore.dll
  sppnp.dll
  PnPUnattend.exe
  pnppolicy.dll
  pnpclean.dll
  linkinfo.dll
  eventcls.dll
  DeviceUpdateAgent.dll
  chkwudrv.dll
  Windows.UI.CredDialogController.dll
  Windows.Internal.UI.Logon.ProxyStub.dll
  TrustedSignalCredProv.dll
  ngclocal.dll
  LogonController.dll
  KeyCredMgr.dll
  FlightSettings.dll
  f3ahvoas.dll
  devicengccredprov.dll
  credprovslegacy.dll
  CredProvHelper.dll
  CredProvDataModel.dll
  CredProv2faHelper.dll
  CredentialUIBroker.exe
  winsqlite3.dll
  weretw.dll
  werdiagcontroller.dll
  TimeBrokerServer.dll
  TimeBrokerClient.dll
  pacjsworker.exe
  offlinesam.dll
  offlinelsa.dll
  NetDriverInstall.dll
  microsoft-windows-system-events.dll
  gmsaclient.dll
  EncDump.dll
  dssenh.dll
  DeviceCensus.exe
  dcntel.dll
  ConhostV1.dll
  cabapi.dll
  adtschema.dll
  wpr.exe
  wpr.config.xml
  wosc.dll
  winhttpcom.dll
  windowsperformancerecordercontrol.dll
  Windows.System.RemoteDesktop.dll
  winbio.dll
  WimBootCompress.ini
  webservices.dll
  w32time.dll
  utcutil.dll
  sppinst.dll
  smphost.dll
  smbwmiv2.dll
  setupetw.dll
  security.dll
  runexehelper.exe
  refsutil.exe
  nshwfp.dll
  mtxdm.dll
  mispace.dll
  microsoft-windows-sleepstudy-events.dll
  microsoft-windows-kernel-power-events.dll
  microsoft-windows-kernel-pnp-events.dll
  mcupdate_GenuineIntel.dll
  mcupdate_AuthenticAMD.dll
  luainstall.dll
  inetmib1.dll
  ifmon.dll
  icfupgd.dll
  fcon.dll
  drvcfg.exe
  DbgModel.dll
  dbgeng.dll
  CSystemEventsBrokerClient.dll
  convertvhd.exe
  comres.dll
  comcat.dll
  asycfilt.dll
  winsku.dll
  winlogonext.dll
  w32topl.dll
  vss_ps.dll
  uudf.dll
  userinitext.dll
  swprv.dll
  svsvc.dll
  sfc.dll
  sacsvr.dll
  sacsess.exe
  printui.dll
  ntprint.dll
  mssip32.dll
  mssign32.dll
  mspatchc.dll
  msdelta.dll
  mscat32.dll
  microsoft-windows-storage-tiering-events.dll
  microsoft-windows-pdc.dll
  microsoft-windows-hal-events.dll
  microsoft-windows-battery-events.dll
  joinproviderol.dll
  idndl.dll
  ETWESEProviderResources.dll
  esevss.dll
  cmifw.dll
  cfmifsproxy.dll
  cfmifs.dll
  certcli.dll
  capisp.dll
  bcdsrv.dll
  advapi32res.dll
  WSHTCPIP.DLL
  wship6.dll
  perfproc.dll
  perfos.dll
  perfnet.dll
  perfdisk.dll
  perfctrs.dll
  imagesp1.dll
  clusapi.dll
  browseui.dll
  Windows.Devices.HumanInterfaceDevice.dll
  prflbmsg.dll
  jsproxy.dll
  efsutil.dll
  efslsaext.dll
  efscore.dll
  wshelper.dll
  ws2help.dll
  winsockhc.dll
  winipsec.dll
  oleacchooks.dll
  odbctrac.dll
  odbcint.dll
  odbccp32.dll
  msafd.dll
  lpk.dll
  IPSECSVC.DLL
  FwRemoteSvr.dll
  eappcfgui.dll
  dxgwdi.dll
  dhcpcmonitor.dll
  muifontsetup.dll
  wshhyperv.dll
  streamci.dll
  regapi.dll
  HvSocket.dll
  vmbuspipe.dll
  HalExtPL080.dll
  HalExtIntcLpioDMA.dll
  NL7Models0804.dll
  NL7Lexicons0804.dll
  broadcastenvchange.exe
  mpg123.exe
) do (
  Del /A /F /Q "%X%\Windows\System32\%%f"
  Del /A /F /Q "%X%\Windows\System32\zh-CN\%%f.mui"
  Del /A /F /Q "%X%\Windows\SystemResources\%%f.num"
)

rem ���� System32 ���dll������ɾ����ͨ���Ա�PE�ó���(�ڶ��ζԱ�)
for %%f in (
  apprepapi.dll
  AuthExt.dll
  DeviceCenter.dll
  diagER.dll
  diagtrack.dll
  dot3mm.dll
  dxtmsft.dll
  edgeIso.dll
  EdgeManager.dll
  fdWNet.dll
  FntCache.dll
  FontGlyphAnimator.dll
  hlink.dll
  HotSwap!.EXE
  ie4uinit.exe
  ieapfltr.dll
  iedkcs32.dll
  iepeers.dll
  ieproxy.dll
  iernonce.dll
  iesetup.dll
  iesysprep.dll
  ieui.dll
  ieuinit.inf
  LogonUI.exe
  MFMediaEngine.dll
  mfmp4srcsnk.dll
  mfnetcore.dll
  mfnetsrc.dll
  mfsvr.dll
  MSAudDecMFT.dll
  msfeeds.dll
  mskeyprotcli.dll
  msmpeg2vdec.dll
  msvproc.dll
  ndfapi.dll
  ndfetw.dll
  NdfEventView.xml
  ndfhcdiscovery.dll
  ndishc.dll
  occache.dll
  OnDemandConnRouteHelper.dll
  PCPKsp.dll
  profprov.dll
  profsvcext.dll
  puiapi.dll
  RESAMPLEDMO.DLL
  Sens.dll
  SnippingTool.exe
  sqmapi.dll
  srpapi.dll
  sxsstore.dll
  systray.exe
  themecpl.dll
  threadpoolwinrt.dll
  tscon.exe
  TSpkg.dll
  unattend.xml
  url.dll
  vssapi.dll
  vsstrace.dll
  wdigest.dll
  Windows.ApplicationModel.dll
  Windows.Globalization.Fontgroups.dll
  Windows.Media.dll
  Windows.Media.MediaControl.dll
  Windows.UI.Logon.dll
  Windows.UI.Xaml.Controls.dll
  Windows.UI.Xaml.dll
  Windows.UI.Xaml.Resources.19h1.dll
  Windows.UI.XamlHost.dll
  Winlangdb.dll
  WLanHC.dll
  WlanMM.dll
  WlanRadioManager.dll
  WPDShextAutoplay.exe
  wuceffects.dll
) do (
  Del /A /F /Q "%X%\Windows\System32\%%f"
  Del /A /F /Q "%X%\Windows\System32\zh-CN\%%f.mui"
  Del /A /F /Q "%X%\Windows\SystemResources\%%f.num"
)

rem ���� System32 ���dll���ر����ɾ����ͨ���Ա�PE�ó���(�����ζԱ�)
for %%f in (
  apphelp.dll
  ARP.EXE
  atlthunk.dll
  cacls.exe
  certca.dll
  chkntfs.exe
  clbcatq.dll
  clip.exe
  comctl32.dll
  CompMgmtLauncher.exe
  cryptnet.dll
  cryptxml.dll
  cscapi.dll
  d3d10_1.dll
  d3d10_1core.dll
  d3d10level9.dll
  ddraw.dll
  defragres.dll
  DeviceProperties.exe
  diskraid.exe
  dllhst3g.exe
  dnscacheugc.exe
  doskey.exe
  dot3svc.dll
  dxtrans.dll
  fbwflib.dll
  filemgmt.dll
  fltMC.exe
  hdwwiz.exe
  hhctrl.ocx
  HOSTNAME.EXE
  htui.dll
  IEAdvpack.dll
  iemigplugin.dll
  imaadp32.acm
  imapi.dll
  imapi2.dll
  imapi2fs.dll
  jscript.dll
  jscript9.dll
  kdcom.dll
  kmddsp.tsp
  l2nacp.dll
  mintdh.dll
  mode.com
  mprmsg.dll
  mshtml.dll
  mshtml.tlb
  mskeyprotect.dll
  mspaint.exe
  msrating.dll
  nbtstat.exe
  ndadmin.exe
  newdev.exe
  P2P.dll
  pcwum.dll
  pnpui.dll
  pnputil.exe
  policymanager.dll
  polstore.dll
  profext.dll
  rasadhlp.dll
  rasauto.dll
  rasautou.exe
  raschap.dll
  rasctrnm.h
  rasctrs.dll
  rasdiag.dll
  rasmbmgr.dll
  rasmontr.dll
  rasppp.dll
  rastls.dll
  recover.exe
  regedt32.exe
  replace.exe
  seclogon.dll
  SensApi.dll
  shacct.dll
  snmpapi.dll
  softpub.dll
  srchadmin.dll
  sscoreext.dll
  StateRepository.Core.dll
  subst.exe
  SysFxUI.dll
  SystemPropertiesHardware.exe
  SystemPropertiesPerformance.exe
  SystemPropertiesRemote.exe
  tapi32.dll
  tapisrv.dll
  TapiUnattend.exe
  TCPSVCS.EXE
  tokenbinding.dll
  ubpm.dll
  ucrtbase_clr0400.dll
  ucrtbase_enclave.dll
  umpoext.dll
  ureg.dll
  userinit.exe
  vpnike.dll
  vpnikeapi.dll
  WcnApi.dll
  wer.dll
  wevtutil.exe
  wiaservc.dll
  WindowsCodecsExt.dll
  winload.efi
  winload.exe
  wlancfg.dll
  WLanConn.dll
  wlanext.exe
  wlansvcpal.dll
  wlanui.dll
  wmi.dll
  wmicmiplugin.dll
  wmidcom.dll
  WmiMgmt.msc
  wmitomi.dll
  WMPhoto.dll
) do (
  Del /A /F /Q "%X%\Windows\System32\%%f"
  Del /A /F /Q "%X%\Windows\System32\zh-CN\%%f.mui"
  Del /A /F /Q "%X%\Windows\SystemResources\%%f.num"
)

goto :eof

rem ==================================================================
:LimitSlim
echo ���޾��򣨾�����350MB���ң�
rem ������ͨ����
call :NormlSlim

rem ���� System32 ���dll������ɾ����ͨ���Ա�PE�ó���(��һ�ζԱ�)
for %%f in (
  atl100.dll
  avicap32.dll
  batmeter.dll
  coloradapterclient.dll
  CompPkgSup.dll
  CoreMas.dll
  credprovhost.dll
  credprovs.dll
  cryptui.dll
  cscript.exe
  d3d10_1.dll
  d3d10_1core.dll
  defragproxy.dll
  defragsvc.dll
  desk.cpl
  deviceaccess.dll
  DeviceEject.exe
  DeviceSetupManagerAPI.dll
  diagnosticdataquery.dll
  difxapi.dll
  dxva2.dll
  Eap3Host.exe
  eapp3hst.dll
  eappcfg.dll
  eappgnui.dll
  eapphost.dll
  eapprovp.dll
  eapputil.dll
  eapsvc.dll
  EapTeapAuth.dll
  EapTeapConfig.dll
  efswrt.dll
  Facilitator.dll
  fsutil.exe
  GameInput.dll
  glu32.dll
  hdwwiz.cpl
  hidserv.dll
  htui.dll
  icm32.dll
  iemigplugin.dll
  IESettingSync.exe
  inetcpl.cpl
  keyiso.dll
  loadperf.dll
  lsaadt.dll
  main.cpl
  mblctr.exe
  mcbuilder.exe
  MDMAgent.exe
  MDMAppInstaller.exe
  MdmCommon.dll
  MdmDiagnostics.dll
  MdmDiagnosticsTool.exe
  mdminst.dll
  mdmlocalmanagement.dll
  mdmmigrator.dll
  mdmpostprocessevaluator.dll
  mdmregistration.dll
  mfc42.dll
  mfc90u.dll
  mfperfhelper.dll
  Microsoft.VC90.CRT.manifest
  Microsoft.VC90.MFC.manifest
  mountvol.exe
  msacm32.dll
  msadp32.acm
  mscms.dll
  msdmo.dll
  msg711.acm
  msgsm32.acm
  msi.dll
  msiexec.exe
  msihnd.dll
  msimsg.dll
  mspatcha.dll
  msrating.dll
  msvcp90.dll
  msvcp100.dll
  msvcp110.dll
  msvcp120.dll
  msvcp140.dll
  msvcr90.dll
  msvcr100.dll
  msvcr110.dll
  msvcr120.dll
  msvfw32.dll
  MuiUnattend.exe
  nci.dll
  ncpa.cpl
  netbtugc.exe
  NetCfgNotifyObjectHost.exe
  netiohlp.dll
  netiougc.exe
  netlogon.dll
  netmsg.dll
  Netplwiz.exe
  netsh.exe
  NETSTAT.EXE
  networkitemfactory.dll
  Nlsdl.dll
  normidna.nls
  objsel.dll
  opengl32.dll
  photowiz.dll
  pnpdiag.dll
  PortableDeviceStatus.dll
  PortableDeviceSyncProvider.dll
  PortableDeviceWiaCompat.dll
  quartz.dll
  query.exe
  rasdial.exe
  rasdlg.dll
  rasmans.dll
  rasphone.exe
  rasphone.pbk
  rastapi.dll
  resutils.dll
  riched32.dll
  ROUTE.EXE
  RTWorkQ.dll
  schedcli.dll
  scrrun.dll
  sdhcinst.dll
  setx.exe
  sfc.exe
  shimgvw.dll
  SlideToShutDown.exe
  spaceutil.exe
  sstpsvc.dll
  stdole32.tlb
  sti.dll
  sxstrace.exe
  tcpipcfg.dll
  tdhres.dll
  TextShaping.dll
  themeui.dll
  timedate.cpl
  tree.com
  TtlsAuth.dll
  TtlsCfg.dll
  ucsvc.exe
  VAN.dll
  vcomp100.dll
  vcruntime140.dll
  VhfUm.dll
  WerEnc.dll
  wfapigp.dll
  WindowManagementAPI.dll
  @REM Windows.FileExplorer.Common.dll
  Windows.Web.dll
  WMPhoto.dll
  wowreg32.exe
  WPDShextAutoplay.exe
  wshext.dll
) do (
  Del /A /F /Q "%X%\Windows\System32\%%f"
  Del /A /F /Q "%X%\Windows\System32\zh-CN\%%f.mui"
  Del /A /F /Q "%X%\Windows\SystemResources\%%f.num"
)

rem ���� SysWOW64 ���dll������ɾ����ͨ���Ա�PE�ó���(��һ�ζԱ�)
for %%f in (
  aclui.dll
  amsi.dll
  atl71.dll
  atl100.dll
  attrib.exe
  authz.dll
  avicap32.dll
  avifil32.dll
  cabinet.dll
  clb.dll
  cmdext.dll
  crtdll.dll
  cryptdll.dll
  d3d9.dll
  d3d10warp.dll
  d3d11.dll
  DataExchange.dll
  davhlpr.dll
  dciman32.dll
  dcomp.dll
  devenum.dll
  dinput8.dll
  dpapi.dll
  DXCore.dll
  dxgi.dll
  FirewallAPI.dll
  fltLib.dll
  fontsub.dll
  fwbase.dll
  glu32.dll
  hid.dll
  jscript.dll
  KBDUS.DLL
  ksuser.dll
  mfc42u.dll
  mscms.dll
  mshtml.dll
  msi.dll
  msIso.dll
  msv1_0.dll
  msvcp60.dll
  msvcp71.dll
  msvcp100.dll
  msvcp110.dll
  msvcp120.dll
  msvcp140.dll
  msvcr71.dll
  msvcr100.dll
  msvcr110.dll
  msvcr120.dll
  msvfw32.dll
  msxml3r.dll
  NetSetupApi.dll
  ntdsapi.dll
  NtlmShared.dll
  odbc32.dll
  opengl32.dll
  rasapi32.dll
  rasman.dll
  reg.exe
  riched32.dll
  schannel.dll
  spfileq.dll
  spinf.dll
  stdole2.tlb
  stdole32.tlb
  StructuredQuery.dll
  sxs.dll
  TextShaping.dll
  UIAnimation.dll
  ulib.dll
  vcomp100.dll
  vcruntime140.dll
  wdmaud.drv
  wdscore.dll
  winbrand.dll
  wincredui.dll
  winsta.dll
  wldp.dll
) do (
  Del /A /F /Q "%X%\Windows\SysWOW64\%%f"
  Del /A /F /Q "%X%\Windows\SysWOW64\zh-CN\%%f.mui"
)
goto :eof

rem ==================================================================
:MaintainSlim
echo ά�����򣨾����������硢��������
rem ������ͨ����
call :NormlSlim

rem ɾ����������ļ�
rd /q /s "%X%\Program Files\PENetwork"
rd /q /s "%X%\Windows\L2Schemas"
Del /A /F /Q "%X%\Program Files\WinXShell\wxsUI\UI_WIFI.zip"
Del /A /F /Q "%X%\Windows\System32\rasphone.pbk"
rd /q /s "%X%\Program Files\Edgeless\EasyDown"
rd /q /s "%X%\Program Files\Edgeless\plugin_ept"

rem ɾ����������

rem ����ͻ���
call :RemoveDrivers "c_netclient.inf,netmscli.inf"
rem �������
call :RemoveDrivers "c_netservice.inf,ndiscap.inf,netbrdg.inf,netnb.inf,netnwifi.inf"
call :RemoveDrivers "netpacer.inf,netrass.inf,netserv.inf,netvwififlt.inf,wfpcapture.inf"
rem ����Э��
call :RemoveDrivers "c_nettrans.inf,lltdio.inf,ndisimplatform.inf,ndisuio.inf,netip6.inf,netirda.inf"
call :RemoveDrivers "netlldp.inf,netpgm.inf,netrast.inf,nettcpip.inf,rspndr.inf,wnetvsc_vfpp.inf"
rem ��·����
call :RemoveDrivers "athw8x.inf,b57nd60a.inf,bcmdhd64.inf,bcmwdidhdpcie.inf,bnxtnd.inf,bthpan.inf"
call :RemoveDrivers "c_net.inf,dc21x4vm.inf,e2xw10x64.inf,ipoib6x.inf,kdnic.inf"
call :RemoveDrivers "mrvlpcie8897.inf,msdri.inf,msux64w10.inf,mwlu97w8x64.inf,ndisimplatformmp.inf"
call :RemoveDrivers "net1ic64.inf,net1ix64.inf,net1yx64.inf,net40i65.inf,net40i68.inf,net44amd.inf"
call :RemoveDrivers "net819xp.inf,net7400-x64-n650.inf,net7500-x64-n650f.inf,net7800-x64-n650f.inf"
call :RemoveDrivers "net8185.inf,net8187bv64.inf,net8187se64.inf,net8192se64.inf,net8192su64.inf"
call :RemoveDrivers "net9500-x64-n650f.inf,netathr10x.inf,netathrx.inf,netavpna.inf,netax88179_178a.inf"
call :RemoveDrivers "netax88772.inf,netbc63a.inf,netbc64.inf,netbnad8.inf,netbxnda.inf"
call :RemoveDrivers "nete1e3e.inf,nete1g3e.inf,netefe3e.inf,netelx.inf,netg664.inf,netimm.inf,netjme.inf"
call :RemoveDrivers "netk57a.inf,netl1c63x64.inf,netl1e64.inf,netl160a.inf,netl260a.inf,netloop.inf"
call :RemoveDrivers "netmlx4eth63.inf,netmlx5.inf,netmyk64.inf,netnvm64.inf,netnvma.inf,netqenda.inf"
call :RemoveDrivers "netr28ux.inf,netr28x.inf,netr7364.inf,netrasa.inf,netrndis.inf,netrtl64.inf"
call :RemoveDrivers "netrtwlane.inf,netrtwlane_13.inf,netrtwlane01.inf,netrtwlans.inf,netrtwlanu.inf"
call :RemoveDrivers "netsstpa.inf,nett4x64.inf,netv1x64.inf,netvchannel.inf,netvf63a.inf,netvg63a.inf"
call :RemoveDrivers "netvwifimp.inf,netvwwanmp.inf,netwbw02.inf,netwew00.inf,netwew01.inf,netwlv64.inf"
call :RemoveDrivers "netwmbclass.inf,netwns64.inf,netwsw00.inf,netwtw02.inf,netwtw04.inf,netwtw06.inf"
call :RemoveDrivers "netwtw08.inf,netxex64.inf,netxix64.inf,rndiscmp.inf,rt640x64.inf,rtux64w10.inf"

rem ��������Ƶ����Ϸ������
call :RemoveDrivers "acxhdaudiop.inf,bda.inf,c_media.inf,gameport.inf,hdaudio.inf,hdaudss.inf,ks.inf,kscaptur.inf,ksfilter.inf"
call :RemoveDrivers "microsoft_bluetooth_a2dp.inf,microsoft_bluetooth_a2dp_snk.inf"
call :RemoveDrivers "microsoft_bluetooth_a2dp_src.inf,microsoft_bluetooth_hfp.inf,modemcsa.inf,mstape.inf"
call :RemoveDrivers "usbaudio2.inf,wave.inf,wdma_usb.inf,wdmaudio.inf,wdmaudiocoresystem.inf"

rem ����System32�ļ�������ɾ����ͨ���Ա�PE�ó���(��һ�ζԱ�)
for %%f in (
  atl100.dll
  audiodg.exe
  AudioEndpointBuilder.dll
  AudioEng.dll
  AUDIOKSE.dll
  AudioSes.dll
  audiosrv.dll
  AudioSrvPolicyManager.dll
  authui.dll
  avrt.dll
  batmeter.dll
  BFE.DLL
  CompPkgSup.dll
  coreaudiopolicymanagerext.dll
  credprovhost.dll
  credprovs.dll
  cryptsvc.dll
  cryptui.dll
  d3d9.dll
  dciman32.dll
  devenum.dll
  deviceaccess.dll
  dhcpcore.dll
  dhcpcore6.dll
  dhcpcsvc.dll
  dhcpcsvc6.dll
  difxapi.dll
  dinput.dll
  dinput8.dll
  directmanipulation.dll
  dnsrslvr.dll
  dsound.dll
  dxva2.dll
  eappprxy.dll
  evr.dll
  ExecModelClient.dll
  fontsub.dll
  fwpolicyiomgr.dll
  FWPUCLNT.DLL
  glu32.dll
  gpapi.dll
  gpsvc.dll
  IKEEXT.DLL
  jscript.dll
  KerbClientShared.dll
  kerberos.dll
  ksuser.dll
  lmhsvc.dll
  loadperf.dll
  mf.dll
  mfcore.dll
  mfperfhelper.dll
  mfplat.dll
  MMDevAPI.dll
  mmres.dll
  mmsys.cpl
  MP3DMOD.DLL
  mprapi.dll
  mprext.dll
  MPSSVC.dll
  msacm32.dll
  msacm32.drv
  MSAlacDecoder.dll
  MSAudDecMFT.dll
  mscms.dll
  msctfp.dll
  msctfuimanager.dll
  msdmo.dll
  MSFlacDecoder.dll
  msi.dll
  msiexec.exe
  msihnd.dll
  msimsg.dll
  msmpeg2adec.dll
  msmpeg2vdec.dll
  MSOpusDecoder.dll
  msvcp100.dll
  msvcp110.dll
  msvcp120.dll
  msvcp140.dll
  msvcr100.dll
  msvcr110.dll
  msvcr120.dll
  mswsock.dll
  ncryptprov.dll
  ncryptsslp.dll
  ncsi.dll
  net.exe
  netcfg.exe
  NetCfgNotifyObjectHost.exe
  netcfgx.dll
  netplwiz.dll
  netprofm.dll
  netprofmsvc.dll
  NetSetupApi.dll
  NetSetupEngine.dll
  NetSetupShim.dll
  NetSetupSvc.dll
  NetworkStatus.dll
  NetworkUXBroker.dll
  nlaapi.dll
  nlasvc.dll
  npmproxy.dll
  ntlanman.dll
  onex.dll
  opengl32.dll
  PING.EXE
  pnidui.dll
  quartz.dll
  rasapi32.dll
  rasman.dll
  RTWorkQ.dll
  samlib.dll
  SndVol.exe
  SndVolSSO.dll
  stobject.dll
  StorageContextHandler.dll
  tcpipcfg.dll
  threadpoolwinrt.dll
  vcomp100.dll
  vcruntime140.dll
  wcmcsp.dll
  wcmsvc.dll
  wdmaud.drv
  webio.dll
  wevtsvc.dll
  wfapigp.dll
  wincredui.dll
  Windows.Media.Devices.dll
  Windows.Networking.Connectivity.dll
  wkssvc.dll
  wlanapi.dll
  wlanhlp.dll
  WlanMediaManager.dll
  wlanmsm.dll
  wlansec.dll
  wlansvc.dll
  wlanutil.dll
  wmiclnt.dll
) do (
  Del /A /F /Q "%X%\Windows\System32\%%f"
  Del /A /F /Q "%X%\Windows\System32\zh-CN\%%f.mui"
  Del /A /F /Q "%X%\Windows\SystemResources\%%f.num"
)
rem ����SysWOW64�ļ�������ɾ����ͨ���Ա�PE�ó���(��һ�ζԱ�)
for %%f in (
  AudioSes.dll
  avicap32.dll
  avrt.dll
  credui.dll
  crtdll.dll
  d3d9.dll
  d3d10warp.dll
  d3d11.dll
  DataExchange.dll
  dbgcore.dll
  dbghelp.dll
  dciman32.dll
  dcomp.dll
  devenum.dll
  dhcpcsvc.dll
  dhcpcsvc6.dll
  dinput.dll
  dinput8.dll
  directmanipulation.dll
  dsound.dll
  DWrite.dll
  dxgi.dll
  fontsub.dll
  FWPUCLNT.DLL
  glu32.dll
  jscript.dll
  ksuser.dll
  MMDevAPI.dll
  msacm32.dll
  msacm32.drv
  msctfuimanager.dll
  msIso.dll
  msvcp110.dll
  msvcp120.dll
  msvcp140.dll
  msvcr110.dll
  msvcr120.dll
  mswsock.dll
  ncrypt.dll
  ncryptsslp.dll
  ntasn1.dll
  opengl32.dll
  quartz.dll
  rasapi32.dll
  rasman.dll
  SensApi.dll
  sxs.dll
  UIAnimation.dll
  UIAutomationCore.dll
  vcruntime140.dll
  wdmaud.drv
  wevtapi.dll
  winhttp.dll
  WinTypes.dll
) do (
  Del /A /F /Q "%X%\Windows\SysWOW64\%%f"
  Del /A /F /Q "%X%\Windows\SysWOW64\zh-CN\%%f.mui"
)

rem ɾ��DISM
rem rd /q /s "%X%\Windows\System32\Dism"
rem Del /A /F /Q "%X%\Windows\System32\Dism.exe"
rem Del /A /F /Q "%X%\Windows\System32\DismApi.dll"
rem Del /A /F /Q "%X%\Windows\System32\wdscore.dll"
rem Del /A /F /Q "%X%\Windows\System32\WimBootCompress.ini"
rem Del /A /F /Q "%X%\Windows\System32\zh-CN\Dism.exe.mui"

rem ɾ��Wbem��ϵͳ����Ӳ����Ϣ��
rd /q /s "%X%\Windows\System32\wbem"
goto :eof

:RemoveDrivers
for %%i in (%~1) do (
  del /a /f /q "%X%\Windows\INF\%%i"
  del /a /f /q "%X%\Windows\System32\drivers\%%~ni.sys"
  call :delFolder "%X%\Windows\System32\DriverStore\FileRepository\%%i*"
)
goto :EOF

:delFolder
rem ɾ���ļ��У�֧��ͨ�����
for /f %%i in ('dir /ad /s /b %1') do (rd /s /q %%i)
goto :eof