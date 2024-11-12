--------------------------------------------------------------------------------
Driver name        AMD USB4 USB3 Root Hub Filter Driver

Operating Systems  Windows 10                

Version            1.0.0.6


--------------------------------------------------------------------------------
DESCRIPTION

  AMD USB4 USB3 Root Hub Filter Driver monitors D0Entry and D0Exit (i.e.,Device Power States) of USB Root Hub (USB 3.0) on which this driver is installed.
Based on the device power states this filter driver indicates its current power states to AMD USB4 CM Driver.

--------------------------------------------------------------------------------
INSTALLATION INSTRUCTIONS

  See Build Letter

--------------------------------------------------------------------------------
KNOWN ISSUES

  N/A.


--------------------------------------------------------------------------------
LIMITATIONS

  N/A.


--------------------------------------------------------------------------------
REVISION HISTORY

  1.0.0.6 03/29/2022
  Added feature score to the inf for right-click install

  1.0.0.5 03/03/2022
  Changed binaries to amdusbhubfilter

  1.0.0.3 02/11/2022
  Initial version with D0Entry and D0exit indication to AMD USB4 CM


--------------------------------------------------------------------------------
COPYRIGHT

  (c) Copyright 2014~2021 Advanced Micro Devices, Inc.  All rights reserved.