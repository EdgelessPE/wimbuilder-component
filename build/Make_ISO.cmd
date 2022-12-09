set ultraiso="D:\CnoRPS\UltraISO\UltraISO.exe"
set freshwim="..\_Factory_\target\WIN10XPE\build\boot.wim"
set templateiso=".\Edgeless_Boot.iso"
set workshop="src"

if not exist %ultraiso% (
	echo Specify a valid UltraISO : %ultraiso%
	pause > nul
	exit
)
if not exist %freshwim% (
	echo No fresh build found : %freshwim%
	pause > nul
	exit
)
if not exist %templateiso% (
	echo Specify a valid iso template : %templateiso%
	pause > nul
	exit
)

if not exist %templateiso% (
	echo Specify a valid iso template : %templateiso%
	pause > nul
	exit
)

if not exist %workshop%\sources md %workshop%\sources
del /f /q %workshop%\sources\boot.wim
move %freshwim% %workshop%\sources\boot.wim

%ultraiso% -input %templateiso% -directory %workshop%

if exist %workshop%\Edgeless\Nes_Inport.7z del /f /q %workshop%\Edgeless\Nes_Inport.7z