@echo off
del /f /q X:\Users\Imdisk\isotar.txt
del /f /q X:\Users\Imdisk\isopath.txt
echo msgbox "��ʾ��Imdisk���ع������޸���",64,"Edgeless Smart ISO">alert.vbs && start alert.vbs && ping -n 2 127.1>nul && del alert.vbs
exit