@echo off
echo %time% ept-remove-���У���һ������%1���ڶ�������%2 >>X:\Users\Log.txt
if not exist X:\Users\ept md X:\Users\ept
if exist X:\Users\ept\List del /f /q X:\Users\ept\List >nul
if exist X:\Users\Plugins_info\List_Preload.txt type X:\Users\Plugins_info\List_Preload.txt >X:\Users\ept\List
if exist X:\Users\Plugins_info\List_Hotload.txt type X:\Users\Plugins_info\List_Hotload.txt >>X:\Users\ept\List
if exist X:\Users\Plugins_info\List_LocalBoost.txt type X:\Users\Plugins_info\List_LocalBoost.txt >>X:\Users\ept\List
if not exist "X:\Users\ept\List" (
    echo %time% ept-remove-List�ѿ� >>X:\Users\Log.txt
    echo ept-remove ����ѱ�ȫ���Ƴ�
    goto end
)
setlocal enabledelayedexpansion
set /a row=0
echo ept-remove ���ڶ�ȡ�����Ϣ...
echo %time% ept-remove-��ʼ����List >>X:\Users\Log.txt
for /f "usebackq delims==; tokens=*" %%i in (X:\Users\ept\List) do (
    set /a row+=1
    if !row!==%1 echo %%i >tmp.txt
)
if not exist tmp.txt (
    echo %time% ept-remove-������tmp.txt����ת��search��ǩ >>X:\Users\Log.txt
    goto search
)
if /i "%2" == "-y" echo ept-remove ����ִ���Զ��Ƴ�
set /p tar=<tmp.txt
echo %time% ept-remove-tar:%tar% >>X:\Users\Log.txt
if exist tmp.txt del /f /q tmp.txt >nul
if /i "%2" neq "-y" CHOICE /C yn /M "���Ƿ�ȷ���Ƴ�%tar:~0,-1%?"
if %errorlevel%==2 goto end
echo %time% ept-remove-�û�ȷ�Ͽ�ʼ�Ƴ�����ʼ�ƶ�������������װ����Ŀ¼ >>X:\Users\Log.txt

if not exist "%ProgramFiles%\Edgeless\��װ����" md "%ProgramFiles%\Edgeless\��װ����"
if exist "X:\Program Files\Edgeless\*.cmd" copy /y "X:\Program Files\Edgeless\*.cmd" "X:\Program Files\Edgeless\��װ����\" >nul
if exist "X:\Program Files\Edgeless\*.wcs" copy /y "X:\Program Files\Edgeless\*.wcs" "X:\Program Files\Edgeless\��װ����\" >nul

echo %time% ept-remove-��ʼ׷�ݲ����ݷ�ʽ >>X:\Users\Log.txt
echo ept-remove ����׷��%tar:~0,-1%�����Ŀ�ݷ�ʽ...
if exist run.wcs del /f /q run.wcs
if exist run.cmd del /f /q run.cmd
if exist "X:\Program Files\Edgeless\run.wcs" del /f /q "X:\Program Files\Edgeless\run.wcs"
if exist "X:\Program Files\Edgeless\run.cmd" del /f /q "X:\Program Files\Edgeless\run.cmd"
for /f "usebackq delims==; tokens=*" %%i in ("X:\Users\Plugins_info\Batch\%tar:~0,-1%.txt") do (
    findstr /i "Desktop" "X:\Program Files\Edgeless\��װ����\%%i">run.wcs
)
echo %time% ept-remove-���ڴ�����ݷ�ʽ����伯�ϣ� >>X:\Users\Log.txt
type run.wcs >>X:\Users\Log.txt
if not exist run.wcs (
    echo ept-remove ���δ���������ݷ�ʽ��ʹ�ö������ļ�����
    echo %time% ept-remove-���δ���������ݷ�ʽ��������run.wcs >>X:\Users\Log.txt
    goto skipRLink
)
set nullCheck=
set /p nullCheck=<run.wcs
if not defined nullCheck (
    echo ept-remove ���δ���������ݷ�ʽ��ʹ�ö������ļ�����
    echo %time% ept-remove-���δ���������ݷ�ʽ��run.wcsΪ�� >>X:\Users\Log.txt
    goto skipRLink
)
pecmd file X:\Users\Default\Desktop\tmp
if not exist X:\Users\Default\Desktop\tmp md X:\Users\Default\Desktop\tmp
move "X:\Users\Default\Desktop\*.lnk" X:\Users\Default\Desktop\tmp >nul

move /y run.wcs "X:\Program Files\Edgeless\run.wcs" >nul
pecmd load "X:\Program Files\Edgeless\run.wcs"
ren "X:\Program Files\Edgeless\run.wcs" run.cmd
pecmd exec !"X:\Program Files\Edgeless\run.cmd"
del /f /q "X:\Program Files\Edgeless\run.cmd"

if not exist "X:\Users\Default\Desktop\*.lnk" (
    echo ept-remove ��ǰ����������ݷ�ʽ��ʧЧ��׷��ʧ��
    echo %time% ept-remove-��ݷ�ʽ��ʧЧ��׷��ʧ�ܣ�������.lnk�ļ� >>X:\Users\Log.txt
    move X:\Users\Default\Desktop\tmp\*.lnk X:\Users\Default\Desktop >nul
    pecmd file X:\Users\Default\Desktop\tmp
    goto skipRLink
)
dir /b "X:\Users\Default\Desktop\*.lnk">link.txt
echo %time% ept-remove-�ռ����Ŀ�ݷ�ʽ�� >>X:\Users\Log.txt
type link.txt >>X:\Users\Log.txt

if exist "X:\Users\Default\Desktop\*.lnk" del /f /q "X:\Users\Default\Desktop\*.lnk"
move X:\Users\Default\Desktop\tmp\*.lnk X:\Users\Default\Desktop >nul
pecmd file X:\Users\Default\Desktop\tmp

if not exist link.txt (
    echo ept-remove ��ǰ����������ݷ�ʽ��ʧЧ��׷��ʧ��
    echo %time% ept-remove-��ݷ�ʽ��ʧЧ��׷��ʧ�ܣ�link.txt����ʧ�� >>X:\Users\Log.txt
    goto skipRLink
)
for /f "usebackq delims==; tokens=*" %%i in ("link.txt") do (
    pecmd file "X:\Users\Default\Desktop\%%i"
)
del /f /q link.txt

:skipRLink
echo ept-remove �����Ƴ�%tar:~0,-1%...
if not exist "X:\Users\Plugins_info\Dir\%tar:~0,-1%.txt" (
    echo %time% ept-remove-δ�����ļ��� >>X:\Users\Log.txt
    goto skipRD
)
for /f "usebackq delims==; tokens=*" %%i in ("X:\Users\Plugins_info\Dir\%tar:~0,-1%.txt") do (
    pecmd file "X:\Program Files\Edgeless\%%i"
)
:skipRD

if not exist "X:\Users\Plugins_info\File\%tar:~0,-1%.txt" (
    echo %time% ept-remove-δ�����ļ� >>X:\Users\Log.txt
    goto skipRF
)
for /f "usebackq delims==; tokens=*" %%i in ("X:\Users\Plugins_info\File\%tar:~0,-1%.txt") do (
    pecmd file "X:\Program Files\Edgeless\%%i"
)
:skipRF

echo ept-remove ���ڸ��²����Ϣ...
echo %time% ept-remove-��ʼ���²����Ϣ��List_Preload.txt�������£� >>X:\Users\Log.txt
if exist X:\Users\Plugins_info\List_Preload.txt type X:\Users\Plugins_info\List_Preload.txt >>X:\Users\Log.txt
echo %time% ept-remove-List_Hotload.txt�������£� >>X:\Users\Log.txt
if exist X:\Users\Plugins_info\List_Hotload.txt type X:\Users\Plugins_info\List_Hotload.txt >>X:\Users\Log.txt
echo %time% ept-remove-List_LocalBoost.txt�������£� >>X:\Users\Log.txt
if exist X:\Users\Plugins_info\List_LocalBoost.txt type X:\Users\Plugins_info\List_LocalBoost.txt >>X:\Users\Log.txt

if not exist X:\Users\Plugins_info\List_Preload.txt goto skipUpdatePreloadList
if exist X:\Users\Plugins_info\List_Preload_backup.txt del /f /q X:\Users\Plugins_info\List_Preload_backup.txt
ren X:\Users\Plugins_info\List_Preload.txt List_Preload_backup.txt
for /f "usebackq delims==; tokens=*" %%i in ("X:\Users\Plugins_info\List_Preload_backup.txt") do (
    if "%%i" neq "%tar:~0,-1%" echo %%i>>X:\Users\Plugins_info\List_Preload.txt
)
:skipUpdatePreloadList

if not exist X:\Users\Plugins_info\List_Hotload.txt goto skipUpdateHotloadList
if exist X:\Users\Plugins_info\List_Hotload_backup.txt del /f /q X:\Users\Plugins_info\List_Hotload_backup.txt
ren X:\Users\Plugins_info\List_Hotload.txt List_Hotload_backup.txt
for /f "usebackq delims==; tokens=*" %%i in ("X:\Users\Plugins_info\List_Hotload_backup.txt") do (
    if "%%i" neq "%tar:~0,-1%" echo %%i>>X:\Users\Plugins_info\List_Hotload.txt
)
:skipUpdateHotloadList

if not exist X:\Users\Plugins_info\List_LocalBoost.txt goto skipUpdateLocalBoostList
if exist X:\Users\Plugins_info\List_LocalBoost_backup.txt del /f /q X:\Users\Plugins_info\List_LocalBoost_backup.txt
ren X:\Users\Plugins_info\List_LocalBoost.txt List_LocalBoost_backup.txt
if exist X:\Users\LocalBoost\removeFromRepo rd X:\Users\LocalBoost\removeFromRepo
for /f "usebackq delims==; tokens=*" %%i in ("X:\Users\Plugins_info\List_LocalBoost_backup.txt") do (
    if "%%i" neq "%tar:~0,-1%" echo %%i>>X:\Users\Plugins_info\List_LocalBoost.txt
    if "%%i" == "%tar:~0,-1%" md X:\Users\LocalBoost\removeFromRepo
)
:skipUpdateLocalBoostList

echo %time% ept-remove-���²����Ϣ��ɣ�List_Preload.txt�������£� >>X:\Users\Log.txt
if exist X:\Users\Plugins_info\List_Preload.txt type X:\Users\Plugins_info\List_Preload.txt >>X:\Users\Log.txt
echo %time% ept-remove-List_Hotload.txt�������£� >>X:\Users\Log.txt
if exist X:\Users\Plugins_info\List_Hotload.txt type X:\Users\Plugins_info\List_Hotload.txt >>X:\Users\Log.txt
echo %time% ept-remove-List_LocalBoost.txt�������£� >>X:\Users\Log.txt
if exist X:\Users\Plugins_info\List_LocalBoost.txt type X:\Users\Plugins_info\List_LocalBoost.txt >>X:\Users\Log.txt

if exist X:\Users\LocalBoost\removeFromRepo set /p repoPart=<"X:\Users\LocalBoost\repoPart.txt"
if exist X:\Users\LocalBoost\removeFromRepo (
    echo %time% ept-remove-�����Դ��LocalBoost��׼������LocalBoost�ֿ⣬λ�ڣ�%repoPart% >>X:\Users\Log.txt
    echo ept-remove ��%repoPart%���ϵ�LocalBoost�ֿ���ɾ��%tar:~0,-1%...
    pecmd file "%repoPart%:\Edgeless\BoostRepo\%tar:~0,-1%"
)

echo ept-remove �Ƴ����
echo %time% ept-remove-�Ƴ���� >>X:\Users\Log.txt
goto end


:search
echo ept-remove �������²��
echo %time% ept-remove-����find��������£� >>X:\Users\Log.txt
find /n /i "%1" X:\Users\ept\List >>X:\Users\Log.txt
find /n /i "%1" X:\Users\ept\List
echo ----------
echo ʹ��   ept remove [���]    �Ƴ�

:end
if exist X:\Users\LocalBoost\removeFromRepo rd X:\Users\LocalBoost\removeFromRepo
echo %time% ept-remove-������� >>X:\Users\Log.txt
echo on