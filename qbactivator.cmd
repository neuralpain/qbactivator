<# :# begin Batch Script
@set uivr=0.17.0
@mode 60,16
@title qbactivator
@echo off
set "wdir=%~dp0"
set "pwsh=PowerShell -NoP -C"

:: Entitlememt client folder
set "PATCHFOLDER=%SystemRoot%\Microsoft.NET\assembly\GAC_MSIL\Intuit.Spc.Map.EntitlementClient.Common\v4.0_8.0.0.0__5dc4fe72edbcacf5"

:: QuickBooks POS v11
set "QBPOSDIR11=C:\Program Files (x86)\Intuit\QuickBooks Point of Sale 11.0\QBPOSShell.exe"

:: QuickBooks POS v12
set "QBPOSDIR12=C:\Program Files (x86)\Intuit\QuickBooks Point of Sale 12.0\QBPOSShell.exe"

:: QuickBooks POS v18
set "QBPOSDIR18=C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 18.0\QBPOSShell.exe"

:: QuickBooks POS v19
set "QBPOSDIR19=C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 19.0\QBPOSShell.exe"

:: PowerShell config
:# Disabling argument expansion avoids issues with ! in arguments.
setlocal EnableExtensions DisableDelayedExpansion
:# Prepare the batch arguments, so that PowerShell parses them correctly
set ARGS=%*
if defined ARGS set ARGS=%ARGS:"=\"%
if defined ARGS set ARGS=%ARGS:'=''%

:: check admin permissions
cls & echo.
echo Please wait . . .
fsutil dirty query %systemdrive% >nul
:: if error, we do not have admin.
cls & echo.
if %ERRORLEVEL% NEQ 0 (
  echo This patcher requires administrative priviledges.
  echo Attempting to elevate...
  goto UAC_Prompt
) else ( goto :startQBA )

:UAC_Prompt
set n=%0 %*
set n=%n:"=" ^& Chr(34) ^& "%
echo Set objShell = CreateObject("Shell.Application")>"%tmp%\cmdUAC.vbs"
echo objShell.ShellExecute "cmd.exe", "/c start " ^& Chr(34) ^& "." ^& Chr(34) ^& " /d " ^& Chr(34) ^& "%CD%" ^& Chr(34) ^& " cmd /c %n%", "", "runas", ^1>>"%tmp%\cmdUAC.vbs"
cscript "%tmp%\cmdUAC.vbs" //Nologo
del "%tmp%\cmdUAC.vbs"
goto :eof

:startQBA
:: perform simple hashcheck for patch file integrity
:: create folders for patch and start installer
%pwsh% ^"Invoke-Expression ('^& {' + (get-content -raw '%~f0') + '} %ARGS%')"
if %ERRORLEVEL% NEQ 0 ( exit )

:: preface
cls & echo.
echo qbactivator v0.17.0
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

:: prepare for activation
if not exist "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" (
  cls & echo.
  echo The Entitlement Client was not found.
  echo The patch cannot be completed.
  echo.
  echo Please ensure that a QuickBooks product is installed.
  ping -n 3 127.0.0.1 >nul
  cls & echo.
  echo The activator will now terminate.
  ping -n 3 127.0.0.1 >nul
  goto exitQBA
) else ( 
  ren "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" "Intuit.Spc.Map.EntitlementClient.Common.dll.bak" >nul
  copy /v /y /z "%wdir%qbpatch.dat" "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" >nul
)

:: export and open minified readme
pushd "%wdir%"
@set "0=%~f0"
%pwsh% "$f=[IO.File]::ReadAllText($env:0) -split ':qbreadme\:.*'; [IO.File]::WriteAllText('qbreadme.md',$f[1].Trim(),[System.Text.Encoding]::UTF8)"
popd & start notepad.exe "qbreadme.md"

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
echo Attempting to restore EC-C file...
copy /v /y /z "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll.bak" "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" >nul
fc "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll.bak" > nul

:: error handling if files have not been restored
if %ERRORLEVEL% EQU 1 (
  cls & echo.
  echo The script ran into a problem while attempting to restore the files.
  echo. & pause
  explorer.exe %PATCHFOLDER%
  cls & echo.
  echo Do the following to resolve the error:
  echo 1. Delete "Intuit.Spc.Map.EntitlementClient.Common.dll"
  echo 2. Remove the ".bak" extension from "Intuit.Spc.Map.EntitlementClient.Common.dll.bak"
  echo. & pause
  cls & echo.
  echo Activator will now terminate.
  ping -n 3 127.0.0.1 >nul
  goto exitQBA
) else (
  cls & echo.
  del /q /f /a "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll.bak"
  echo Patch completed without errors. Activator will now terminate.
  ping -n 3 127.0.0.1 >nul
  goto exitQBA
)

:: clean up files and exit script
taskkill /f /fi "WindowTitle eq qbreadme*" >nul
del "%wdir%qbreadme.md" >nul
goto :eof

:: export instructions to text file
:qbreadme:
# [qbactivator](https://github.com/neuralpain/qbactivator) - Simplified README v1.4

Activation script for QuickBooks Point Of Sale Software on Windows.

> **Warning**  
> This activator was designed to work with only a single version of 
> QuickBooks POS installed. If there are multiple versions, it will 
> use the most recent version of the software, and that may cause 
> unexpected results. Caution is advised. Uninstall all previous 
> versions of QuickBooks POS.

> **Note**  
> By default, the activator will search for the installer executable 
> and assumes that you will be installing and activating QuickBooks all 
> at once, however, it is not a requirement for the script to continue. 
> Without an executable present, the script assumes an `activation-only` 
> request and ignores installation.

## Instructions for activation

1. Run `qbactivator.cmd` and allow the QuickBooks software to install 
   completely before you continue.
2. Uncheck the "Launch QuickBooks" box. 
3. Click Finish and continue with the script. QuickBooks will open 
   automatically.
4. You will be asked for Administrative privileges. Click Next.
5. Select "Open Practice Mode"
6. Click Next
7. Select "Use Sample Data..."
8. Click Next
9. Click OK

> **Warning**  
> **DO NOT** click "Register now" or press the <kbd>Enter↵</kbd> key 
> at this point.

10. Click "Remind me later".

> **Note**  
> At this point, the software might seem frozen but just allow the 
> UI some time to load. It will greet you with a dialog informing you 
> that "You are in Practice Mode" when it is ready for interaction 
> along with a yellow indicator in the top-right.

11. Click OK
12. Click the "Help" option in the menu bar
13. Select "Registration" from the drop-down
14. Click "Register by phone now"
15. Enter the code `99999930`
16. Click Next
17. Click Finish

> **Note**  
> You can end the activation here or continue on to add more users 
> if that is something you need.

### Steps 18-23 are for adding more users. This is optional.

18. Click the "Help" option in the menu bar
19. Click "Manage My License"
20. Click "Buy Additional User License"
21. Enter the code for the number of users you want

> **Note**  
> For 5 users use `9999995`. For 30 users use `99999930`, etc.

22. Click Next
23. Click Finish
24. Exit the software

@neuralpain // 'cause why not?
:qbreadme:

# ----------------------------------- #>

$EXE_QBPOSV11 = "QuickBooksPOSV11.exe"
$EXE_QBPOSV12 = "QuickBooksPOSV12.exe"
$EXE_QBPOSV18 = "QuickBooksPOSV18.exe"
$EXE_QBPOSV19 = "QuickBooksPOSV19.exe"

$HASH_QBPOSV11 = "BD825846D2B9D2F80EE9CF65765EC14655878876"
$HASH_QBPOSV12 = "80A48CE36CCB7DC89169CFFDD99BB87C3373C785"
$HASH_QBPOSV18 = "91B606C6DFD803DDC5A2BDA971006FD6ED966FCF"
$HASH_QBPOSV19 = "1FC5E318D8617BD03C7D92A9AD558C477F080578"

$QBDATA11 = "C:\ProgramData\Intuit\QuickBooks Point of Sale 11.0"
$QBDATA12 = "C:\ProgramData\Intuit\QuickBooks Point of Sale 12.0"
$QBDATA18 = "C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 18.0"
$QBDATA19 = "C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 19.0"

$QBPOSV11 = '<Registration InstallDate="" LicenseNumber="1063-0575-1585-222" ProductNumber="810-968"/>'
$QBPOSV12 = '<Registration InstallDate="" LicenseNumber="6740-7656-8840-594" ProductNumber="448-229"/>'
$QBPOSV18 = '<Registration InstallDate="" LicenseNumber="2421-4122-2213-596" ProductNumber="818-769"/>'
$QBPOSV19 = '<Registration InstallDate="" LicenseNumber="0106-3903-4389-908" ProductNumber="595-828"/>'

function Compare-Hash {
  param ( $Hash, $File, [string]$FileType )
  $_hash = Get-FileHash $File -Algorithm SHA1 | Select-Object Hash
  $_hash = $_hash -split " "
  $_hash = $_hash.Trim("@{Hash=}")
  if ($_hash -ne $Hash) {
    Write-Host "$FileType is corrupted." -ForegroundColor Red
    Write-Host "Activator will now terminate."
    Start-Sleep -Seconds 2; exit 1
  }
}

$PatchHash = "1682036591228F5AAB241D17AC8727AEA122D74F"
if (-not(Test-Path -Path .\qbpatch.dat -PathType Leaf)) {
  Write-Host "Patch file not found." -ForegroundColor Red
  Write-Host "Activator will now terminate."
  Start-Sleep -Seconds 2; exit 1
} else { Compare-Hash -Hash $PatchHash -File .\qbpatch.dat -FileType "Patch file" }

Remove-Item -Path C:\ProgramData\Intuit\* -Recurse -Force >$null 2>&1

if (Test-Path -Path .\$EXE_QBPOSV19 -PathType Leaf) {
  Compare-Hash -Hash $HASH_QBPOSV19 -File .\$EXE_QBPOSV19 -FileType "Installer"
  if (-not(Test-Path -Path $QBDATA19 -PathType Leaf)) { mkdir $QBDATA19 >$null 2>&1 }
  Out-File -FilePath $QBDATA19\qbregistration.dat -InputObject $QBPOSV19 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV19
} elseif (Test-Path -Path .\$EXE_QBPOSV18 -PathType Leaf) {
  Compare-Hash -Hash $HASH_QBPOSV18 -File .\$EXE_QBPOSV18 -FileType "Installer"
  if (-not(Test-Path -Path $QBDATA18 -PathType Leaf)) { mkdir $QBDATA18 >$null 2>&1 }
  Out-File -FilePath $QBDATA18\qbregistration.dat -InputObject $QBPOSV18 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV18
} elseif (Test-Path -Path .\$EXE_QBPOSV12 -PathType Leaf) {
  Compare-Hash -Hash $HASH_QBPOSV12 -File .\$EXE_QBPOSV12 -FileType "Installer"
  if (-not(Test-Path -Path $QBDATA12 -PathType Leaf)) { mkdir $QBDATA12 >$null 2>&1 }
  Out-File -FilePath $QBDATA12\qbregistration.dat -InputObject $QBPOSV12 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV12
} elseif (Test-Path -Path .\$EXE_QBPOSV11 -PathType Leaf) {
  Compare-Hash -Hash $HASH_QBPOSV11 -File .\$EXE_QBPOSV11 -FileType "Installer"
  if (-not(Test-Path -Path $QBDATA11 -PathType Leaf)) { mkdir $QBDATA11 >$null 2>&1 }
  Out-File -FilePath $QBDATA11\qbregistration.dat -InputObject $QBPOSV11 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV11
} else {
  Write-Host "QuickBooks installer was not found." -ForegroundColor Yellow
  Write-Host "Assuming activation-only request."
  Start-Sleep -Seconds 5; exit 0
}
