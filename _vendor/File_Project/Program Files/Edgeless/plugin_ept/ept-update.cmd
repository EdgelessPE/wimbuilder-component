@echo off
echo %time% ept-update-���У���ʼ���ز������ >>X:\Users\Log.txt
echo ept-update ��ʼ���²������...
"X:\Program Files\Edgeless\EasyDown\aria2c.exe" -x16 -c -d X:\Users\ept -o Data.txt https://pineapple.edgeless.top/api/v2/ept/index >>X:\Users\Log.txt
if exist X:\Users\ept\Data.txt (
    echo %time% ept-update-�������سɹ� >>X:\Users\Log.txt
    if exist X:\Users\ept\Index del /f /q X:\Users\ept\Index>nul
    ren X:\Users\ept\Data.txt Index
    if not exist X:\Users\ept\Index echo %time% ept-update-����������ʧ�� >>X:\Users\Log.txt
    echo ept-update ����������³ɹ�
) else (
    echo %time% ept-update-��������ʧ�� >>X:\Users\Log.txt
    echo ept-update ��������ʧ�ܣ������������ӻ���ϵ����
)
echo %time% ept-update-������� >>X:\Users\Log.txt
echo on