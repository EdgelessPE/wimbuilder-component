::脚本驱动命令
set run=.\_utils\pecmd.exe load .\_scripts\

::main配置
if "x%opt[Edgeless.main_oem]%"=="xtrue" (
  echo 配置OEM信息
  %run%oem.wcs
)

goto :eof