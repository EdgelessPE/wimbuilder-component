echo %time% ������س���-���� >>X:\Users\Log.txt
echo %1 >>X:\Users\Log.txt
title ���ڼ����Զ�������
color 3f
if exist "%ProgramFiles%\Edgeless\cmdlist.txt" del /f /q "%ProgramFiles%\Edgeless\cmdlist.txt"
if exist "%ProgramFiles%\Edgeless\wcslist.txt" del /f /q "%ProgramFiles%\Edgeless\wcslist.txt"
cd /d "%ProgramFiles%\Edgeless"
if not exist ��װ���� md ��װ����
ren killep.wcs killep.ini
move /y *.cmd ��װ����
move /y *.wcs ��װ����
move /y Nes.ini ��װ����
ren killep.ini killep.wcs
cd /d %~dp0
"x:\program files\7-Zip\7z.exe" x %1 -o"x:\program files\edgeless" -aoa
dir /b "%ProgramFiles%\Edgeless\*.cmd" >"%ProgramFiles%\Edgeless\cmdlist.txt"
dir /b "%ProgramFiles%\Edgeless\*.wcs" >"%ProgramFiles%\Edgeless\wcslist.txt"
echo %time% ������س���-�����������б� >>X:\Users\Log.txt
dir /b "%ProgramFiles%\Edgeless\*.cmd" >>X:\Users\Log.txt
dir /b "%ProgramFiles%\Edgeless\*.wcs" >>X:\Users\Log.txt
if exist "%ProgramFiles%\Edgeless\cmdlist.txt" (
for /f  "usebackq" %%a in  ("%ProgramFiles%\Edgeless\cmdlist.txt") do (
pecmd exec ="%ProgramFiles%\Edgeless\%%a"
  )
  )
if exist "%ProgramFiles%\Edgeless\wcslist.txt" (
dir /b "%ProgramFiles%\Edgeless\*.wcs" >"%ProgramFiles%\Edgeless\wcslist.txt"
for /f  "usebackq" %%a in  ("%ProgramFiles%\Edgeless\wcslist.txt") do (
::start "" /D "%ProgramFiles%\Edgeless\" "%%a"
pecmd load "%ProgramFiles%\Edgeless\%%a"
  )
  )
if exist "%ProgramFiles%\Edgeless\��������������\����������.exe" pecmd link "X:\Users\Default\Desktop\����������","X:\Program Files\Edgeless\��������������\����������.exe",,"X:\Users\Icon\shortcut\usbburner.ico",0
pecmd exec X:\Users\Icon\setDesktopIcon.exe
exit