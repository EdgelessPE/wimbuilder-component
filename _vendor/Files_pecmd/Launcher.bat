::ע�⣺�����ϣ���޸�Edgeless�ں��γ��Լ�����Ʒ������� https://wiki.edgeless.top/1398297 �鿴Ҫ��
@echo off
cd /d X:\Windows\System32
echo %date% >>X:\Users\Log.txt
echo %time% Launcher-���� >>X:\Users\Log.txt
set /p EL_VER=<"%ProgramFiles%\version.txt"
echo %time% Launcher-�汾�ţ�%EL_VER% >>X:\Users\Log.txt
:begin
for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\version_Disk.txt echo %%1>Upath.txt
for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\version.txt echo %%1>Upath.txt
set /p Upath=<Upath.txt
echo %time% Launcher-ʹ��%Upath%��ΪEdgeless�̷� >>X:\Users\Log.txt

if not defined Upath (
  echo %time% Launcher-Upathδ���� >>X:\Users\Log.txt
  if not exist x:\users\autoretry goto autoretry
  echo %time% Launcher-�������洰�ڣ�δ���������̣� >>X:\Users\Log.txt
  start /wait 0wait.cmd
  if exist "X:\users\skipsetup" goto skipsetup
  echo %time% Launcher-�û�ѡ�����ԣ��رմ��ڣ� >>X:\Users\Log.txt
  goto begin
)

::������ڸ��µ�Launcher�ļ������
::���Ҫ���ڱ��ļ�����Launcher.cmd�������ɾ���˴����ж���䣡
set runWarn=0
if exist %Upath%:\Edgeless\Launcher.cmd (
  echo %time% Launcher-��������Launcher >>X:\Users\Log.txt
  if exist %Upath%:\Edgeless\Config\Developer echo %time% Launcher-���ڽ��þ��濪�� >>X:\Users\Log.txt
  if not exist %Upath%:\Edgeless\Config\Developer set runWarn=1
  if exist %Upath%:\Edgeless\Config\Developer set runWarn=2
)
if %runWarn%==1 pecmd exec =X:\Windows\System32\0warn.wcs
if %runWarn%==2 pecmd exec X:\Windows\System32\0warn.wcs
if exist %Upath%:\Edgeless\Launcher.cmd (
  if exist X:\Users\useins echo %time% Launcher-�û�ȡ��ʹ������ >>X:\Users\Log.txt
  if not exist X:\Users\useins echo %time% Launcher-�û�ȷ��ʹ������ >>X:\Users\Log.txt
  if exist X:\Users\useins goto ctn
  call %Upath%:\Edgeless\Launcher.cmd
  exit
)
:ctn

::��������־�ļ�
::if exist %Upath%:\Edgeless\ErrorLog.txt (
::  echo %time% Launcher-��⵽������־�ļ�������������������� >>X:\Users\Log.txt
::  set errorTip=0
::)

::����������־�ļ�
::echo %time% Edgeless��������ʼ��%date% %time% >%Upath%:\Edgeless\ErrorLog.txt

::��ȡ�ֱ���������Ϣ
if exist "%Upath%:\Edgeless\�ֱ���.txt" (
  if not exist %Upath%:\Edgeless\Config md %Upath%:\Edgeless\Config
  move /y "%Upath%:\Edgeless\�ֱ���.txt" "%Upath%:\Edgeless\Config\�ֱ���.txt"
)
if exist "%Upath%:\Edgeless\Config\�ֱ���.txt" set /p disp=<"%Upath%:\Edgeless\Config\�ֱ���.txt"
if exist "%Upath%:\Edgeless\Config\�ֱ���.txt" echo %time% Launcher-��ȡ�Զ���ֱ��ʣ�%disp% >>X:\Users\Log.txt


::�����Զ����ֽ
if exist "%Upath%:\Edgeless\wp.jpg" (
echo %time% Launcher-������ֽ >>X:\Users\Log.txt
copy "%Upath%:\Edgeless\wp.jpg" X:\Users\WallPaper\User.jpg
if not exist "%Upath%:\Edgeless\wp.jpg" echo %time% Launcher-������ֽʧ�� >>X:\Users\Log.txt
)

::����Windows�ļ�������
if exist %Upath%:\Edgeless\Windows echo %time% Launcher-��ʼ����Windows�ļ��� >>X:\Users\Log.txt
if exist %Upath%:\Edgeless\Windows xcopy /s /r /y "%Upath%:\Edgeless\Windows\*" "X:\Windows\*"

::��Ҫ���������ģ��
::if exist "%Upath%:\Edgeless\Nes_Inport.7z" (
::echo %time% Launcher-��ʼ���ر�Ҫ����� >>X:\Users\Log.txt
::call "X:\Program Files\Edgeless\dynamic_creator\dynamic_tip.cmd" 4000 Edgeless��ʼ�� ���ڼ��ر�Ҫ�����
::"%ProgramFiles%\7-Zip_x64\7z.exe" x "%Upath%:\Edgeless\Nes_Inport.7z" -o"X:\Program Files\Edgeless" -aoa
::)
::if not exist "%Upath%:\Edgeless\Nes_Inport.7z" echo %time% Launcher-δ���ֱ�Ҫ����� >>X:\Users\Log.txt
::if not exist "%Upath%:\Edgeless\Nes_Inport.7z" call "X:\Program Files\Edgeless\dynamic_creator\dynamic_msgbox.cmd" Edgeless��ʼ������ ���棺û�з��ֱ�Ҫ�����Nes_Inport.7z��Edgeless����ʧȥ��Ҫ�Ĺ���������
::if exist "%ProgramFiles%\Edgeless\Nes.ini" pecmd load "%ProgramFiles%\Edgeless\Nes.ini"

::���ñ�ֽ
if exist X:\Users\WallPaper\User.jpg (
pecmd wall X:\Users\WallPaper\User.jpg
)

::�������װģ��
::if defined errorTip (
::  echo %time% Launcher-���ڴ����ļ���������������� >>X:\Users\Log.txt
::  goto endPluginLoad
::)
::if exist "%Upath%:\Edgeless\Resource\*.7z" (
::echo %time% Launcher-��ʼ�������� >>X:\Users\Log.txt
::call "X:\Program Files\Edgeless\dynamic_creator\dynamic_tip.cmd" 5000 Edgeless��ʼ�� ���ڼ��ز����
::echo %time% Launcher-������б� >>X:\Users\Log.txt
::dir /b %Upath%:\Edgeless\Resource\*.7z >>X:\Users\Log.txt
::"%ProgramFiles%\7-Zip_x64\7z.exe" x %Upath%:\Edgeless\Resource\*.7z  -y -aos -o"%ProgramFiles%\Edgeless"
::echo %time% Launcher-�����������б� >>X:\Users\Log.txt
::dir /b "%ProgramFiles%\Edgeless\*.cmd" >>X:\Users\Log.txt
::dir /b "%ProgramFiles%\Edgeless\*.wcs" >>X:\Users\Log.txt
::dir /b "%ProgramFiles%\Edgeless\*.cmd" >"%ProgramFiles%\Edgeless\cmdlist.txt"
::for /f  "usebackq" %%a in  ("%ProgramFiles%\Edgeless\cmdlist.txt") do (
::start "" /D "X:\Program Files\Edgeless\" "%%a"
::echo %time% Launcher-����%%a >>X:\Users\Log.txt
::pecmd exec !"%ProgramFiles%\Edgeless\%%a"
::pecmd wait 100
::  )
::dir /b "%ProgramFiles%\Edgeless\*.wcs" >"%ProgramFiles%\Edgeless\wcslist.txt"
::for /f  "usebackq" %%a in  ("%ProgramFiles%\Edgeless\wcslist.txt") do (
::start "" /D "%ProgramFiles%\Edgeless\" "%%a"
::echo %time% Launcher-����%%a >>X:\Users\Log.txt
::xcmd load "%ProgramFiles%\Edgeless\%%a"
::pecmd wait 100
::  )
::del /f /q "%ProgramFiles%\Edgeless\cmdlist.txt"
::del /f /q "%ProgramFiles%\Edgeless\wcslist.txt"
::����û����������������ߵ��ɲ��������Ϊ����ӿ�ݷ�ʽ
::if exist "%ProgramFiles%\Edgeless\��������������\����������.exe" echo %time% Launcher-�û����������ߵ����˲���� >>X:\Users\Log.txt
::if exist "%ProgramFiles%\Edgeless\��������������\����������.exe" pecmd link "X:\Users\Default\Desktop\����������","X:\Program Files\Edgeless\��������������\����������.exe",,"X:\Users\Icon\shortcut\usbburner.ico",0
::)
:endPluginLoad

call "X:\Program Files\Edgeless\dynamic_creator\dynamic_tip.cmd" 2000 Edgeless��ʼ�� ������Ч�û�����

::����ISO���
if exist %Upath%:\Edgeless\Config\DisableSmartISO echo %time% Launcher-��Ӧ��������������� >>X:\Users\Log.txt
if not exist %Upath%:\Edgeless\Config\DisableSmartISO reg add "HKCR\.iso" /f /ve /t REG_SZ /d "Imdisk.iso"
reg add "HKCR\Imdisk.iso" /f /ve /t REG_SZ /d "ISO"
reg add "HKCR\Imdisk.iso\DefaultIcon" /f /ve /t REG_SZ /d "%%SystemRoot%%\System32\shell32.dll,188"
reg add "HKCR\Imdisk.iso\shell" /f /ve /t REG_SZ /d ""
reg add "HKCR\Imdisk.iso\shell\open" /f /ve /t REG_SZ /d ""
reg add "HKCR\Imdisk.iso\shell\open\command" /f /ve /t REG_SZ /d "X:\Users\Imdisk\SmartISO.exe \"%%1\""

::��Ӧ����U�̹�����
if exist %Upath%:\Edgeless\Config\DisableUSBManager echo %time% Launcher-��Ӧ����U�̹����� >>X:\Users\Log.txt
if exist %Upath%:\Edgeless\Config\DisableUSBManager md X:\Users\DisableUSBManager

::��ӦĬ�ϰ�ťΪ��������
if exist %Upath%:\Edgeless\Config\RebootDefault echo %time% Launcher-��ӦĬ�ϰ�ťΪ�������� >>X:\Users\Log.txt
if exist %Upath%:\Edgeless\Config\RebootDefault reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "Start_PowerButtonAction" /t REG_DWORD /d 4

::��Ӧ���û���վ����
if exist %Upath%:\Edgeless\Config\DisableRecycleBin echo %time% Launcher-��Ӧ���û���վ���� >>X:\Users\Log.txt
if exist %Upath%:\Edgeless\Config\DisableRecycleBin pecmd RECY *:\,0

::����ȫ���Զ�Ӧ��
if exist %Upath%:\Edgeless\Config\AutoUnattend echo %time% Launcher-����ȫ���Զ�Ӧ�𿪹� >>X:\Users\Log.txt
if exist %Upath%:\Edgeless\Config\AutoUnattend pecmd file X:\Users\Imdisk\AutoUnattend.xml=>X:\AutoUnattend.xml

::��Ӧչ����Դ������������
if exist %Upath%:\Edgeless\Config\UnfoldRibbon echo %time% Launcher-��Ӧչ����Դ���������������� >>X:\Users\Log.txt
if exist %Upath%:\Edgeless\Config\UnfoldRibbon reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /f /v "ExplorerRibbonStartsMinimized" /t REG_DWORD /d 2

::��Ӧ�������з���
if exist %Upath%:\Edgeless\Config\MountEveryPartition echo %time% Launcher-��Ӧ��ʾ���з��� >>X:\Users\Log.txt
if exist %Upath%:\Edgeless\Config\MountEveryPartition pecmd SHOW =1 *

::���ڲ�������������
if exist %Upath%:\Edgeless\Config\NoOutDateCheck echo %time% Launcher-��Ӧ���ù��ڲ������⿪�� >>X:\Users\Log.txt
if not exist %Upath%:\Edgeless\Config\NoOutDateCheck pecmd exec !"%ProgramFiles%\Edgeless\plugin_outdatedcheck\compare.cmd"

::���ڷֱ���
if defined disp (
  if "%disp%"=="DisableAutoSuit" echo %time% Launcher-��鵽DisableAutoSuit�������ֱ������� >>X:\Users\Log.txt
  if "%disp%"=="DisableAutoSuit" goto endAutoSuit
)
xcmd disp %disp%
echo %time% Launcher-���÷ֱ��ʽ��� >>X:\Users\Log.txt
:endAutoSuit

::Edgeless�ļ�������
cd /d "%ProgramFiles%\Edgeless"
if not exist ��װ���� md ��װ����
move /y *.cmd ��װ����
move /y *.wcs ��װ����
move /y Nes.ini ��װ����
cd ��װ����
echo ��Ŀ¼��Ų�����İ�װ���� > ˵��.txt
echo ����ʹ�ã��뽫���Ƶ��ϼ�Ŀ¼������ >> ˵��.txt
echo %time% Launcher-���������˳� >>X:\Users\Log.txt

::ɾ��������־�ļ�
for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\ErrorLog.txt del /f /q %%1:\Edgeless\ErrorLog.txt

::���д���ԭ����ʾ
::if defined errorTip call "X:\Program Files\Edgeless\dynamic_creator\dynamic_msgbox.cmd" Edgeless��ʼ������ Edgeless���Զ��޸���һ����������ԭ�������Ļ����ڴ��С����������ർ�±�����������ò��ֲ������
exit

:skipsetup
echo %time% Launcher-�û�ѡ��SkipSetup�������˳� >>X:\Users\Log.txt
call "X:\Program Files\Edgeless\plugin_loader\load.cmd" "X:\Program Files\Ӧ����.7z"
rd x:\users\autoretry
cd /d X:\Windows\System32
pecmd link "X:\Users\Default\Desktop\���¼���","X:\Program Files\Launcher.bat"
exit

:autoretry
md x:\users\autoretry
pecmd wait 2500
echo %time% Launcher-���е�һ������ >>X:\Users\Log.txt
goto begin