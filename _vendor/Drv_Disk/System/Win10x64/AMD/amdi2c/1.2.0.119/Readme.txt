AMD I2C Controller Driver
===================================
Version 1.2.0.119



Description
-------------------------
This driver supports I2C controller in AMD Ryzen based Mobile and Desktop chipsets.

### Operating System Supported:

* Microsoft Windows 11 (64 bit)
* Microsoft Windows 10 (64 bit)


### Known Issues:

* N\A

Revision History
-----------------

1.2.0.119  05/17/2022
* Fixed APIValidator WHQL issue
* Added PnpLockDown in INF

1.2.0.118  01/11/2021
* Hide the Powermanagement option of the driver properties in device manager.

1.2.0.117  11/23/2020
* Fixed the Synchronization when there is Delay

1.2.0.116  11/09/2020
* Robust Error Handling in case of ghost interrupt

1.2.0.115  11/9/2020
* Modified DSM implementation.

1.2.0.111  09/29/2020
* Tuning of the HCNT/LCNT using DSM
  - Configuring of the frequency to be done using DSM.

1.2.0.105  07/06/2020
* Handling of the I2C controller reset.
  - Added proper checks for the reset.

1.2.0.104  06/10/2020
* Mantis Synchronization issue fixed.
  - Release and re-acquire the lock
  
1.2.0.102  04/09/2020
* Added support of DFx.
  -  DFx support is mandatory from 20H1 OS.
  -  INF only change
  -  Reverted the fix of v100.
  -  I2C Clock override feature using registry key.

1.2.0.0100  03/09/2020
* Fixed synchronization issues.
  -  In case of thread switching acquiring of Lock is handled properly.
  -  Updated the release year.
  -  Added the logging script.
  
1.2.0.0099  03/20/2019
* Modified copyright information.
  -  Fixed Lenovo 7E issue.
  -  Removed dpInstaller.
  
1.2.0.0094  06/13/2018
* Modified copyright information.

1.2.0.0075  09/14/2017
* Removed Win8 support.
  -  Changes to keep driver installation generic.
  
1.2.0.0060  09/06/2016
* Fixed MITT issues

1.2.0.0053  08/09/2016
* Add Zeppelin support

1.1.1.0039  11/02/2015
* Add Device Guard support

1.1.0.0036  03/31/2015
* Add 32-bit OS support

1.0.0.0035  02/24/2015
* Update copyright info

1.0.0.0033  11/09/2014
* Fixed EPR 408533 [QA][CZ] Unsigned driver warnings during installation in WinBlue

1.0.0.0025  10/16/2014
* Fixed issue that MITT DeviceNack case may fail.

1.0.0.0021  09/27/2014
* Fixed OBS453592	[CZ A0] MITT I2C Stress test fail.

1.0.0.0019  07/13/2014
* Fixed the WITT test case failure.

1.0.0.0016  05/07/2014
* Initial release


Installation Instructions
-------------------------

**NOTE**: As with all driver installations on Windows, you need to login as Administrator or have administrator rights for your domain login.

To install the driver, copy the installation files to a temporary directory, then use the "Device Manager" to perform an "Update Driver" operation as follows.  

1. Select "Control Panel" from Start Menu.
2. Select "Classic View" from the left pane.
3. Invoke Device Manager. 
4. There should be a device in the section named "Other Devices" with name "Unknown Device", with Hardware Id as *AMD0010/AMDI0010*.
5. Right-click on "Unknown Device", and click on "Update Driver".
6. Select "Browse my computer for driver software".
7. Click "Browse" to choose the installation files and click "OK".
8. A box will appear: "The wizard has finished installing the software", click "Finish" to complete the installation.
 
Update Instructions:
---------------------------

**NOTE**: As  with all driver installations on Windows, you need to login as Administrator or have administrator rights for your domain login.

To update the driver, copy the installation files to a temporary directory, then use the "Device Manager" to perform an "Update Driver" operation as follows.  

1. Select "Control Panel" from Start Menu.
2. Select "Classic View" from the left pane.
3. Invoke Device Manager. 
4. There should be a device section named "AMD I2C Controller"
5. Right-click on AMD I2C Controller, and click on "Update Driver".
6. Select "Browse my computer for driver software".
7. Click "Browse" to choose the installation files and click "OK".
8. A box will appear: "The wizard has finished installing the software", click "Finish" to complete the installation.

Uninstall Instructions:
---------------------------

**NOTE**: As with all driver installations on Windows, you need to login as Administrator or have administrator rights for your domain login.

1. Select "Control Panel" from Start Menu.
2. Select "Classic View" from the left pane.
3. Invoke Device Manager. 
4. There should be a device section named "AMD I2C Controller".
5. Right-click on the “AMD I2C Controller”, and click on "Uninstall".
6. Select "Delete the driver software for this device".
7. Click "OK".


Copyright
---------------------------
(c) Copyright 2014~2022 Advanced Micro Devices, Inc.All rights reserved.

LIMITATION OF LIABILITY: THE MATERIALS ARE PROVIDED AS IS WITHOUT ANY EXPRESS OR IMPLIED WARRANTY OF ANY KIND INCLUDING WARRANTIES OF MERCHANTABILITY, NONINFRINGEMENT
OF THIRD-PARTY INTELLECTUAL PROPERTY, OR FITNESS FOR ANY PARTICULAR PURPOSE. IN NO EVENT SHALL AMD OR ITS SUPPLIERS BE LIABLE FOR ANY DAMAGES WHATSOEVER (INCLUDING,
WITHOUT LIMITATION, DAMAGES FOR LOSS OF PROFITS, BUSINESS INTERRUPTION, LOSS OF INFORMATION) ARISING OUT OF THE USE OF OR INABILITY TO USE THE MATERIALS, EVEN IF AMD 
HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. BECAUSE SOME JURISDICTIONS PROHIBIT THE EXCLUSION OR LIMITATION OF LIABILITY FOR CONSEQUENTIAL OR INCIDENTAL DAMAGES,
THE ABOVE LIMITATION MAY NOT APPLY TO YOU.

AMD does not assume any responsibility for any errors which may appear in the Materials nor any responsibility to support or update the Materials.
AMD retains the right to make changes to its test specifications at any time, without notice.NO SUPPORT OBLIGATION: AMD is not obligated to furnish, support, or make 
any further information, software, technical information, know-how, or show-how available to you. 

U.S.GOVERNMENT RESTRICTED RIGHTS: The Materials and documentation are provided with RESTRICTED RIGHTS.Use, duplication or disclosure by the Government is subject to 
restrictions as set forth in FAR52.227014 and DFAR252.227-7013, et seq., or its successor.Use of the Materials by the Government constitutes acknowledgment of AMD's 
proprietary rights in them.
