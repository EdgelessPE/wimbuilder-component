@echo off
echo %time% �����³���-���� >>X:\Users\Log.txt
title ���ڼ��Edgeless����
color 3f
cd /d %~dp0"
set /p vnw=<"X:\Program Files\version.txt"
echo %time% �����³���-wim��Ϣ%vnw% >>X:\Users\Log.txt


if %vnw:~9,4%==Alpa goto alpha

if not exist version_ol.txt "X:\Program Files\Edgeless\EasyDown\aria2c.exe" -x16 -c -o "version_ol.txt" https://pineapple.edgeless.top/api/v2/info/iso_version
::if not exist version_ol.txt "X:\Program Files\Edgeless\EasyDown\EasyDown.exe" -Down("http://s.edgeless.top/?token=version","version_ol.txt","X:\Program Files\Edgeless\system_update")
if not exist version_ol.txt goto df
set /p vol=<version_ol.txt
echo %time% �����³���-����Beta��Ϣ%vol% >>X:\Users\Log.txt

if %vol%==%vnw:~20,5% goto newest
title ���ִ���Edgeless����
cls
echo.
echo.
echo   ��ǰ�汾��%vnw:~20,5%
echo   ���°汾��%vol%
echo =========================================
echo.
echo.
echo  �������ص�����ϵͳ��ʹ��Edgeless Hub����
echo.
echo.
echo.
echo.
echo.
pause
exit
:ctn
for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\version.txt echo %%1>Npath.txt
set /p Upath=<Npath.txt
echo %time% �����³���-ʹ��%Upath%��ΪEdgeless�̷� >>X:\Users\Log.txt
if not exist %Upath%:\ (
    echo %time% �����³���-δ��⵽�Ϸ���Edgeless������ >>X:\Users\Log.txt
    cls
    echo      δ��⵽�Ϸ���Edgeless������
    echo   �����Edgeless�����̣�Ȼ�������
    pause
    goto ctn
)
if exist "X:\Program Files\Edgeless\Edgeless Hub\edgeless-hub.exe" goto skipDownHub
title ��������Edgeless Hub
echo %time% �����³���-����Edgeless Hub >>X:\Users\Log.txt
cls
call downloadhub.cmd
pecmd exec="X:\Program Files\Edgeless\plugin_loader\load.cmd" "X:\Program Files\Edgeless\system_update\hub.7z"

if not exist "X:\Program Files\Edgeless\Edgeless Hub\edgeless-hub.exe" (
    echo %time% �����³���-Edgeless Hubδ���أ���ִ��� >>X:\Users\Log.txt
    cls
    title �����˺���ֵ����⣺Edgeless Hubδ����
    call downloadhub.cmd
    pecmd exec="X:\Program Files\Edgeless\plugin_loader\load.cmd" "X:\Program Files\Edgeless\system_update\hub.7z"
)

:skipDownHub
pecmd link "X:\Users\Default\Desktop\Edgeless Hub.LNK" "X:\Program Files\Edgeless\Edgeless Hub\edgeless-hub.exe"
pecmd exec  "X:\Program Files\Edgeless\Edgeless Hub\edgeless-hub.exe"
exit



:df
title ���ڼ������
ping cloud.tencent.com
if %errorlevel%==1 goto nonet
title Edgeless����������Ӧ
echo %time% �����³���-����������Ӧ >>X:\Users\Log.txt
cls
echo.
echo.
echo.
echo         ���ʧ�ܣ�Edgeless����������Ӧ
echo               ����ϵ���߽��������
echo.
echo.
pause
del /f /q version_ol.txt
exit


:nonet
echo %time% �����³���-Edgelessδ���� >>X:\Users\Log.txt
title �޷�������������
cls
echo.
echo.
echo.
echo         ���ʧ�ܣ���ǰϵͳδ���뻥����
echo.
echo.
echo.
pause
del /f /q version_ol.txt
exit

:newest
echo %time% �����³���-�������°汾 >>X:\Users\Log.txt
title ��ǰ�汾�������°汾
cls
echo.
echo.
echo.
echo  ��ϲ����ǰ�汾�����°汾��
echo =========================================
echo �汾��Ϣ��
echo �����汾�ţ�%vnw%
echo ϵͳ���ƣ�%vnw:~0,8%
echo �������ͣ�%vnw:~9,4%
echo ���а汾��%vnw:~14,5%
echo �汾��ţ�%vnw%
echo =========================================
echo.
echo.
echo.
pause
del /f /q version_ol.txt
exit


:alpha
if not exist "X:\Program Files\Edgeless\system_update\version_ola.txt" "X:\Program Files\Edgeless\EasyDown\aria2c.exe" -x16 -c -o "version_ola.txt" https://pineapple.edgeless.top/api/v2/alpha/version?token=WDNMD
::if not exist "X:\Program Files\Edgeless\system_update\version_ola.txt" "X:\Program Files\Edgeless\EasyDown\EasyDown.exe" -Down("http://s.edgeless.top/?token=alpha","version_ola.txt","X:\Program Files\Edgeless\system_update")
if not exist "X:\Program Files\Edgeless\system_update\version_ola.txt" goto df
set /p voa=<"X:\Program Files\Edgeless\system_update\version_ola.txt"

if not exist "X:\Program Files\Edgeless\system_update\version_ol.txt" "X:\Program Files\Edgeless\EasyDown\aria2c.exe" -x16 -c -o "version_ol.txt" https://pineapple.edgeless.top/api/v2/info/iso_version
::if not exist "X:\Program Files\Edgeless\system_update\version_ol.txt" "X:\Program Files\Edgeless\EasyDown\EasyDown.exe" -Down("http://s.edgeless.top/?token=version","version_ol.txt","X:\Program Files\Edgeless\system_update")
if not exist "X:\Program Files\Edgeless\system_update\version_ol.txt" goto df
set /p vol=<"X:\Program Files\Edgeless\system_update\version_ol.txt"

echo %time% �����³���-����Alpha��Ϣ%voa% >>X:\Users\Log.txt
echo %time% �����³���-����Beta��Ϣ%vol% >>X:\Users\Log.txt

title Edgeless Alpha�ڲ��
cls
echo.
echo           Edgeless Alpha�ڲ��
echo        ��л����Edgeless��Ŀ��֧�֣�
echo ===============================================
echo ��ǰ�汾��%vnw%
echo ���°汾��Alpha�ڲ⣩��%voa%
echo ���°汾��Beta ��ʽ����%vol%
echo ===============================================
echo.
echo  Alpha�汾���ṩOTA�������Ҫ�������ֶ����и���
echo.
echo.
pause
exit