<# :# PowerShell comment protecting the Batch section

@echo off
setlocal EnableExtensions DisableDelayedExpansion
set ARGS=%*
if defined ARGS set ARGS=%ARGS:"=\"%
if defined ARGS set ARGS=%ARGS:'=''%

:: check admin permissions
fsutil dirty query %systemdrive% >nul
:: if error, we do not have admin
cls & echo.
if %ERRORLEVEL% NEQ 0 (
  echo This script requires administrative priviledges.
  echo Attempting to elevate...
  goto UAC_Prompt
) else ( goto :init )

:UAC_Prompt
set n=%0 %*
set n=%n:"=" ^& Chr(34) ^& "%
echo Set objShell = CreateObject("Shell.Application")>"%tmp%\cmdUAC.vbs"
echo objShell.ShellExecute "cmd.exe", "/c start " ^& Chr(34) ^& "." ^& Chr(34) ^& " /d " ^& Chr(34) ^& "%CD%" ^& Chr(34) ^& " cmd /c %n%", "", "runas", ^1>>"%tmp%\cmdUAC.vbs"
cscript "%tmp%\cmdUAC.vbs" //Nologo
del "%tmp%\cmdUAC.vbs"
goto :eof

PowerShell -c ^"Invoke-Expression ('^& {' + (get-content -raw '%~f0') + '} %ARGS%')"
exit /b

#>

$installer_download_url = "https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2013/Latest/QuickBooksPOSV11.exe"

$dwld = Start-Job -ScriptBlock { 
  Start-BitsTransfer $installer_download_url "$pwd\QuickBooksPOSV11.exe" -Priority High
}

Start-Progress  -DownloadSize 157.03 `
                -Bandwidth 2.7

$dwld | Receive-Job -Keep




function Start-Progress {
  param (
    $DownloadSize,
    $Bandwidth,
    $URL,
    $Destination
  )

  # Start-BitsTransfer $URL $Destination -Priority High

  $duration = [math]::Round($DownloadSize / $Bandwidth)

  for ($i = 0; $i -le $duration; $i++) {
    $x = [math]::Round(($i / $duration) * 100, 2)
    Write-Host -NoNewLine "`r[$x% complete]   "
    Start-Sleep -Seconds 1
  }
}