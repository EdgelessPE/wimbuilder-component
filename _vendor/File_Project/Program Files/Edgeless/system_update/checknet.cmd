echo %time% ��������س���-checknet-������� >>X:\Users\Log.txt
title ���ڼ�������������
ping cloud.tencent.com
if %errorlevel%==1 goto nonet
title Edgeless����������Ӧ
echo %time% �����³���-checknet-����������Ӧ >>X:\Users\Log.txt
cls
echo.
echo.
echo.
echo         ����ʧ�ܣ�Edgeless����������Ӧ
echo               ����ϵ���߽��������
echo.
echo.
pause
exit


:nonet
title �޷�������������
echo %time% �����³���-checknet-Edgelessδ���� >>X:\Users\Log.txt
cls
echo.
echo.
echo.
echo         ����ʧ�ܣ���ǰϵͳδ���뻥����
echo.
echo.
echo.
pause
exit