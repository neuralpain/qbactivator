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
[bool]$Script:ADDITIONAL_CLIENTS = $false
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

# extra licenses
$pos19_licenses = @("4569-3302-3865-178","7881-1645-9971-269","4938-5814-0940-038","4808-1135-2336-049","2851-9930-2558-997","6120-5395-3507-303","9987-3884-2589-215","2708-9947-4862-202","5009-9403-1002-207","8409-4961-4037-794","3053-7747-9128-534","7786-9879-2771-754","7487-0743-3346-368","9280-8996-7677-618","5956-5105-0683-052","7767-9250-5701-417")
$pos18_licenses = @("4798-4713-5577-215","6108-6944-0442-313","9877-7080-8166-654","9324-1610-3399-773","0332-2949-2962-553","9795-2504-8646-275","6793-3031-4084-521","9122-6269-9978-972","7318-8184-8823-424","3616-4890-7410-775","5417-1662-5253-895","4942-3840-9153-387","3477-1552-0630-590","3815-2087-1596-845","4279-4883-7575-102","2046-1663-3706-369")
$pos12_licenses = @("0023-8629-2358-007","2289-2505-2376-712","2069-3001-1276-177","1596-0116-8423-156","9884-4020-2536-935","0454-9731-8461-756","6632-9109-5515-608","5460-5353-7861-933","3390-0307-6528-013","5581-2740-9316-682","1627-7594-2197-477","6603-6131-8677-496","4416-4005-9128-286","8664-0924-4097-580","4041-6901-8695-956","6643-0061-1816-223")
$pos11_licenses = @("4152-7820-7508-121","4710-8115-1842-661","6666-1981-1862-788","3006-9510-2311-039","7943-2223-9879-816","0097-1334-7945-038","6111-6942-7154-813","6711-1593-7271-896","1886-6113-4556-755","6212-2023-0526-681","8040-0005-4774-245","6925-4558-7435-923","0417-2770-7838-353","1690-6238-0164-884","4557-9535-0444-555","7718-8079-1215-532")

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
