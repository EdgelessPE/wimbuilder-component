::ע�⣺���ļ�������δ���������Ƽ�����ȡ��
exit
@REM @echo off
@REM if not exist X:\Windows\System32 exit
@REM cd /d X:\Windows\System32
@REM echo %date% >>X:\Users\Log.txt
@REM echo %time% Launcher-���� >>X:\Users\Log.txt
@REM set /p EL_VER=<"%ProgramFiles%\version.txt"
@REM echo %time% Launcher-�汾�ţ�%EL_VER% >>X:\Users\Log.txt
@REM :begin
@REM for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\version_Disk.txt echo %%1>Upath.txt
@REM for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\version.txt echo %%1>Upath.txt
@REM set /p Upath=<Upath.txt
@REM echo %time% Launcher-ʹ��%Upath%��ΪEdgeless�̷� >>X:\Users\Log.txt

@REM if not defined Upath (
@REM   echo %time% Launcher-Upathδ���� >>X:\Users\Log.txt
@REM   if not exist x:\users\autoretry goto autoretry
@REM   echo %time% Launcher-�������洰�ڣ�δ���������̣� >>X:\Users\Log.txt
@REM   start /wait 0wait.cmd
@REM   if exist "X:\users\skipsetup" goto skipsetup
@REM   echo %time% Launcher-�û�ѡ�����ԣ��رմ��ڣ� >>X:\Users\Log.txt
@REM   goto begin
@REM )

::������ڸ��µ�Launcher�ļ������
::���Ҫ���ڱ��ļ�����Launcher.cmd�������ɾ���˴����ж���䣡
@REM set runWarn=0
@REM if exist %Upath%:\Edgeless\Launcher.cmd (
@REM   echo %time% Launcher-��������Launcher >>X:\Users\Log.txt
@REM   if exist %Upath%:\Edgeless\Config\Developer echo %time% Launcher-���ڽ��þ��濪�� >>X:\Users\Log.txt
@REM   if not exist %Upath%:\Edgeless\Config\Developer set runWarn=1
@REM   if exist %Upath%:\Edgeless\Config\Developer set runWarn=2
@REM )
@REM if %runWarn%==1 pecmd exec =X:\Windows\System32\0warn.wcs
@REM if %runWarn%==2 pecmd exec X:\Windows\System32\0warn.wcs
@REM if exist %Upath%:\Edgeless\Launcher.cmd (
@REM   if exist X:\Users\useins echo %time% Launcher-�û�ȡ��ʹ������ >>X:\Users\Log.txt
@REM   if not exist X:\Users\useins echo %time% Launcher-�û�ȷ��ʹ������ >>X:\Users\Log.txt
@REM   if exist X:\Users\useins goto ctn
@REM   call %Upath%:\Edgeless\Launcher.cmd
@REM   exit
@REM )
@REM :ctn

::��������־�ļ�
::if exist %Upath%:\Edgeless\ErrorLog.txt (
::  echo %time% Launcher-��⵽������־�ļ�������������������� >>X:\Users\Log.txt
::  set errorTip=0
::)

::����������־�ļ�
::echo %time% Edgeless��������ʼ��%date% %time% >%Upath%:\Edgeless\ErrorLog.txt

::��ȡ�ֱ���������Ϣ
@REM if exist "%Upath%:\Edgeless\�ֱ���.txt" (
@REM   if not exist %Upath%:\Edgeless\Config md %Upath%:\Edgeless\Config
@REM   move /y "%Upath%:\Edgeless\�ֱ���.txt" "%Upath%:\Edgeless\Config\�ֱ���.txt"
@REM )
@REM if exist "%Upath%:\Edgeless\Config\�ֱ���.txt" set /p disp=<"%Upath%:\Edgeless\Config\�ֱ���.txt"
@REM if exist "%Upath%:\Edgeless\Config\�ֱ���.txt" echo %time% Launcher-��ȡ�Զ���ֱ��ʣ�%disp% >>X:\Users\Log.txt


::�����Զ����ֽ
@REM if exist "%Upath%:\Edgeless\wp.jpg" (
@REM echo %time% Launcher-������ֽ >>X:\Users\Log.txt
@REM copy "%Upath%:\Edgeless\wp.jpg" X:\Users\WallPaper\User.jpg
@REM if not exist "%Upath%:\Edgeless\wp.jpg" echo %time% Launcher-������ֽʧ�� >>X:\Users\Log.txt
@REM )

::����Windows�ļ�������
@REM if exist %Upath%:\Edgeless\Windows echo %time% Launcher-��ʼ����Windows�ļ��� >>X:\Users\Log.txt
@REM if exist %Upath%:\Edgeless\Windows xcopy /s /r /y "%Upath%:\Edgeless\Windows\*" "X:\Windows\*"

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
@REM if exist X:\Users\WallPaper\User.jpg (
@REM pecmd wall X:\Users\WallPaper\User.jpg
@REM )

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

@REM call "X:\Program Files\Edgeless\dynamic_creator\dynamic_tip.cmd" 2000 Edgeless��ʼ�� ������Ч�û�����

::����ISO���
@REM if exist %Upath%:\Edgeless\Config\DisableSmartISO echo %time% Launcher-��Ӧ��������������� >>X:\Users\Log.txt
@REM if not exist %Upath%:\Edgeless\Config\DisableSmartISO reg add "HKCR\.iso" /f /ve /t REG_SZ /d "Imdisk.iso"
@REM reg add "HKCR\Imdisk.iso" /f /ve /t REG_SZ /d "ISO"
@REM reg add "HKCR\Imdisk.iso\DefaultIcon" /f /ve /t REG_SZ /d "%%SystemRoot%%\System32\shell32.dll,188"
@REM reg add "HKCR\Imdisk.iso\shell" /f /ve /t REG_SZ /d ""
@REM reg add "HKCR\Imdisk.iso\shell\open" /f /ve /t REG_SZ /d ""
@REM reg add "HKCR\Imdisk.iso\shell\open\command" /f /ve /t REG_SZ /d "X:\Users\Imdisk\SmartISO.exe \"%%1\""

@REM ::��Ӧ����U�̹�����
@REM if exist %Upath%:\Edgeless\Config\DisableUSBManager echo %time% Launcher-��Ӧ����U�̹����� >>X:\Users\Log.txt
@REM if exist %Upath%:\Edgeless\Config\DisableUSBManager md X:\Users\DisableUSBManager

@REM ::��ӦĬ�ϰ�ťΪ��������
@REM if exist %Upath%:\Edgeless\Config\RebootDefault echo %time% Launcher-��ӦĬ�ϰ�ťΪ�������� >>X:\Users\Log.txt
@REM if exist %Upath%:\Edgeless\Config\RebootDefault reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "Start_PowerButtonAction" /t REG_DWORD /d 4

@REM ::��Ӧ���û���վ����
@REM if exist %Upath%:\Edgeless\Config\DisableRecycleBin echo %time% Launcher-��Ӧ���û���վ���� >>X:\Users\Log.txt
@REM if exist %Upath%:\Edgeless\Config\DisableRecycleBin pecmd RECY *:\,0

@REM ::����ȫ���Զ�Ӧ��
@REM if exist %Upath%:\Edgeless\Config\AutoUnattend echo %time% Launcher-����ȫ���Զ�Ӧ�𿪹� >>X:\Users\Log.txt
@REM if exist %Upath%:\Edgeless\Config\AutoUnattend pecmd file X:\Users\Imdisk\AutoUnattend.xml=>X:\AutoUnattend.xml

@REM ::��Ӧչ����Դ������������
@REM if exist %Upath%:\Edgeless\Config\UnfoldRibbon echo %time% Launcher-��Ӧչ����Դ���������������� >>X:\Users\Log.txt
@REM if exist %Upath%:\Edgeless\Config\UnfoldRibbon reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /f /v "ExplorerRibbonStartsMinimized" /t REG_DWORD /d 2

@REM ::��Ӧ�������з���
@REM if exist %Upath%:\Edgeless\Config\MountEveryPartition echo %time% Launcher-��Ӧ��ʾ���з��� >>X:\Users\Log.txt
@REM if exist %Upath%:\Edgeless\Config\MountEveryPartition pecmd SHOW =1 *

@REM ::���ڲ�������������
@REM if exist %Upath%:\Edgeless\Config\NoOutDateCheck echo %time% Launcher-��Ӧ���ù��ڲ������⿪�� >>X:\Users\Log.txt
@REM if not exist %Upath%:\Edgeless\Config\NoOutDateCheck pecmd exec !"%ProgramFiles%\Edgeless\plugin_outdatedcheck\compare.cmd"

@REM ::���ڷֱ���
@REM if defined disp (
@REM   if "%disp%"=="DisableAutoSuit" echo %time% Launcher-��鵽DisableAutoSuit�������ֱ������� >>X:\Users\Log.txt
@REM   if "%disp%"=="DisableAutoSuit" goto endAutoSuit
@REM )
@REM xcmd disp %disp%
@REM echo %time% Launcher-���÷ֱ��ʽ��� >>X:\Users\Log.txt
@REM :endAutoSuit

@REM ::Edgeless�ļ�������
@REM cd /d "%ProgramFiles%\Edgeless"
@REM if not exist ��װ���� md ��װ����
@REM move /y *.cmd ��װ����
@REM move /y *.wcs ��װ����
@REM move /y Nes.ini ��װ����
@REM cd ��װ����
@REM echo ��Ŀ¼��Ų�����İ�װ���� > ˵��.txt
@REM echo ����ʹ�ã��뽫���Ƶ��ϼ�Ŀ¼������ >> ˵��.txt
@REM echo %time% Launcher-���������˳� >>X:\Users\Log.txt

@REM ::ɾ��������־�ļ�
@REM for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\ErrorLog.txt del /f /q %%1:\Edgeless\ErrorLog.txt

::���д���ԭ����ʾ
::if defined errorTip call "X:\Program Files\Edgeless\dynamic_creator\dynamic_msgbox.cmd" Edgeless��ʼ������ Edgeless���Զ��޸���һ����������ԭ�������Ļ����ڴ��С����������ർ�±�����������ò��ֲ������
exit

@REM :skipsetup
@REM echo %time% Launcher-�û�ѡ��SkipSetup�������˳� >>X:\Users\Log.txt
@REM call "X:\Program Files\Edgeless\plugin_loader\load.cmd" "X:\Program Files\Ӧ����.7z"
@REM rd x:\users\autoretry
@REM cd /d X:\Windows\System32
@REM pecmd link "X:\Users\Default\Desktop\���¼���","X:\Program Files\Launcher.bat"
@REM exit

@REM :autoretry
@REM md x:\users\autoretry
@REM pecmd wait 2500
@REM echo %time% Launcher-���е�һ������ >>X:\Users\Log.txt
@REM goto begin