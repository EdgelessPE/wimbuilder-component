::�ű���������
set run=.\_utils\pecmd.exe load .\_scripts\

::main����
if "x%opt[Edgeless.main_oem]%"=="xtrue" (
  echo ����OEM��Ϣ
  %run%oem.wcs
)

goto :eof