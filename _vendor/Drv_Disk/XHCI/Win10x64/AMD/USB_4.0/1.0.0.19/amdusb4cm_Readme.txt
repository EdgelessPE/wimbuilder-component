--------------------------------------------------------------------------------
Driver name        AMD USB4 Host Router

Operating Systems  Windows 10                

Version            1.0.0.19


--------------------------------------------------------------------------------
DESCRIPTION

  AMD USB4 Connection Manager Driver supports thunderbolt 4 technology with thunderbolt 3 backward compatibility.

--------------------------------------------------------------------------------
INSTALLATION INSTRUCTIONS

  See Build Letter

--------------------------------------------------------------------------------
KNOWN ISSUES

  NO S0i3 with DP Connected

--------------------------------------------------------------------------------
LIMITATIONS

  N/A.


--------------------------------------------------------------------------------
REVISION HISTORY

  1.0.0.19 03/30/2022
  Fix DP issue with TBT3 monitor parallel to TBT3 storage

  1.0.0.18 03/30/2022
  Build failure

  1.0.0.17 03/30/2022
  Build failure

  1.0.0.16 03/30/2022
  Removing the workaround added in the driver for supporting Pre-OS/ DMCUB fw issues related to S4/S5
  Revert change related to dealloc of DPIN

  1.0.0.15 03/13/2022
  ACPI method added for SDEP support
  DP De-Allocation support added

  1.0.0.14 03/03/2022
  Cleaning up path set up PreOS CM for DP tunnel and re-establishing the tunnel

  1.0.0.13 03/02/2022
  Fix for 0x9f and other BSODs

  1.0.0.12 02/25/2022
  Bug fixes and regression

  1.0.0.11 02/24/2022
  Power management with filter driver support + bug fixes.

  1.0.0.9 02/11/2022
  Power management with filter driver support + bug fixes.

  1.0.0.8 01/14/2022
  Power management with limitations

  1.0.0.7 12/27/2021
  Power management test cases without dock

  1.0.0.6 11/16/2021
  TBT3 Support with other bug fixes

  1.0.0.5 09/24/2021
  DP stabilization, WHQL and other bug fixes 

  1.0.0.3 09/17/2021
  Bug fixes for USB3 and PCIe Tunnel
  Added support for DP Tunnel
  Driver Verifier supported

  1.0.0.3 08/31/2021
  Initial Release for Windows 21H1 x64 with USB3 and PCIe Tunneling enabled.

--------------------------------------------------------------------------------
COPYRIGHT

  (c) Copyright 2014~2021 Advanced Micro Devices, Inc.  All rights reserved.