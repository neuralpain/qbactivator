<# :# begin Batch Script
@echo off
mode 75,25
title qbactivator
set uivr=0.16
set "wdir=%~dp0"
set "pwsh=powershell -nop -c"
set "PATCHFOLDER=%systemroot%\Microsoft.NET\assembly\GAC_MSIL\Intuit.Spc.Map.EntitlementClient.Common\v4.0_8.0.0.0__5dc4fe72edbcacf5"
set "DATASTORE=%programdata%\Intuit\Entitlement Client\v8"

:: PowerShell config
:# Disabling argument expansion avoids issues with ! in arguments.
setlocal EnableExtensions DisableDelayedExpansion
:# Prepare the batch arguments, so that PowerShell parses them correctly
set ARGS=%*
if defined ARGS set ARGS=%ARGS:"=\"%
if defined ARGS set ARGS=%ARGS:'=''%
:: perform simple hashcheck for patch file integrity
%pwsh% ^"Invoke-Expression ('^& {' + (get-content -raw '%~f0') + '} %ARGS%')"
if %ERRORLEVEL% NEQ 0 ( exit )

:: check admin permissions
cls & echo.
echo Please wait . . .
fsutil dirty query %systemdrive% >nul
:: if error, we do not have admin.
if %ERRORLEVEL% NEQ 0 (
  cls & echo.
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
cls & echo.
echo qbactivator v0.16.1
echo.
echo Activation script for QuickBooks Point Of Sale Software
echo (and more) on Windows. Originally created for Point of Sale
echo 2013/v11 and Point of Sale 2013/v11 Multistore but has proven
echo to work on later versions of the QuickBooks software.
echo.
echo Credits to Beast_iND (the original author), microbolt
echo and dechronic for their work in previous versions of this
echo activation script up to v0.15.
echo.
echo -- neuralpain
echo. & echo.

pushd "%wdir%"
@set "0=%~f0"
:: export and open files
%pwsh% "$f=[IO.File]::ReadAllText($env:0) -split ':qblicense\:.*'; [IO.File]::WriteAllText('qblicense.key',$f[1].Trim(),[System.Text.Encoding]::UTF8)"
%pwsh% "$f=[IO.File]::ReadAllText($env:0) -split ':qbreadme\:.*'; [IO.File]::WriteAllText('qbreadme.md',$f[1].Trim(),[System.Text.Encoding]::UTF8)"
popd
start notepad.exe "qbreadme.md"
start notepad.exe "qblicense.key"

echo.
echo Please ensure that a QuickBooks product is installed before
echo you continue with the patch. Continue when ready.
echo. & pause

:: end QuickBooks background processes
cls & echo.
echo Attempting to close any running QuickBooks processes...
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
taskkill /f /fi "imagename eq qb*" /f /t >nul 2>&1
taskkill /f /fi "imagename eq intuit*" /f /t >nul 2>&1
if exist "%DATASTORE%\EntitlementDataStore.ecml" ( ren "%DATASTORE%\EntitlementDataStore.ecml" "EntitlementDataStore.ecml.old" )
echo. & echo Done.

:: prepare for activation
if not exist "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" (
  cls & echo.
  echo The Entitlement Client was not found.
  echo The patch cannot be completed.
  echo.
  echo Please ensure that a QuickBooks product is installed.
  echo The patcher will now close.
  echo.
  pause
  goto :exitQBA
) else ( ren "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" "Intuit.Spc.Map.EntitlementClient.Common.dll.bak" >nul )
copy /v /y /z "%~dp0qbpatch.dat" "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" >nul
cls & echo.
net start "Intuit Entitlement Service v8"
net start "QBPOSDBServiceV11"
cls & echo.
echo Follow the steps below to activate QuickBooks software.
echo.
echo 1. Open QuickBooks
echo 2. Click "Help" then "Registration"
echo 3. Click "Register by phone now"
echo 4. Enter the code 99999930
echo 5. Click Next
echo 6. Click Finish
echo.
echo --- Continue when finished.
echo.
echo For Point of Sale Multistore, do not press any key, refer to 
echo Step 21 in "qbreadme.md". Once completed 21 - 35, then continue.
echo. & pause

:: end activation and end all QuickBooks processes
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
taskkill /f /fi "imagename eq qb*" /f /t >nul 2>&1
taskkill /f /fi "imagename eq intuit*" /f /t >nul 2>&1

:: restore files to original state
copy /v /y /z "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll.bak" "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" >nul
fc "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll" "%PATCHFOLDER%\Intuit.Spc.Map.EntitlementClient.Common.dll.bak" > nul

:: error handling if files have not been restored
if %ERRORLEVEL% EQU 1 (
  cls & echo.
  echo The patcher ran into a problem while attempting to restore the files.
  echo. & echo Attempting to restore files . . .
  echo Unable to restore files & pause
  start explorer.exe %PATCHFOLDER%
  cls & echo. & echo Do the following to resolve the error:
  echo 1. Delete Intuit.Spc.Map.EntitlementClient.Common.dll
  echo 2. Remove the .bak extension from Intuit.Spc.Map.EntitlementClient.Common.dll.bak
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
taskkill /f /fi "WindowTitle eq qblicense*" >nul
taskkill /f /fi "WindowTitle eq qbreadme*" >nul
del "%wdir%qblicense.key" >nul
del "%wdir%qbreadme.md" >nul
goto :eof

:: export keys to text file
:qblicense:
[QB Point Of Sale]

[POS v11 - 2013]
LICENSE NUMBER: 1063-0575-1585-222
PRODUCT NUMBER (BASIC): 810-968
PRODUCT NUMBER (PRO): 023-147
PRODUCT NUMBER (MULTI): 015-985

[POS v12 - 2015]
LICENSE NUMBER: 6740-7656-8840-594
PRODUCT NUMBER (BASIC): 448-229
PRODUCT NUMBER (MULTI): 015-985

[POS v18 - 2018]
LICENSE NUMBER 1: 0106-3903-4389-908
LICENSE NUMBER 2: 2421-4122-2213-596
PRODUCT NUMBER (PRO): 587-573
PRODUCT NUMBER (MULTI): 818-769

[POS v19 - 2019]
LICENSE NUMBER 1: 0106-3903-4389-908
LICENSE NUMBER 2: 2421-4122-2213-596
PRODUCT NUMBER (MULTI): 595-828

*

*

*

--- Other QuickBooks installation keys ---

[QuickBooks Accountant 2013]
LICENSE NUMBER: 1063-0575-1585-222
PRODUCT NUMBER: 463-240

[QuickBooks Pro 2013]
LICENSE NUMBER: 1063-0575-1585-222
PRODUCT NUMBER: 833-891

[QuickBooks Premier 2013 Industry editions]
LICENSE NUMBER: 1063-0575-1585-222
PRODUCT NUMBER: 187-636

[QuickBooks Enterprise 13 US (5 users)]
LICENSE NUMBER: 1063-0575-1585-222
PRODUCT NUMBER: 875-560

[QuickBooks Enterprise US 2013 with Advance Inventory]
LICENSE NUMBER: 4978-4549-2489-983
PRODUCT NUMBER: 344-801

--------------------------------------------------
[QuickBooks Enterprise 2013 UK Key - 60 Day Trial]
LICENSE NUMBER: 5108-5360-0832-409
PRODUCT NUMBER: 114-886

Once installed, run the QuickBooks activator (if not
already running), then in your trial version, go to
the help menu, select "Buy QuickBooks" and enter:

LICENSE NUMBER: 1063-0575-1585-222 (payroll and 30 user licenses)
PRODUCT NUMBER: 346-856
--------------------------------------------------

- neuralpain // 'cause why not? -
:qblicense:

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

# ------------------------------------ #
end Batch Script; begin PowerShell Script #>

$qbhash = "1682036591228F5AAB241D17AC8727AEA122D74F"
if (-not(Test-Path -Path .\qbpatch.dat -PathType Leaf)) {
  Write-Host "Patch file not found. Patcher will now close."
  Start-Sleep -Seconds 2; exit 1
} else {
  $_hash = Get-FileHash qbpatch.dat -Algorithm SHA1 | Select-Object Hash
  $_hash = $_hash -split " "
  $_hash = $_hash.Trim("@{Hash=}")
  if ($_hash -ne $qbhash) {
    Write-Host "Patch file is corrupted. Patcher will now close."
    Start-Sleep -Seconds 2; exit 1
  }
}
