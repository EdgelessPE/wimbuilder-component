echo %time% ept-save-���� >>X:\Users\Log.txt
set /p w=<savename.txt
if exist savename.txt del /f /q savename.txt
if exist Spath.txt del /f /q Spath.txt
if exist X:\Users\ept\SaveFail.txt del /f /q X:\Users\ept\SaveFail.txt >nul
echo %time% ept-save-ʹ��%w:~1,-2%��Ϊ�ļ��� >>X:\Users\Log.txt
for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\version_Disk.txt echo %%1>Spath.txt
for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\version.txt echo %%1>Spath.txt
if not exist Spath.txt (
    echo ept-install ����%w:~1,-2%ʧ�ܣ�δ��⵽�Ϸ���Edgeless������
    goto endSave
)
set /p Spath=<Spath.txt
echo %time% ept-save-ʹ��%Spath%��ΪEdgeless�̷� >>X:\Users\Log.txt
@copy /y "X:\Users\ept\pack.7zf" "%Spath%:\Edgeless\Resource\%w:~1,-2%" >nul
if not exist "%Spath%:\Edgeless\Resource\%w:~1,-2%" pecmd file "X:\Users\ept\pack.7zf"=>"%Spath%:\Edgeless\Resource\%w:~1,-2%"
if not exist "%Spath%:\Edgeless\Resource\%w:~1,-2%" echo %time% ept-install-���浽U�̷���-����ʧ�� >>X:\Users\Log.txt
if exist "%Spath%:\Edgeless\Resource\%w:~1,-2%" echo %time% ept-install-���浽U�̷���-����ɹ� >>X:\Users\Log.txt
if exist "%Spath%:\Edgeless\Resource\%w:~1,-2%" echo ept-install �ѽ�%w:~1,-2%������%Spath%��
if not exist "%Spath%:\Edgeless\Resource\%w:~1,-2%" (
    echo ept-install ����%w:~1,-2%��%Spath%��ʧ��
    echo Fail >X:\Users\ept\SaveFail.txt
)
:endSave
if not exist X:\Users\ept\upgrade\UpgradeTime.txt (
    if exist Spath.txt del /f /q Spath.txt
)