<#
  Execution Module, Version 5.16
  Copyright (c) 2023, neuralpain
  qbactivator verification and execution
#>

$OK = 0x0
$ERR = 0x1
$NONE = 0x2
$PAUSE = 0x3
$CANCEL = 0x4
$GENERAL_ACTIVATION = 0x5

$TIME_BLINK = 500
# $TIME_SHORT = 800
$TIME_NORMAL = 1000
$TIME_SLOW = 2000

$BYTE_TO_MEGABYTE = 1048576

$intuit_temp = "$env:TEMP\Intuit"

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

# start list from most recent version first
$qbVersionList = 19, 18, 12, 11
$qbExeList = $QBPOS19, $QBPOS18, $QBPOS12, $QBPOS11
$qbHashList = $QBHASH19, $QBHASH18, $QBHASH12, $QBHASH11
$qbPathList = $QBPATH19, $QBPATH18, $QBPATH12, $QBPATH11

# CONFIG
$script:QB_VERSION = $null
$script:SECOND_STORE = $false
$global:ProgressPreference = "SilentlyContinue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# add temp folder for qbactivator
$qbactivator_temp = "$env:TEMP\qbactivator_temp"
if (-not(Test-Path $qbactivator_temp)) { 
  mkdir $qbactivator_temp >$null 2>&1 
}
