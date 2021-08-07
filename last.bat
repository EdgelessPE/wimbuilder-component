title Edgeless Last Running...


if "x%opt[Edgeless.opt_pin]%"=="xtrue" (
  copy /y .\_vendor\File_PinIcons\00-InitPinIcons.lua "%x%\PEMaterial\Autoruns\Startup\"
)

if "x%opt[Edgeless.main_displayHiddenFiles]%"=="xtrue" (
  %append1%main_displayHiddenFiles.wcs%append2%
)

title Edgeless Last Finished