@echo off
echo %time% ept-upgrade-���У���һ������%1 >>X:\Users\Log.txt
set /a retryTime=0
if exist Spath.txt del /f /q Spath.txt
if exist Y_u.txt del /f /q Y_u.txt
if exist X:\Users\ept\upgrade\DontLoad.txt del /f /q X:\Users\ept\upgrade\DontLoad.txt
if exist X:\Users\ept\upgrade\Retry.txt del /f /q X:\Users\ept\upgrade\Retry.txt

::ɨ��Edgeless�����̣����ǲ�ȡ����ֵ���������
for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\version_Disk.txt echo %%1>Spath.txt
for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\version.txt echo %%1>Spath.txt
if not exist Spath.txt (
    echo ept-upgrade �������Ч��Edgeless������
    echo %time% ept-upgrade-û�м�⵽������ >>X:\Users\Log.txt
    goto exitUpgrade
)
if exist Spath.txt del /f /q Spath.txt

::���а汾�űȶԽű�
echo ept-upgrade ���ڶԱȲ����Ϣ...
pecmd load "X:\Program Files\Edgeless\plugin_ept\ept-upgrade.wcs"

::��wcs�ű�ͬ��Edgeless�̷�
set /p EL_Part=<X:\Users\ept\upgrade\EL_Part.txt
if not defined EL_Part set /p EL_Part=<Spath.txt
if exist Spath.txt del /f /q Spath.txt

if not defined EL_Part (
    echo ept-upgrade ��ֵĴ���Edgeless�̷�δ����
    echo %time% ept-upgrade-��ֵĴ���Edgeless�̷�δ���� >>X:\Users\Log.txt
    goto endUpgrade
)

if not exist "X:\Users\ept\upgrade\UpgradeList_User.txt" (
    if not exist X:\Users\ept\upgrade\UpgradeList_Invaild.txt echo ept-upgrade û�п��������Ĳ��
    echo %time% ept-upgrade-û�п��������Ĳ�� >>X:\Users\Log.txt
    if exist X:\Users\ept\upgrade\UpgradeList_Invaild.txt (
        echo %time% ept-upgrade-����δ֪������г��� >>X:\Users\Log.txt
        type X:\Users\ept\upgrade\UpgradeList_Invaild.txt >>X:\Users\Log.txt
        echo ept-upgrade û�п��������Ĳ��������eptע�⵽��һЩ�޷�ʶ��Ĳ�������ֶ���ע����������
        echo.
        echo ----------
        type X:\Users\ept\upgrade\UpgradeList_Invaild.txt
        echo ----------
        echo.
    )
    goto endUpgrade
)
echo ept-upgrade ��⵽���¸���
echo.
echo ----------
type "X:\Users\ept\upgrade\UpgradeList_User.txt"
echo ----------
echo.

if /i "%1" == "-y" echo ept-upgrade ����ִ���Զ�����
if /i "%1" == "-b" echo ept-upgrade ����ִ���Զ����µ��ǲ�����
if /i "%1" == "-y" echo Y >Y_u.txt
if /i "%1" == "-b" echo Y >Y_u.txt
if /i "%1" == "-b" echo B >X:\Users\ept\upgrade\DontLoad.txt
if exist Y_u.txt echo %time% ept-upgrade-Y_u.txt������� >>X:\Users\Log.txt

if not exist Y_u.txt CHOICE /C ybn /M "��ϣ����ʼִ�и�����?������/������/ȡ����"
if %errorlevel%==3 goto endUpgrade
if %errorlevel%==2 echo B >X:\Users\ept\upgrade\DontLoad.txt
echo %time% ept-upgrade-�û�ȷ�Ͻ��и��£�ѡ��%errorlevel% >>X:\Users\Log.txt
if exist X:\Users\ept\upgrade\DontLoad.txt echo %time% ept-upgrade-DontLoad.txt������� >>X:\Users\Log.txt

echo Start >X:\Users\ept\upgrade\UpgradeTime.txt

echo ept-upgrade ����ת�ƹ��ڵĲ����...
if not exist %EL_Part%:\Edgeless\Resource\���ڲ���� md %EL_Part%:\Edgeless\Resource\���ڲ����
if not exist %EL_Part%:\Edgeless\Resource\���ڲ���� (
    echo ept-upgrade ��%EL_Part%�̵ķ�����ܾ������������
    echo %time% ept-upgrade-��%EL_Part%�̵ķ�����ܾ� >>X:\Users\Log.txt
    goto endUpgrade
)
for /f "usebackq delims==; tokens=*" %%i in ("X:\Users\ept\upgrade\UpgradeList_Path.txt") do (
    move /y "%%i" %EL_Part%:\Edgeless\Resource\���ڲ���� >nul
)
ren %EL_Part%:\Edgeless\Resource\���ڲ����\*.7z *.7zf


echo ept-upgrade ��ʼ���ظ��£��ּ�������ں�ɫ���ֻᵼ�³�����ͣ
:reDown
for /f "usebackq delims==; tokens=*" %%i in ("X:\Users\ept\upgrade\UpgradeList_Name.txt") do (
    echo ept-upgrade ���ڸ���%%i
    if exist X:\Users\ept\DownloadFail.txt del /f /q X:\Users\ept\DownloadFail.txt >nul
    if exist X:\Users\ept\SaveFail.txt del /f /q X:\Users\ept\SaveFail.txt >nul
    pecmd exec =!cmd.exe /c "ept-install %%i -a"
    if exist X:\Users\ept\DownloadFail.txt (
        echo ept-upgrade =============��������%%iʧ��=============
        echo.
        echo %time% ept-upgrade-��������%%iʧ�� >>X:\Users\Log.txt
        echo %%i>>X:\Users\ept\upgrade\Retry.txt
    )
    if exist X:\Users\ept\SaveFail.txt (
        echo ept-upgrade =============���󣺱���%%iʧ��=============
        echo.
        echo %time% ept-upgrade-���󣺱���%%iʧ�� >>X:\Users\Log.txt
        echo %%i>>X:\Users\ept\upgrade\Retry.txt
    )
)
echo %time% ept-upgrade-��ǰ������������ɣ������Ҫ���ԵĲ�� >>X:\Users\Log.txt
if "%retryTime%"=="1" (
    if exist Y_u.txt (
        echo %time% ept-upgrade-�Զ�ģʽ����ǰ�Ѿ�����һ�Σ��Զ��˳� >>X:\Users\Log.txt
        echo ept-upgrade �����Զ����������²���ĸ���ʧ�ܣ����ֶ����þɰ汾��
        type X:\Users\ept\upgrade\Retry.txt
        goto endUpgrade
    )
)
if not exist X:\Users\ept\upgrade\Retry.txt goto skipRetry

    echo ept-upgrade ׼����ʼ��ʧ�ܵ���Ŀ�������ԣ���ǰ���Դ�����%retryTime%����Ҫ���ԵĲ���У�
    type X:\Users\ept\upgrade\Retry.txt
    if not exist Y_u.txt CHOICE /C yn /M "��ϣ����ʼ������?��ȷ��/ȡ����"
    echo.
    if %errorlevel%==2 (
        echo ept-upgrade ���²���ĸ���ʧ�ܣ����ֶ����þɰ汾��ResourceĿ¼�µġ����ڲ�������ļ��У���
        type X:\Users\ept\upgrade\Retry.txt
        goto endUpgrade
    )
    set /a retryTime+=1
    echo %time% ept-upgrade-��ʼ��ʧ�ܵ���Ŀ���ԣ����Դ�����%retryTime%����Ҫ���ԵĲ���У� >>X:\Users\Log.txt
    type X:\Users\ept\upgrade\Retry.txt >>X:\Users\Log.txt
    if exist X:\Users\ept\upgrade\UpgradeList_Name.txt del /f /q X:\Users\ept\upgrade\UpgradeList_Name.txt
    ren X:\Users\ept\upgrade\Retry.txt UpgradeList_Name.txt
    goto reDown

:skipRetry
if exist X:\Users\ept\upgrade\UpgradeTime.txt del /f /q X:\Users\ept\upgrade\UpgradeTime.txt
if exist X:\Users\ept\upgrade\UpgradeList_Invaild.txt (
    echo ept-upgrade ������ɣ�����eptע�⵽��һЩ�޷�ʶ��Ĳ�������ֶ���ע����������
        echo %time% ept-upgrade-����δ֪������г��� >>X:\Users\Log.txt
        type X:\Users\ept\upgrade\UpgradeList_Invaild.txt >>X:\Users\Log.txt
        echo.
        echo ----------
        type X:\Users\ept\upgrade\UpgradeList_Invaild.txt
        echo ----------
        echo.
)
if not exist X:\Users\ept\upgrade\UpgradeList_Invaild.txt echo ept-upgrade �������

:endUpgrade
if exist X:\Users\ept\upgrade\Retry.txt del /f /q X:\Users\ept\upgrade\Retry.txt
if not exist "X:\Users\ept\upgrade\RenameList_FullName.txt" (
    echo ept-upgrade û��7zl��Ҫ�����˳� >>X:\Users\Log.txt
    goto exitUpgrade
)

::�ָ�û�б�������7zl�ļ�
echo ept-upgrade ��ԭδ������7zl���������£� >>X:\Users\Log.txt
type X:\Users\ept\upgrade\RenameList_FullName.txt >>X:\Users\Log.txt
for /f "usebackq delims==; tokens=*" %%i in ("X:\Users\ept\upgrade\RenameList_FullName.txt") do (
    echo ept-upgrade ��飺"%EL_Part%:\Edgeless\Resource\%%i.7z" >>X:\Users\Log.txt
    if exist "%EL_Part%:\Edgeless\Resource\%%i.7z" echo ept-upgrade ��ԭδ������7zl��%%i >>X:\Users\Log.txt
    if exist "%EL_Part%:\Edgeless\Resource\%%i.7z" ren "%EL_Part%:\Edgeless\Resource\%%i.7z" "%%i.7zl"
)

::ƥ�䱻������7zl�ļ�����������
dir /b "%EL_Part%:\Edgeless\Resource\*.7z">X:\Users\ept\upgrade\7zList.txt
echo ept-upgrade ׼����ԭ������7zl������7z������ >>X:\Users\Log.txt
type X:\Users\ept\upgrade\7zList.txt >>X:\Users\Log.txt
for /f "usebackq delims==; tokens=*" %%i in ("X:\Users\ept\upgrade\RenameList_Name.txt") do (
    echo %%i>X:\Users\ept\upgrade\matchName.txt
    call ept-upgrade-getmatch.cmd
)
echo ept-upgrade ƥ�䵽��7zl�ļ������� >>X:\Users\Log.txt
type X:\Users\ept\upgrade\7zlMatch.txt >>X:\Users\Log.txt

::�������ϵ����в����������չ��Ϊ7zl
for /f "usebackq delims==; tokens=*" %%i in ("X:\Users\ept\upgrade\7zlMatch.txt") do (
    echo ept-upgrade ��飺"%EL_Part%:\Edgeless\Resource\%%i" >>X:\Users\Log.txt
    if exist "%EL_Part%:\Edgeless\Resource\%%i" echo ept-upgrade ��ԭ������7zl��%%i >>X:\Users\Log.txt
    if exist "%EL_Part%:\Edgeless\Resource\%%i" ren "%EL_Part%:\Edgeless\Resource\%%i" "%%il"
)

:exitUpgrade
echo ept-upgrade �����˳� >>X:\Users\Log.txt
@echo on