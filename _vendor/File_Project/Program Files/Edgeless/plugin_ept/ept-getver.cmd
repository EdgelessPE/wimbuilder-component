@if not exist X:\Users\ept\Index call ept-update >nul
@if not exist X:\Users\ept\Index goto endGetVer
@echo off
echo %time% ept-getver-���У���һ������%1����ʼ�Ե�һ����ȥ���� >>X:\Users\Log.txt
echo %1>bare_getver.txt
set /p key=<bare_getver.txt
echo %key:"=%>bare_getver.txt
set /p key=<bare_getver.txt
del /f /q bare_getver.txt
echo %time% ept-getver-��һ����ȥ���ź�Ľ����%key% >>X:\Users\Log.txt

if exist tmp.txt del /f /q tmp.txt
if exist X:\Users\ept\upgrade\ver_ol.txt del /f /q X:\Users\ept\upgrade\ver_ol.txt
findstr /i "^%key%_" X:\Users\ept\Index >tmp.txt
set checkNull=
set /p checkNull=<tmp.txt
if not defined checkNull (
    echo %time% ept-getver-�����ڴ˲�� >>X:\Users\Log.txt
    echo InvaildName
    goto endGetVer
)

echo %time% ept-getver-��ʼ����tmp.txt�����ݣ� >>X:\Users\Log.txt
type tmp.txt >>X:\Users\Log.txt
for /f "usebackq delims==_ tokens=1,2,3,4*" %%i in (tmp.txt) do (
    echo %%j>X:\Users\ept\upgrade\ver_ol.txt
)
set /p ver=<X:\Users\ept\upgrade\ver_ol.txt
echo %time% ept-getver-ver:%ver% >>X:\Users\Log.txt
echo %ver%

:endGetVer
if exist tmp.txt del /f /q tmp.txt
@echo on