@echo off
cd /d "%~dp0"
set /p w=<Target.txt
set /p n=<name.txt
if exist php.txt set /p php=<php.txt
if exist savepath.txt set /p savepath=<savepath.txt
if exist savename.txt set /p savename=<savename.txt
echo %time% ��������س���-���� >>X:\Users\Log.txt
echo %time% ��������س���-�������ƣ�%n% >>X:\Users\Log.txt
echo %time% ��������س���-����Token��%w% >>X:\Users\Log.txt
if exist php.txt echo %time% �Զ������س���-PHP���ƣ�%php% >>X:\Users\Log.txt
if exist savepath.txt echo %time% �Զ������س���-����·����%savepath% >>X:\Users\Log.txt
if exist savepath.txt echo %time% �Զ������س���-�������ƣ�%savename% >>X:\Users\Log.txt
set noRetry=f
if defined php goto selfSetDown

:home
cls
title Edgeless���������-��������%n%
color 3f
if exist "X:\Program Files\Edgeless\plugin_downloader\tar.7zf" del /f /q "X:\Program Files\Edgeless\plugin_downloader\tar.7zf"
"X:\Program Files\Edgeless\EasyDown\aria2c.exe" -x16 -c -o "tar.7zf" http://s.edgeless.top/?token=%w%
::"X:\Program Files\Edgeless\EasyDown\EasyDown.exe" -Down("http://s.edgeless.top/?token=%w%","tar.7zf","X:\Program Files\Edgeless\plugin_downloader")
if not exist "X:\Program Files\Edgeless\plugin_downloader\tar.7zf" goto df
echo %time% ��������س���-���سɹ� >>X:\Users\Log.txt
start pecmd load over.wcs
exit


:df
echo %time% ��������س���-������� >>X:\Users\Log.txt
cls
title ���ڼ������
ping cloud.tencent.com
if %errorlevel%==1 goto nonet
if %noRetry%==f goto retry
title Edgeless����������Ӧ
echo %time% ��������س���-����������Ӧ�����Զ����ԣ� >>X:\Users\Log.txt
cls
echo.
echo.
echo.
echo         ����ʧ�ܣ�Edgeless����������Ӧ
echo               ����ϵ���߽��������
echo.
echo.
pause
start pecmd load GUI.wcs
exit


:nonet
title �޷�������������
echo %time% ��������س���-Edgelessδ���� >>X:\Users\Log.txt
cls
echo.
echo.
echo.
echo         ����ʧ�ܣ���ǰϵͳδ���뻥����
echo.
echo.
echo.
pause
start pecmd load GUI.wcs
exit

:retry
set noRetry=t
echo %time% ��������س���-׼���Զ����� >>X:\Users\Log.txt
cls
echo.
echo   Edgeless���������ڽ������ص�ַ�����Ժ�...
echo         ������3������·�����������
pecmd wait 3000
goto home


:selfSetDown
cls
if not defined savepath goto error
if not defined savename goto error
set noRetry=t
title Edgeless�Զ���������-��������%n%
color 3f
if exist "%savepath%%savename%" del /f /q "%savepath%%savename%"
cd /d "%savepath%"
"X:\Program Files\Edgeless\EasyDown\aria2c.exe" -x16 -c -o "%savename%" http://s.edgeless.top/?token=%w%
cd /d "%~dp0"
::"X:\Program Files\Edgeless\EasyDown\EasyDown.exe" -Down("http://s.edgeless.top/%php%.php?token=%w%","%savename%","%savepath%")
if not exist "%savepath%%savename%" goto df
echo %time% �Զ������س���-���سɹ� >>X:\Users\Log.txt
explorer "%savepath%"
cd /d X:\Windows\System32
pecmd exec "%savepath%%savename%"
exit



:error
title ������һЩ����
echo %time% �Զ������س���-�������岻��ȫ >>X:\Users\Log.txt
cls
echo.
echo.
echo.
echo       ����ʧ�ܣ����ǵĳ�������˴���ʧ�ܵĴ���
echo               ����ϵ���߽��������
echo.
echo.
echo.
pause
exit
