@echo off
title Edgeless����ǽ
color 3f
echo.
echo  [1]���÷���ǽ
echo  [2]���÷���ǽ
echo.
set /p cho=������Ų��س���
cd /d X:\Windows\System32
if %a%==1 wpeutil.exe EnableFirewall
if %a%==2 wpeutil.exe DisableFirewall

if %a%==1 call "X:\Program Files\Edgeless\dynamic_creator\dynamic_tip.cmd" 3000 Edgeless����ǽ ����ǽ������
if %a%==2 call "X:\Program Files\Edgeless\dynamic_creator\dynamic_tip.cmd" 3000 Edgeless����ǽ ����ǽ�ѽ���

exit