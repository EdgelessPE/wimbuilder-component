echo %time% �����³���-����hub-���� >>X:\Users\Log.txt
set autoRetry=t
:home
"X:\Program Files\Edgeless\EasyDown\aria2c.exe" -x16 -c -o "hub.7z" https://pineapple.edgeless.top/api/v2/info/hub_addr
::"X:\Program Files\Edgeless\EasyDown\EasyDown.exe" -Down("http://s.edgeless.top/?token=burner","hub.7z","X:\Program Files\Edgeless\system_update")
if %autoRetry%==t goto waitForRetry
if not exist "X:\Program Files\Edgeless\system_update\hub.7z" call checknet.cmd
goto thisEnd


:waitForRetry
if exist "X:\Program Files\Edgeless\system_update\hub.7z" goto thisEnd
set autoRetry=f
echo %time% �����³���-����hub-׼���Զ����� >>X:\Users\Log.txt
cls
echo.
echo   �״�����Edgeless Hubʧ�ܣ�������3������·�����������
pecmd wait 3000
goto home

:thisEnd