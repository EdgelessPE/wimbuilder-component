@echo off
echo %time% load.cmd-���У���һ������%1 >>X:\Users\Log.txt
echo %1 >X:\Users\tarplug.txt
set /p t=<X:\Users\tarplug.txt
echo %time% load.cmd-���У���ϴ��Ĳ�����%t%��ȥ���ŵĲ�����%t:~1,-2%������load.wcs >>X:\Users\Log.txt
echo %t:~1,-2%>X:\Users\tarplug.txt
echo �����ȼ��ز�������Ժ�...
pecmd load "X:\Program Files\Edgeless\plugin_loader\load.wcs"
del /f /q X:\Users\tarplug.txt
echo %time% load.cmd-������� >>X:\Users\Log.txt