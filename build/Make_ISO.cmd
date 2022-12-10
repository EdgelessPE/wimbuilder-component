@echo off
:home
if exist test cd test
set ultraiso="D:\CnoRPS\UltraISO\UltraISO.exe"
set freshwim="..\_Factory_\target\WIN10XPE\build\boot.wim"
set templateiso=".\Edgeless_Boot.iso"
set workshop="src"

if not exist %ultraiso% (
	echo Specify a valid UltraISO : %ultraiso%
	pause > nul
	goto home
)
if not exist %freshwim% (
	echo No fresh build found : %freshwim%, press any key to remake a new ISO file
	pause > nul
)
if not exist %templateiso% (
	echo Specify a valid iso template : %templateiso%
	pause > nul
	goto home
)

if not exist %workshop%\sources md %workshop%\sources
if exist %freshwim% (
	del /f /q %workshop%\sources\boot.wim
	move %freshwim% %workshop%\sources\boot.wim
)

%ultraiso% -input %templateiso% -directory %workshop%

if exist %workshop%\Edgeless\Nes_Inport.7z del /f /q %workshop%\Edgeless\Nes_Inport.7z

::启动虚拟机进行测试，如不需要请将下一行 goto EOF 开头的两个冒号去除
::goto EOF
"C:\Program Files (x86)\VMware\VMware Workstation\vmware" -x "C:\Users\dsyou\Documents\Virtual Machines\Edgeless Boot Test\Edgeless Boot Test.vmx"