cd /d "%ProgramFiles%\Edgeless\dynamic_creator"
echo %time% ��̬��ʾ���ɳ���-msgbox-���� >>X:\Users\Log.txt
echo %1 >mtitle.txt
echo %2 >mcontent.txt
set /p title=<mtitle.txt
set /p content=<mcontent.txt

echo %time% ��̬��ʾ���ɳ���-msgbox-���⣺%title%�����ݣ�%content% >>X:\Users\Log.txt

echo msgbox "%content%",64,"%title%">alert.vbs && start alert.vbs && ping -n 2 127.1>nul && del alert.vbs
