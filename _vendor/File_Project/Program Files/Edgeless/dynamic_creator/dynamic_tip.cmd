cd /d "%ProgramFiles%\Edgeless\dynamic_creator"
echo %time% ��̬��ʾ���ɳ���-Tip-���� >>X:\Users\Log.txt
set /a timeoutWait=%1+1000
if not defined timeoutWait echo %time% ��̬��ʾ���ɳ���-Tip-��ʱ����ʧ�ܣ��˳� >>X:\Users\Log.txt
if not defined timeoutWait exit

echo %1 >timeout.txt
echo %2 >title.txt
echo %3 >content.txt
set /p timeout=<timeout.txt
set /p title=<title.txt
set /p content=<content.txt

echo %time% ��̬��ʾ���ɳ���-Tip-��ʱ��%timeout%�����⣺%title%�����ݣ�%content% >>X:\Users\Log.txt

echo TIPS %title:~0,-1%,%content:~0,-1%,%timeout:~0,-1%,4, >tip.txt
echo WAIT %timeoutWait% >>tip.txt
del /f /q tip.wcs
ren tip.txt tip.wcs
start xcmd.exe tip.wcs