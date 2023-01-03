<# :# begin Batch Script
@set uivr=0.17
@mode 75,20
@echo off
@title qbactivator

:: working directory
set "wdir=%~dp0"

:: PowerShell
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
echo qbactivator v0.17
echo.
echo Activation script for QuickBooks POS.
echo.
echo Please ensure that a QuickBooks software is completely
echo installed before you continue. Continue when ready.
echo. & pause

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

:: export and open minified readme
pushd "%wdir%"
@set "0=%~f0"
%pwsh% "$f=[IO.File]::ReadAllText($env:0) -split ':qbreadme\:.*'; [IO.File]::WriteAllText('qbreadme.md',$f[1].Trim(),[System.Text.Encoding]::UTF8)"
popd & start notepad.exe "qbreadme.md"

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
echo -- if not, open it
echo 2. Click "Remind me later"
echo 3. Click "Help" then "Registration"
echo 4. Click "Register by phone now"
echo 5. Enter the code 99999930
echo 6. Click Next
echo 7. Click Finish
echo.
echo --- Continue when finished.
echo.
echo For Point of Sale Multistore, do not press any key, refer to 
echo Step 21 in "qbreadme.md". Once completed 21 - 35, then continue.
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

:: restore files to original state
copy /v /y /z "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll.bak" "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" >nul
fc "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll.bak" > nul

:: error handling if files have not been restored
if %ERRORLEVEL% EQU 1 (
  cls & echo.
  echo The patcher ran into a problem while attempting to restore the files.
  echo. & echo Attempting to restore files . . .
  echo Unable to restore files & pause
  explorer.exe %PATCHFOLDER%
  cls & echo. & echo Do the following to resolve the error:
  echo 1. Delete "Intuit.Spc.Map.EntitlementClient.Common.dll"
  echo 2. Remove the ".bak" extension from "Intuit.Spc.Map.EntitlementClient.Common.dll.bak"
  pause
  echo Patcher will now close.
  ping -n 3 127.0.0.1 >nul
  goto exitQBA
) else (
  cls & echo.
  del /q /f /a "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll.bak"
  echo Patch completed without errors. Patcher will now close.
  ping -n 3 127.0.0.1 >nul
  goto exitQBA
)

:exitQBA
:: clean up files and exit script
taskkill /f /fi "WindowTitle eq qbreadme*" >nul
del "%wdir%qbreadme.md" >nul
goto :eof

:: export instructions to text file
:qbreadme:
# [qbactivator](https://github.com/neuralpain/qbactivator) - Minified README

Only qbactivator.cmd and qbpatch.dat are required for activation. The script
will provide you with the instructions you need.

- Software **MUST** be opened as administrator, which is done by right-clicking
  the shortcut and click "Run as administrator". To make that action permanent,
  right click the shortcut, click the "Compatibility" tab, check the box that
  says "Run this program as an administrator" and click OK.
- To upgrade to Multistore if you have already activated it, jump to step 24.
- Don't launch QuickBooks yet.
- Avoid installing updates, Intuit will probably block this in the future.

## Downloads & Updates

If installing QuickBooks for the first time, do not launch QuickBooks after
installation. Uncheck the "Launch QuickBooks" box and click Finish.

Check out the QuickBooks product download form for earlier downloads or
additional QuickBooks Desktop software that isn't included in this document: 
<https://downloads.quickbooks.com/app/qbdt/products>

## Instructions for activation

1. Ensure that a QuickBooks software is installed before you continue
2. Open the installed QuickBooks software. You will be prompted about the
   need for Administrator access
3. Click Next
4. Approve the prompt by clicking "Yes" or "Continue", if the prompt appears
5. Click "Open Practice Mode"
6. Click Next
7. Use Sample Data
8. Click Next
9. Click OK

> NOTE: **DO NOT** click "Register now" or press the [ENTER] key at this point.

10. Click "Remind me later"
11. Click "Help" in the menu bar
12. Click "Registration"
13. Click "Register by phone now"
14. Enter the code 99999930
15. Click Next
16. Click Finish

> NOTE: The following steps (17-23 is optional)

17. To add more users, click "Help"
18. Click "Manage My License"
19. Click "Buy Additional User License"
20. Enter the code for the number of users you want

> NOTE: For 5 users use 9999995; For 30 users use 99999930, etc.

21. Click Next
22. Click Finish
23. Follow the remaining instructions in the activator (if any) to finish
    the activation.

**To upgrade to Multistore - Optional but recommended**

24. With the activator still running, Click Help
25. Click "Try Point of Sale Multistore FREE"
26. Click Next
27. Click Continue
28. After a few moments, click Finish
29. Click Help
30. Click Buy Now
31. Enter new product number for Multistore as provided in the <qblicense.key>
    file for the relative software
32. Enter the validation code as 99999930
33. Click Next
34. Click Next
35. Click Continue
36. A message "Welcome to Point of Sale ProMS Level" (or similar) will appear
37. Click Finish
38. Exit the software

> NOTE: To add users to Multistore, repeat steps 17-22.

- neuralpain // 'cause why not? -
:qbreadme:

# ----------------------------------- #>

$qbhash = "1682036591228F5AAB241D17AC8727AEA122D74F"
if (-not(Test-Path -Path .\qbpatch.dat -PathType Leaf)) {
  Write-Host "0x033: Patch file not found."
  Write-Host "Activator will now close."
  Start-Sleep -Seconds 2; exit 1
} else {
  $_hash = Get-FileHash qbpatch.dat -Algorithm SHA1 | Select-Object Hash
  $_hash = $_hash -split " "
  $_hash = $_hash.Trim("@{Hash=}")
  if ($_hash -ne $qbhash) {
    Write-Host "Patch file is corrupted. Activator will now close."
    Start-Sleep -Seconds 2; exit 1
  }
}

$EXE_QBPOSV11 = "QuickBooksPOSV11.exe"
$EXE_QBPOSV12 = "QuickBooksPOSV12.exe"
$EXE_QBPOSV18 = "QuickBooksPOSV18.exe"
$EXE_QBPOSV19 = "QuickBooksPOSV19.exe"

$QBDATA11 = "C:\ProgramData\Intuit\QuickBooks Point of Sale 11.0"
$QBDATA12 = "C:\ProgramData\Intuit\QuickBooks Point of Sale 12.0"
$QBDATA18 = "C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 18.0"
$QBDATA19 = "C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 19.0"

$QBPOSV11 = '<Registration InstallDate="2013-06-01" LicenseNumber="1063-0575-1585-222" ProductNumber="810-968"/>'
$QBPOSV12 = '<Registration InstallDate="2015-06-01" LicenseNumber="6740-7656-8840-594" ProductNumber="448-229"/>'
$QBPOSV18 = '<Registration InstallDate="2018-06-01" LicenseNumber="2421-4122-2213-596" ProductNumber="818-769"/>'
$QBPOSV19 = '<Registration InstallDate="2019-06-01" LicenseNumber="0106-3903-4389-908" ProductNumber="595-828"/>'

if (Test-Path -Path .\$EXE_QBPOSV19 -PathType Leaf) {
  if (-not(Test-Path -Path $QBDATA19 -PathType Leaf)) { mkdir $QBDATA19 >$null 2>&1 }
  Out-File -FilePath $QBDATA19\qbregistration.dat -InputObject $QBPOSV19 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV19
} elseif (Test-Path -Path .\$EXE_QBPOSV18 -PathType Leaf) {
  if (-not(Test-Path -Path $QBDATA18 -PathType Leaf)) { mkdir $QBDATA18 >$null 2>&1 }
  Out-File -FilePath $QBDATA18\qbregistration.dat -InputObject $QBPOSV18 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV18
} elseif (Test-Path -Path .\$EXE_QBPOSV12 -PathType Leaf) {
  if (-not(Test-Path -Path $QBDATA12 -PathType Leaf)) { mkdir $QBDATA12 >$null 2>&1 }
  Out-File -FilePath $QBDATA12\qbregistration.dat -InputObject $QBPOSV12 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV12
} elseif (Test-Path -Path .\$EXE_QBPOSV11 -PathType Leaf) {
  if (-not(Test-Path -Path $QBDATA11 -PathType Leaf)) { mkdir $QBDATA11 >$null 2>&1 }
  Out-File -FilePath $QBDATA11\qbregistration.dat -InputObject $QBPOSV11 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV11
} else {
  Write-Host "QuickBooks installer was not found. Assuming activation-only request."
  Start-Sleep -Seconds 5; exit 0
}