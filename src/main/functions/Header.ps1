<#
  Execution Module, Version 5.4
  Copyright (c) 2023, neuralpain
  qbactivator verification and execution
#>

$OK = 0x0
$ERR = 0x1
$NONE = 0x2
$PAUSE = 0x3
$CANCEL = 0x4

$TIME_BLINK = 500
# $TIME_SHORT = 800
$TIME_NORMAL = 1000
$TIME_SLOW = 2000

$script:QB_VERSION = $null

$BYTE_TO_MEGABYTE = 1048576

$intuit_temp = "$env:TEMP\Intuit"
$qbactivator_temp = "$env:TEMP\qbactivator_temp"
if (-not(Test-Path $qbactivator_temp)) { mkdir $qbactivator_temp }

$QBPOS11 = "QuickBooksPOSV11.exe"
$QBPOS12 = "QuickBooksPOSV12.exe"
$QBPOS18 = "QuickBooksPOSV18.exe"
$QBPOS19 = "QuickBooksPOSV19.exe"

$QBHASH11 = "A1AF552A49ADFF40E6462A968DD552A4"
$QBHASH12 = "30FB99C5E98DF6874D438C478314EF9D"
$QBHASH18 = "DD45AA4EC0DF431243C9836816E2305A"
$QBHASH19 = "F5C434677270319F9A515210CA916187"

$QBPATH11 = "Intuit\QuickBooks Point of Sale 11.0"
$QBPATH12 = "Intuit\QuickBooks Point of Sale 12.0"
$QBPATH18 = "Intuit\QuickBooks Desktop Point of Sale 18.0"
$QBPATH19 = "Intuit\QuickBooks Desktop Point of Sale 19.0"

$QBREGV11_SERVER = '<Registration InstallDate="" LicenseNumber="8432-0480-0178-029" ProductNumber="023-147"/>'
$QBREGV12_SERVER = '<Registration InstallDate="" LicenseNumber="0877-0442-6111-615" ProductNumber="448-229"/>'
$QBREGV18_SERVER = '<Registration InstallDate="" LicenseNumber="3130-3560-7860-900" ProductNumber="818-769"/>'
$QBREGV19_SERVER = '<Registration InstallDate="" LicenseNumber="7447-0864-8898-657" ProductNumber="595-828"/>'

$QBREGV11_CLIENT = '<Registration InstallDate="" LicenseNumber="1063-0575-1585-222" ProductNumber="023-147"/>'
$QBREGV12_CLIENT = '<Registration InstallDate="" LicenseNumber="6740-7656-8840-594" ProductNumber="448-229"/>'
$QBREGV18_CLIENT = '<Registration InstallDate="" LicenseNumber="2421-4122-2213-596" ProductNumber="818-769"/>'
$QBREGV19_CLIENT = '<Registration InstallDate="" LicenseNumber="0106-3903-4389-908" ProductNumber="595-828"/>'

# start list from most recent version first
$qbVersionList = 19, 18, 12, 11
$qbExeList = $QBPOS19, $QBPOS18, $QBPOS12, $QBPOS11
$qbHashList = $QBHASH19, $QBHASH18, $QBHASH12, $QBHASH11
$qbPathList = $QBPATH19, $QBPATH18, $QBPATH12, $QBPATH11

$global:ProgressPreference = "SilentlyContinue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
