echo %time% 7zf�������-���� >>X:\Users\Log.txt
echo %time% 7zf�������-Ŀ������ >>X:\Users\Log.txt
echo %1 >>X:\Users\Log.txt
pecmd exec ="%ProgramFiles%\Edgeless\plugin_loader\p7zf.wcs"

::���������ļ�������
if exist X:\Users\load7zf (
rd X:\Users\load7zf
echo %time% 7zf�������-�������� >>X:\Users\Log.txt
pecmd exec ="%ProgramFiles%\Edgeless\plugin_loader\load.cmd" %1
pecmd load "X:\Program Files\Edgeless\plugin_loader\7zftip.wcs"
exit
)

::����LocalBoost����
if exist X:\Users\installToBoost (
rd X:\Users\installToBoost
md X:\Users\LocalBoost
echo %time% 7zf�������-ʹ��LocalBoost��װ >>X:\Users\Log.txt
if not exist "X:\Users\LocalBoost\repoPart.txt" pecmd exec ="X:\Program Files\Edgeless\plugin_localboost\GUI.wcs"
echo %1>"X:\Users\LocalBoost\pluginPath.txt"
pecmd exec "X:\Program Files\Edgeless\plugin_localboost\installToRepo.wcs"
exit
)
if not exist X:\Users\load7zf echo %time% 7zf�������-�û��رռ��ش��� >>X:\Users\Log.txt
exit