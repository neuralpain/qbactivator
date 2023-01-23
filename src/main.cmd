@title qbactivator %uivr%
@mode 60,16
@echo off

:: PowerShell config
:# Disabling argument expansion avoids issues with ! in arguments.
setlocal EnableExtensions DisableDelayedExpansion

:# Prepare the batch arguments, so that PowerShell parses them correctly
set ARGS=%*
if defined ARGS set ARGS=%ARGS:"=\"%
if defined ARGS set ARGS=%ARGS:'=''%

set "wdir=%~dp0"
set "pwsh=PowerShell -NoP -C"

set "QBPOSDIR11=C:\Program Files (x86)\Intuit\QuickBooks Point of Sale 11.0\QBPOSShell.exe"
set "QBPOSDIR12=C:\Program Files (x86)\Intuit\QuickBooks Point of Sale 12.0\QBPOSShell.exe"
set "QBPOSDIR18=C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 18.0\QBPOSShell.exe"
set "QBPOSDIR19=C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 19.0\QBPOSShell.exe"
set "PATCHFOLDER=%SystemRoot%\Microsoft.NET\assembly\GAC_MSIL\Intuit.Spc.Map.EntitlementClient.Common\v4.0_8.0.0.0__5dc4fe72edbcacf5"

:: check admin permissions
fsutil dirty query %systemdrive% >nul
:: if error, we do not have admin
cls & echo.
if %ERRORLEVEL% NEQ 0 (
  echo This patcher requires administrative priviledges.
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

:init
cls & echo.
echo Please wait...
:: perform simple hashcheck for patch file integrity
:: create folders for patch and start installer
%pwsh% ^"Invoke-Expression ('^& {' + (get-content -raw '%~f0') + '} %ARGS%')"
if %ERRORLEVEL% EQU 3 (
  echo. & pause
  goto :exitQBA 
) else if %ERRORLEVEL% NEQ 0 (
  goto :exitQBA
) else ( goto :startQBA )

:startQBA
:: start screen
cls & echo.
echo qbactivator %uivr%
echo.
echo Activation script for QuickBooks POS.
echo.
echo Please ensure that a QuickBooks software is completely
echo installed before you continue. Continue when ready.
echo.
pause

:: end QuickBooks background processes
cls & echo.
echo Terminating QB processes...
taskkill /fi "imagename eq qb*" /f /t >nul 2>&1
taskkill /fi "imagename eq intuit*" /f /t >nul 2>&1
taskkill /f /im qbw.exe >nul 2>&1
taskkill /f /im qbw32.exe >nul 2>&1
taskkill /f /im qbupdate.exe >nul 2>&1
taskkill /f /im qbhelp.exe >nul 2>&1
taskkill /f /im QBCFMonitorService.exe >nul 2>&1
taskkill /f /im QBUpdateService.exe >nul 2>&1
taskkill /f /im IBuEngHost.exe >nul 2>&1
taskkill /f /im msiexec.exe >nul 2>&1
taskkill /f /im mscorsvw.exe >nul 2>&1
taskkill /f /im QBWebConnector.exe >nul 2>&1
taskkill /f /im QBDBMgr9.exe >nul 2>&1
taskkill /f /im QBDBMgr.exe >nul 2>&1
taskkill /f /im QBDBMgrN.exe >nul 2>&1
taskkill /f /im QuickBooksMessaging.exe >nul 2>&1
echo. & echo Done.

:: insert patch file for activation
ren "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" "Intuit.Spc.Map.EntitlementClient.Common.dll.bak" >nul
copy /v /y /z "%wdir%qbpatch.dat" "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" >nul

:: export and open minified readme
pushd "%wdir%"
@set "0=%~f0"
%pwsh% "$f=[IO.File]::ReadAllText($env:0) -split ':qbreadme\:.*'; [IO.File]::WriteAllText('qbreadme.txt',$f[1].Trim(),[System.Text.Encoding]::UTF8)"
popd & start notepad.exe "qbreadme.txt"

cls & echo.
echo Starting services...
net start "Intuit Entitlement Service v8" >nul 2>&1
net start "QBPOSDBServiceV11" >nul 2>&1

:: start quickbooks
cls & echo.
echo Starting QuickBooks...
if exist "%QBPOSDIR19%" (
  %pwsh% "Start-Process -FilePath '%QBPOSDIR19%'"
) else if exist "%QBPOSDIR18%" (
  %pwsh% "Start-Process -FilePath '%QBPOSDIR18%'"
) else if exist "%QBPOSDIR12%" (
  %pwsh% "Start-Process -FilePath '%QBPOSDIR12%'"
) else if exist "%QBPOSDIR11%" (
  %pwsh% "Start-Process -FilePath '%QBPOSDIR11%'"
)
ping -n 3 127.0.0.1 >nul

cls & echo.
echo Follow the steps below to activate QuickBooks software.
echo.
echo 1. QuickBooks should open automatically
echo -- DO NOT check for updates
echo 2. Click "Remind me later"
echo 3. Click "Help" then "Registration"
echo 4. Click "Register by phone now"
echo 5. Enter the code 99999930
echo 6. Click Next
echo 7. Click Finish
echo.
echo -- Continue when finished.
echo. & pause

:: end activation and end all QuickBooks processes
cls & echo.
echo Terminating QB processes...
taskkill /fi "imagename eq qb*" /f /t >nul 2>&1
taskkill /fi "imagename eq intuit*" /f /t >nul 2>&1
taskkill /f /im qbw.exe >nul 2>&1
taskkill /f /im qbw32.exe >nul 2>&1
taskkill /f /im qbupdate.exe >nul 2>&1
taskkill /f /im qbhelp.exe >nul 2>&1
taskkill /f /im QBCFMonitorService.exe >nul 2>&1
taskkill /f /im QBUpdateService.exe >nul 2>&1
taskkill /f /im IBuEngHost.exe >nul 2>&1
taskkill /f /im msiexec.exe >nul 2>&1
taskkill /f /im mscorsvw.exe >nul 2>&1
taskkill /f /im QBWebConnector.exe >nul 2>&1
taskkill /f /im QBDBMgr9.exe >nul 2>&1
taskkill /f /im QBDBMgr.exe >nul 2>&1
taskkill /f /im QBDBMgrN.exe >nul 2>&1
taskkill /f /im QuickBooksMessaging.exe >nul 2>&1
echo. & echo Done.

:: restore files to original state
cls & echo.
echo Attempting to restore client module...
copy /v /y /z "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll.bak" "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" >nul
fc "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll.bak" > nul

:: error handling if files have not been restored
if %ERRORLEVEL% EQU 1 (
  cls & echo.
  echo The script ran into a problem while attempting to restore the file.
  echo. & pause
  explorer.exe %PATCHFOLDER%
  cls & echo.
  echo Do the following to resolve the error:
  echo 1. Delete "Intuit.Spc.Map.EntitlementClient.Common.dll"
  echo 2. Remove the ".bak" extension from "Intuit.Spc.Map.EntitlementClient.Common.dll.bak"
  echo. & pause
  goto :exitQBA
) else (
  del /q /f /a "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll.bak"
  cls & echo.
  echo Patch completed without errors.
  ping -n 2 127.0.0.1 >nul
  goto :exitQBA
)

:exitQBA
cls & echo.
echo Activator will now terminate.
ping -n 2 127.0.0.1 >nul
:: clean up files and exit script
taskkill /f /fi "WindowTitle eq qbreadme*" >nul
del "%wdir%qbreadme.txt" >nul
goto :eof
