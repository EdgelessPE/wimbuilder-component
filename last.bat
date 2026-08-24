title Edgeless Last Running...

::main配置
if "x%opt[Edgeless.main_displayHiddenFiles]%"=="xtrue" (
  %append1%main_displayHiddenFiles.wcs%append2%
)

::Optimization
if "x%opt[Edgeless.opt_pin]%"=="xtrue" (
  copy /y .\_vendor\File_PinIcons\00-InitPinIcons.lua "%x%\PEMaterial\Autoruns\Startup\"
)

title Edgeless Last Finished