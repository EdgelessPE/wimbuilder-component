echo %time% ��������س���-���浽U�̷���-���� >>X:\Users\Log.txt
set /p w=<name.txt
echo %time% ��������س���-���浽U�̷���-ʹ��%w%_����������汾.7z��Ϊ�ļ��� >>X:\Users\Log.txt
for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\version_Disk.txt echo %%1>Spath.txt
for %%1 in (Z Y X W V U T S R Q P O N M L K J I H G F E D C ) do if exist %%1:\Edgeless\version.txt echo %%1>Spath.txt
set /p Spath=<Spath.txt
echo %time% ��������س���-���浽U�̷���-ʹ��%Spath%��ΪEdgeless�̷� >>X:\Users\Log.txt
copy /y "X:\Program Files\Edgeless\plugin_downloader\tar.7zf" "%Spath%:\Edgeless\Resource\%w%_����������汾.7z"
cd /d X:\Windows\System32
if not exist %Spath%:\Edgeless\Resource\%w%_����������汾.7z pecmd file "X:\Program Files\Edgeless\plugin_downloader\tar.7zf"=>"%Spath%:\Edgeless\Resource\%w%_����������汾.7z"
if not exist %Spath%:\Edgeless\Resource\%w%_����������汾.7z echo %time% ��������س���-���浽U�̷���-����ʧ�� >>X:\Users\Log.txt
if exist %Spath%:\Edgeless\Resource\%w%_����������汾.7z echo %time% ��������س���-���浽U�̷���-����ɹ� >>X:\Users\Log.txt
if exist %Spath%:\Edgeless\Resource\%w%_����������汾.7z pecmd exec !"X:\Program Files\Edgeless\dynamic_creator\dynamic_tip.cmd" 3000 Edgeless��������� �ѽ�%w%������%Spath%��
exit