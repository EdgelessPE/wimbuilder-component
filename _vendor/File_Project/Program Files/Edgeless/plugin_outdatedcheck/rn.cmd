echo %time% ���ڲ�����ȶԳ���-ȫ������-���� >>X:\Users\Log.txt
for %%1 in (C Z Y X W V U T S R Q P O N M L K J I H G F E D ) do if exist %%1:\Edgeless\Resource echo %%1>Opath.txt
set /p Opath=<Opath.txt
echo %time% ���ڲ�����ȶԳ���-ȫ������-ʹ��%Opath%��ΪEdgeless�̷� >>X:\Users\Log.txt
echo %time% ���ڲ�����ȶԳ���-ȫ������-����ִ��ǰ�ļ��б� >>X:\Users\Log.txt
dir /b "%Upath%:\Edgeless\Resource\*.*" >>X:\Users\Log.txt
cd /d %Upath%:\Edgeless\Resource
for /f  "usebackq" %%a in  (X:\Users\outdated.txt) do (
    ren %%a %%a_���ڵĲ��.7zf
)
echo %time% ���ڲ�����ȶԳ���-ȫ������-����ִ�к��ļ��б� >>X:\Users\Log.txt
dir /b "%Upath%:\Edgeless\Resource\*.*" >>X:\Users\Log.txt
if exist X:\Users\outdated.txt del /f /q X:\Users\outdated.txt
pecmd exec explorer %Opath%:\Edgeless\Resource
exit