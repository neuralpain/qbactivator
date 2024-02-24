<#
  Activation Module, Version 8.6
  Copyright (c) 2023, neuralpain
  Module for activation of QuickBooks Point of Sale
#>

$OK = 0x0
$ERR = 0x1
$NONE = 0x2
$PAUSE = 0x3
$CANCEL = 0x4
$GENERAL_ACTIVATION = 0x5

$TIME_BLINK = 500
$TIME_SHORT = 800
$TIME_NORMAL = 1000
$TIME_SLOW = 2000

$BYTE_TO_MEGABYTE = 1048576

class Installer {
  [string] $Name
  [string] $VerNum
  [string] $Year
  [string] $Hash
  [string] $Path
  [string] $LNum1
  [string] $LNum2
  [string] $PNum
  [int]    $XBits
  [int]    $XByte
  [string] $Size
}

$POS11InstObj = [Installer]@{
  Name = 'QuickBooksPOSV11.exe'
  VerNum = '11'
  Year = '2013'
  Hash = 'A1AF552A49ADFF40E6462A968DD552A4'
  Path = 'Intuit\QuickBooks Point of Sale 11.0'
  LNum1 = '1063-0575-1585-222'
  LNum2 = '8432-0480-0178-029'
  PNum = '023-147'
  XBits = 164665944
  XByte = 20583243
  Size = '157.03'
}

$POS12InstObj = [Installer]@{
  Name = 'QuickBooksPOSV12.exe'
  VerNum = '12'
  Year = '2015'
  Hash = '30FB99C5E98DF6874D438C478314EF9D'
  Path = 'Intuit\QuickBooks Point of Sale 12.0'
  LNum1 = '6740-7656-8840-594'
  LNum2 = '0877-0442-6111-615'
  PNum = '448-229'
  XBits = 461077328
  XByte = 57634666
  Size = '439.71'
}

$POS18InstObj = [Installer]@{
  Name = 'QuickBooksPOSV18.exe'
  VerNum = '18'
  Year = '2018'
  Hash = 'DD45AA4EC0DF431243C9836816E2305A'
  Path = 'Intuit\QuickBooks Desktop Point of Sale 18.0'
  LNum1 = '2421-4122-2213-596'
  LNum2 = '3130-3560-7860-900'
  PNum = '818-769'
  XBits = 637981160
  XByte = 79747645
  Size = '608.42'
}

$POS19InstObj = [Installer]@{
  Name = 'QuickBooksPOSV19.exe'
  VerNum = '19'
  Year = '2019'
  Hash = 'F5C434677270319F9A515210CA916187'
  Path = 'Intuit\QuickBooks Desktop Point of Sale 19.0'
  LNum1 = '0106-3903-4389-908'
  LNum2 = '7447-0864-8898-657'
  PNum = '595-828'
  XBits = 1017415680
  XByte = 127176960
  Size = '970.28'
}

# start list from most recent version first
$qbVersionList = 19, 18, 12, 11
$qbExeList = $POS19InstObj.Name, $POS18InstObj.Name, $POS12InstObj.Name, $POS11InstObj.Name
$qbHashList = $POS19InstObj.Hash, $POS18InstObj.Hash, $POS12InstObj.Hash, $POS11InstObj.Hash
$qbPathList = $POS19InstObj.Path, $POS18InstObj.Path, $POS12InstObj.Path, $POS11InstObj.Path

# script variables
$Script:LICENSE_KEY = ""
$Script:INSTALLER_SIZE = 0
$Script:QB_VERSION = $null
$Script:SELECTED_QB_VERSION = $null
[int]$Script:RAW_DOWNLOAD_TIME = 0
[int]$Script:INSTALLER_BYTES = 0
[int]$Script:INSTALLER_BITS = 0
[int]$Script:BANDWIDTH_BITS = 0
[bool]$Script:SECOND_STORE = $false
[bool]$Script:CUSTOM_LICENSING = $false
# [bool]$Script:DOWNLOAD_PATCH = $false
[bool]$Script:BANDWIDTH_UNKNOWN = $false
[double]$Script:BANDWIDTH = 0

# download and security level preferences
$global:ProgressPreference = "SilentlyContinue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function Set-Version($v) { $Script:QB_VERSION = $v }
function Set-License($l) { $Script:LICENSE_KEY = $l }
function Get-Version { return $Script:QB_VERSION }
function Get-License { return $Script:LICENSE_KEY }

# add temp folder for qbactivator
$qbactivator_temp = "$env:TEMP\qbactivator_temp"
if (-not(Test-Path $qbactivator_temp)) { 
  mkdir $qbactivator_temp >$null 2>&1 
}

# temp folder for Intuit
$intuit_temp = "$env:TEMP\Intuit"
