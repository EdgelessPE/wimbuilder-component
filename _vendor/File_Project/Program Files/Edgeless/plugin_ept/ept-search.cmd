@if not exist X:\Users\ept\Index call ept-update
@if not exist X:\Users\ept\Index goto endSearch
@echo off
echo %time% ept-search-���У���һ������%1����ʼ�Ե�һ����ȥ���� >>X:\Users\Log.txt
echo %1>bare.txt
set /p key=<bare.txt
echo %key:"=%>bare.txt
set /p key=<bare.txt
del /f /q bare.txt
echo %time% ept-search-��һ����ȥ���ź�Ľ����%key% >>X:\Users\Log.txt
echo %time% ept-search-����find��������£� >>X:\Users\Log.txt
if exist X:\Users\ept\Result.txt del /f /q X:\Users\ept\Result.txt
find /n /i "%key%" X:\Users\ept\Index >X:\Users\ept\Result.txt
type X:\Users\ept\Result.txt >>X:\Users\Log.txt

if "%2" neq "tryhit" goto skipHit
echo %time% ept-search-����hit >>X:\Users\Log.txt
if exist tmp.txt del /f /q tmp.txt
findstr /b /n /i /c:"%key%_" X:\Users\ept\Index >tmp.txt
if not exist tmp.txt (
    echo %time% ept-search-hitʧ�ܣ���Ϊtmp.txt������ >>X:\Users\Log.txt
    goto skipHit
)
set readNull=
set /p readNull=<tmp.txt
if not defined readNull (
    echo %time% ept-search-hitʧ�ܣ���Ϊtmp.txtΪ�� >>X:\Users\Log.txt
    goto skipHit
)
echo %time% ept-search-hit�ɹ������е��У� >>X:\Users\Log.txt
type tmp.txt >>X:\Users\Log.txt

for /f "usebackq delims==: tokens=1*" %%i in (tmp.txt) do (
    echo %%i >hitNum.txt
)
set /p hitNum=<hitNum.txt
if not defined hitNum (
    echo %time% ept-search-hitʧ�ܣ���ֵ����⣺��Ž���ʧ�� >>X:\Users\Log.txt
    goto skipHit
)
echo %time% ept-search-hitNum��%hitNum% >>X:\Users\Log.txt
if exist hitNum.txt del /f /q hitNum.txt
if exist tmp.txt del /f /q tmp.txt
echo ept-search �Զ��������Ϊ%hitNum%�Ĳ��
call ept-install %hitNum% %3
@echo off
goto endSearch

:skipHit
echo ept-search �ڱ����������������²��
find /n /i "%key%" X:\Users\ept\Index
echo ----------
echo.
echo ʹ��   ept install [���] / [�����]    ��װ
:endSearch
@echo off
echo %time% ept-search-������� >>X:\Users\Log.txt