<# :# PowerShell comment protecting the Batch section

@echo off
setlocal EnableExtensions DisableDelayedExpansion
set ARGS=%*
if defined ARGS set ARGS=%ARGS:"=\"%
if defined ARGS set ARGS=%ARGS:'=''%

PowerShell -c ^"Invoke-Expression ('^& {' + (get-content -raw '%~f0') + '} %ARGS%')"
exit /b

#>



class Installer
{
  [ValidateNotNullOrEmpty()][string]$Name
  [ValidateNotNullOrEmpty()][string]$Hash
  [ValidateNotNullOrEmpty()][string]$Path
  [ValidateNotNullOrEmpty()][int]$XBits
  [ValidateNotNullOrEmpty()][int]$XByte
  [ValidateNotNullOrEmpty()][double]$Size
}

$POS11 = [Installer] @{
  Name = "QuickBooksPOSV11.exe"
  Hash = "A1AF552A49ADFF40E6462A968DD552A4"
  Path = "Intuit\QuickBooks Point of Sale 11.0"
  XBits = 164665944
  XByte = 20583243
  Size = 157.03
}

$POS12 = [Installer] @{
  Name = "QuickBooksPOSV12.exe"
  Hash = "30FB99C5E98DF6874D438C478314EF9D"
  Path = "Intuit\QuickBooks Point of Sale 12.0"
  XBits = 461077328
  XByte = 57634666
  Size = 439.71
}

$POS18 = [Installer] @{
  Name = "QuickBooksPOSV18.exe"
  Hash = "DD45AA4EC0DF431243C9836816E2305A"
  Path = " = Intuit\QuickBooks Desktop Point of Sale 18.0"
  XBits = 637981160
  XByte = 79747645
  Size = 608.42
}

$POS19 = [Installer] @{
  Name = "QuickBooksPOSV19.exe"
  Hash = "F5C434677270319F9A515210CA916187"
  Path = "Intuit\QuickBooks Desktop Point of Sale 19.0"
  XBits = 1017415680
  XByte = 127176960
  Size = 970.28
}

function Get-TimeNow { return Get-Date -UFormat "%I%M%S" }

function Start-Progress {
  param (
    $DownloadSize,
    $Bandwidth
  )
  
  $duration = [math]::Round($DownloadSize / $Bandwidth)
  
  Write-Host "download size ..... $DownloadSize"
  Write-Host "bandwidth ......... $Bandwidth"
  Write-Host "duration .......... $duration`n"
  
  for ($i = 0; $i -le $duration; $i++) {
    $x = [math]::Round(($i / $duration) * 100, 2)
    Write-Host -NoNewLine "`r[$x% complete]   "
    Start-Sleep -Seconds 1
  }
}

Write-Host
$global:ProgressPreference = "SilentlyContinue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$download_size = $POS19.XByte
$bandwidth =   10298640
# $bandwidth = (((Invoke-Expression ".\speedtest --format json") -replace ".*download").Trim(':{"bandwidth":') -replace ",.*") * 1
Start-Progress -DownloadSize $download_size -Bandwidth $bandwidth


Write-Host

Pause