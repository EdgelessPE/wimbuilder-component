@echo off
cd /d "%~dp0"
echo %time% Disk_Installer-���� >>X:\Users\Log.txt
title EdgelessӲ�̰氲װ��
color 3f
cls
echo.
echo �ڱ���ϵͳ�ϰ�װEdgeless֮������������U������½���Edgeless
echo Ŀǰ��֧��Win8/8.1/10ϵͳ��װ
echo.
echo ���������ʼɨ�豾��ϵͳ
pause >nul

::������еĸ���
echo %time% Disk_Installer-�û����������������Ѱ�װ�ĸ��� >>X:\Users\Log.txt
del /f /q UPdateP.txt
for %%1 in (C D E F G H I J K L M N O P Q R S T U V W Y Z ) do if exist %%1:\Edgeless\version_Disk.txt echo %%1>UPdateP.txt
set /p UPdatePath=<UPdateP.txt
del /f /q UPdateP.txt
if not defined UPdatePath goto scan
set /p version_usb=<"X:\Program Files\version.txt"
set /p version_disk=<%UPdatePath%:\Edgeless\version_Disk.txt
echo %time% Disk_Installer-��ȡ��Ϣ��UPdatePath��%UPdatePath%��version_usb��%version_usb%��version_disk��%version_disk% >>X:\Users\Log.txt
if "%version_disk%"=="%version_usb%" goto newest
echo %time% Disk_Installer-%UPdatePath%�̵�Edgeless�ɸ��� >>X:\Users\Log.txt
title �п��õ�EdgelessӲ�̰���£�%UPdatePath%��
cls
echo.
echo      ����%UPdatePath%�̿ɸ���Edgeless
echo.
echo   ���ذ汾��%version_disk%
echo   U�̰汾��%version_usb%
echo =========================================
echo.
pause
goto scan

:scan
echo %time% Disk_Installer-��ʼɨ�豾�ش��̣�ɨ�������£� >>X:\Users\Log.txt
del /f /q DiskList.txt
for %%1 in (C D E F G H I J K L M N O P Q R S T U V W Y Z ) do if exist %%1:\Recovery\WindowsRE\Winre.wim echo %%1 >>DiskList.txt
type DiskList.txt >>X:\Users\Log.txt
if not exist DiskList.txt (
    cls
    echo δ���ֿ��԰�װ��Ӳ��
)
if exist DiskList.txt (
    cls
    echo.
    echo ɨ�赽�����̷���Windows���԰�װEdgelessӲ�̰�
    echo ==========================================
    type DiskList.txt
    echo ==========================================
)

echo.
echo ���ʹ���˾����ϵͳ����һ�γ�����ǰ������ɨ��ʱ���ܲ����г������ֶ������̷�
echo.
echo.
set /p a=����Ŀ��ϵͳ���̷����س���
echo %time% Disk_Installer-�û�������Ŀ���̷���%a% >>X:\Users\Log.txt

if not defined a goto scan
if not exist %a%:\ (
    echo %time% Disk_Installer-%a%�̲����� >>X:\Users\Log.txt
    cls
    echo.
    echo ���󣺲�����%a%��
    echo.
    pause
    goto scan
)
if not exist %a%:\Recovery\WindowsRE\Winre.wim (
    echo %time% Disk_Installer-%a%�̲�����Winre.wim����ʾ���� >>X:\Users\Log.txt
    cls
    echo.
    echo ���棺%a%���ϵ�ϵͳ���ܲ�֧�ְ�װEdgelessӲ�̰棬�����������
    pause >nul
)

::ɨ��EdgelessU��
:reCheckELU
echo %time% Disk_Installer-��ʼɨ��EdgelessU�� >>X:\Users\Log.txt
del /f /q Upath.txt >nul
for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\version.txt echo %%1>Upath.txt
set /p Upath=<Upath.txt
echo %time% Disk_Installer-ʹ��%Upath%%��ΪEdgeless�̷� >>X:\Users\Log.txt
if not defined Upath (
    echo %time% Disk_Installer-Ҫ�����U�� >>X:\Users\Log.txt
    cls
    echo.
    echo �����Edgeless�����̣�Ȼ�����������
    pause >nul
    goto reCheckELU
)

::�ҳ����µ�wim�ļ�

::�г�����.wim�ļ�
dir /b %Upath%:\*.wim >1.tmp

::����Edgeless_Beta��ͷ���ļ�
findstr /b /c:"Edgeless_Beta_" 1.tmp >2.tmp

::�ҳ��汾����ߵ�
set maxVer=1.0.0
for /f "usebackq delims==_ tokens=1,2,3*" %%i in (2.tmp) do (
    if "!maxVer!" lss "%%~nk" set "maxVer=%%~nk"
)
echo %time% Disk_Installer-���°�wim�ļ�Ϊ��Edgeless_Beta_%maxVer%.wim >>X:\Users\Log.txt
del /f /q *.tmp

if not exist %Upath%:\Edgeless_Beta_%maxVer%.wim (
    echo %time% Disk_Installer-������Edgeless_Beta_%maxVer%.wim��У��ʧ�� >>X:\Users\Log.txt
    cls
    echo.
    echo %Upath%�ϵ������̲����������ļ������淶��.wim�����ļ����޷���������
    echo ������%Upath%:\Edgeless_Beta_%maxVer%.wim
    pause >nul
    exit
)

::����ԭWinre�ļ�
echo %time% Disk_Installer-��ʼ����ԭWinre�ļ� >>X:\Users\Log.txt
takeown /f %a%:\Recovery\WindowsRE\Winre.wim
attrib -s -a -h -r %a%:\Recovery\WindowsRE\Winre.wim
if not exist %a%:\Recovery\WindowsRE\Winre.wim.bak ren %a%:\Recovery\WindowsRE\Winre.wim Winre.wim.bak
if exist %a%:\Recovery\WindowsRE\Winre.wim.bak del /f /q %a%:\Recovery\WindowsRE\Winre.wim
:checkRen
if exist %a%:\Recovery\WindowsRE\Winre.wim (
    echo %time% Disk_Installer-����Winre.wimʧ�� >>X:\Users\Log.txt
    explorer %a%:\Recovery\WindowsRE
    cls
    echo.
    echo ������%a%:\Recovery\WindowsRE\Winre.wimʧ��
    echo ���ֶ�����������ΪWinre.wim.bak
    echo.
    pause
    goto checkRen
)

::����boot.wim
:copyCheckWim
echo %time% Disk_Installer-��ʼ����boot.wim >>X:\Users\Log.txt
title ���ڸ���Edgeless����
cls
echo ���ڸ���Edgeless����...
copy /y %Upath%:\Edgeless_Beta_%maxVer%.wim %a%:\Recovery\WindowsRE\Winre.wim
    if not exist %a%:\Recovery\WindowsRE\Winre.wim (
    echo %time% Disk_Installer-����boot.wimʧ�� >>X:\Users\Log.txt
        explorer %a%:\Recovery\WindowsRE
        echo ==================================================================================================
        echo ����%Upath%:\Edgeless_Beta_%maxVer%.wim��%a%:\Recovery\WindowsRE\Winre.wimʧ�ܣ����ֶ����ƻ����������
        echo ==================================================================================================
        pause >nul
        goto copyCheckWim
    )
::����Edgeless�ļ���
:copyCheckEL
echo %time% Disk_Installer-��ʼ����Edgeless�ļ��� >>X:\Users\Log.txt
title ���ڸ���Edgeless�ļ���
cls
xcopy /s /r /y %Upath%:\Edgeless %a%:\Edgeless\
    if not exist %a%:\Edgeless\version.txt (
    echo %time% Disk_Installer-����Edgeless�ļ���ʧ�� >>X:\Users\Log.txt
        echo =======================================================================
        echo ����%Upath%:\Edgeless��%a%:\Edgelessʧ�ܣ����ֶ����ƻ����������
        echo =======================================================================
        pause >nul
        goto copyCheckEL
    )
::������version.txtΪversion_Disk.txt
:renCheck
echo %time% Disk_Installer-��ʼ������version.txtΪversion_Disk.txt >>X:\Users\Log.txt
title ���ڴ���汾��ʶ�ļ�
ren %a%:\Edgeless\version.txt version_Disk.txt
    if not exist %a%:\Edgeless\version_Disk.txt (
        echo %time% Disk_Installer-������version.txtΪversion_Disk.txtʧ�� >>X:\Users\Log.txt
        echo ================================================================================
        echo ������%a%:\Edgeless\version.txtΪversion_Disk.txtʧ�ܣ����ֶ������������������
        echo ================================================================================
        pause >nul
        goto renCheck
    )
del /f /q %a%:\Edgeless\version.txt >nul
title EdgelessӲ�̰氲װ���
echo %time% Disk_Installer-EdgelessӲ�̰氲װ��� >>X:\Users\Log.txt
cls
echo.
echo.
echo ===================================================================
echo EdgelessӲ�̰氲װ��ϣ��������й���ʱ���Զ�����Edgeless
echo ��������������Windows����������ǿ�йػ����ɽ���
echo ����Ľ��뷽ʽ��ٶȣ�����winre
echo ===================================================================
echo.
pause
exit



:newest
echo %time% Disk_Installer-%UPdatePath%�̵�Edgeless�������°汾 >>.\Log.txt
title �������°汾��%UPdatePath%��
cls
echo.
echo.
echo.
echo  ��ϲ��%UPdatePath%�̵�Edgeless�������°汾��
echo =========================================
echo �汾��Ϣ��
echo �����汾�ţ�%version_disk%
echo ϵͳ���ƣ�%version_disk:~0,8%
echo �������ͣ�%version_disk:~9,4%
echo ���а汾��%version_disk:~14,5%
echo �汾��ţ�%version_disk:~20,5%
echo =========================================
echo.
echo ����������°�װ��Ϊ����������ϵͳ��װ
pause >nul
goto scan