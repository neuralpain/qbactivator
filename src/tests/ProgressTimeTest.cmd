<# :# PowerShell comment protecting the Batch section
@echo off
setlocal EnableExtensions DisableDelayedExpansion
set ARGS=%*
if defined ARGS set ARGS=%ARGS:"=\"%
if defined ARGS set ARGS=%ARGS:'=''%
PowerShell -c ^"Invoke-Expression ('^& {' + (get-content -raw '%~f0') + '} %ARGS%')"
exit /b
#>


function Get-TimeToComplete {
  param ([int]$DownloadSize, [int]$Bandwidth)
  
  [double]$time = ($DownloadSize / $Bandwidth)
  [int]$time = [math]::Round($time)

  $Script:RAW_DOWNLOAD_TIME = $time

  if ($time -gt 60) {
    [int]$time_m = $time / 60
    [int]$time_s = $time % 60
    return "${time_m}:${time_s}"
  }

  return "$time seconds"
}



function Start-Progress {
  param (
    $DownloadSize, 
    $Bandwidth
  )

  # $smoothing = 4
  $sleep = 1000 / [math]::Pow(2, 4) # + 2.5 # + 12.5 # ~62.5ms -> 75ms
  Write-Host "$sleep (milliseconds)"                       # Debug
  $download_duration = $Script:RAW_DOWNLOAD_TIME * [math]::Pow(2, 4) # x16+n

  Write-Host "$download_duration (steps)"                  # Debug

  for ($i = 0; $i -le $download_duration; $i++) {
    $x = "{0:F2}" -f [math]::Round(($i / $download_duration) * 100, 2)
    Write-Host -NoNewLine "`r [ $x% ] "
    Start-Sleep -Milliseconds $sleep
  }
}



$DownloadSize = 164665944 # pos11
$Bandwidth = 1741119
Write-Host $(Get-TimeToComplete -DownloadSize $DownloadSize -Bandwidth $Bandwidth)
Pause
Start-Progress -DownloadSize $DownloadSize -Bandwidth $Bandwidth
