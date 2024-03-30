<#
  qbactivator Activation Module
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
  Name   = 'QuickBooksPOSV11.exe'
  VerNum = '11'
  Year   = '2013'
  Hash   = 'A1AF552A49ADFF40E6462A968DD552A4'
  Path   = 'Intuit\QuickBooks Point of Sale 11.0'
  LNum1  = '1063-0575-1585-222'
  LNum2  = '8432-0480-0178-029'
  PNum   = '023-147'
  XBits  = 164665944
  XByte  = 20583243
  Size   = '157.03'
}

$POS12InstObj = [Installer]@{
  Name   = 'QuickBooksPOSV12.exe'
  VerNum = '12'
  Year   = '2015'
  Hash   = '30FB99C5E98DF6874D438C478314EF9D'
  Path   = 'Intuit\QuickBooks Point of Sale 12.0'
  LNum1  = '6740-7656-8840-594'
  LNum2  = '0877-0442-6111-615'
  PNum   = '448-229'
  XBits  = 461077328
  XByte  = 57634666
  Size   = '439.71'
}

$POS18InstObj = [Installer]@{
  Name   = 'QuickBooksPOSV18.exe'
  VerNum = '18'
  Year   = '2018'
  Hash   = 'DD45AA4EC0DF431243C9836816E2305A'
  Path   = 'Intuit\QuickBooks Desktop Point of Sale 18.0'
  LNum1  = '2421-4122-2213-596'
  LNum2  = '3130-3560-7860-900'
  PNum   = '818-769'
  XBits  = 637981160
  XByte  = 79747645
  Size   = '608.42'
}

$POS19InstObj = [Installer]@{
  Name   = 'QuickBooksPOSV19.exe'
  VerNum = '19'
  Year   = '2019'
  Hash   = 'F5C434677270319F9A515210CA916187'
  Path   = 'Intuit\QuickBooks Desktop Point of Sale 19.0'
  LNum1  = '0106-3903-4389-908'
  LNum2  = '7447-0864-8898-657'
  PNum   = '595-828'
  XBits  = 1017415680
  XByte  = 127176960
  Size   = '970.28'
}

# script variables
$Script:LICENSE_KEY = ""
$Script:INSTALLER_SIZE = 0
$Script:QB_VERSION = $null
$Script:SELECTED_QB_VERSION = $null
[int]$Script:RAW_DOWNLOAD_TIME = 0
[int]$Script:INSTALLER_BYTES = 0
[int]$Script:INSTALLER_BITS = 0
[int]$Script:BANDWIDTH_BITS = 0
[int]$Script:BANDWIDTH_BYTES = 0
[bool]$Script:SECOND_STORE = $false
[bool]$Script:CUSTOM_LICENSING = $false
# [bool]$Script:DOWNLOAD_PATCH = $false
[bool]$Script:BANDWIDTH_UNKNOWN = $false
[double]$Script:BANDWIDTH = 0

# download and security level preferences
$global:ProgressPreference = "SilentlyContinue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# start list from most recent version first
$qbVersionList = 19, 18, 12, 11
$qbExeList = $POS19InstObj.Name, $POS18InstObj.Name, $POS12InstObj.Name, $POS11InstObj.Name
$qbHashList = $POS19InstObj.Hash, $POS18InstObj.Hash, $POS12InstObj.Hash, $POS11InstObj.Hash
$qbPathList = $POS19InstObj.Path, $POS18InstObj.Path, $POS12InstObj.Path, $POS11InstObj.Path

# client patch and repair
$PATCH_HASH = "1A1816C78925E734FCA16974BDBAA4AA"
$LOCAL_PATCH_FILE = ".\EntClient.dll"
$LOCAL_GENUINE_FILE = ".\EntClientGenuine.dll"
$CLIENT_FILE_ON_HOST = "https://raw.githubusercontent.com/neuralpain/qbactivator/v0.21.2/src/bin/ecc/EntClient.dll"
$GENUINE_CLIENT_FILE_ON_HOST = "https://raw.githubusercontent.com/neuralpain/qbactivator/v0.22.0-beta/src/bin/ecc/EntClientGenuine.dll"

$CLIENT_MODULE_DATA = "EntitlementDataStore.ecml"
$CLIENT_MODULE_DATA_PATH = "$env:ProgramData\Intuit\Entitlement Client\v8"
$CLIENT_MODULE_DATA_FULL_PATH = "$CLIENT_MODULE_DATA_PATH\$CLIENT_MODULE_DATA"

$CLIENT_MODULE = "Intuit.Spc.Map.EntitlementClient.Common.dll"
$CLIENT_MODULE_PATH = "$env:SystemRoot\Microsoft.NET\assembly\GAC_MSIL\Intuit.Spc.Map.EntitlementClient.Common\v4.0_8.0.0.0__5dc4fe72edbcacf5"
$CLIENT_MODULE_FULL_PATH = "$CLIENT_MODULE_PATH\$CLIENT_MODULE"

# log file
$LOG = "C:\Windows\Logs\qbactivator\qbactivator_$(Get-Date -Format "yyyyMMdd_HHmmss").log"
# add temp folder for qbactivator
# $qbactivator_temp = "$env:TEMP\qbactivator_temp"
# if (-not(Test-Path $qbactivator_temp)) { mkdir $qbactivator_temp >$null 2>&1 }
# temp folder for Intuit
$intuit_temp = "$env:TEMP\Intuit"

Start-Transcript $LOG

function Clear-Terminal { Clear-Host; Write-Host }
function Set-Version($v) { $Script:QB_VERSION = $v }
function Get-Version { return $Script:QB_VERSION }
function Set-License($l) { $Script:LICENSE_KEY = $l }
function Get-License { return $Script:LICENSE_KEY }
