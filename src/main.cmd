if %ERRORLEVEL% EQU 0 (
  echo Starting services...
  net start "Intuit Entitlement Service v8" >nul 2>&1
  goto :pos_activation
) else if %ERRORLEVEL% EQU 3 (
  @REM pause screen before exiting
  echo. & pause
  goto exitQBA
) else if %ERRORLEVEL% EQU 5 (
  echo Starting services...
  net start "Intuit Entitlement Service v8" >nul 2>&1
  goto :standard_activation
) else goto exitQBA

:pos_activation
net start "QBPOSDBServiceV11" >nul 2>&1
set "QBPOSDIR11=C:\Program Files (x86)\Intuit\QuickBooks Point of Sale 11.0\QBPOSShell.exe"
set "QBPOSDIR12=C:\Program Files (x86)\Intuit\QuickBooks Point of Sale 12.0\QBPOSShell.exe"
set "QBPOSDIR18=C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 18.0\QBPOSShell.exe"
set "QBPOSDIR19=C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 19.0\QBPOSShell.exe"
set "CLIENT_MODULE=%SystemRoot%\Microsoft.NET\assembly\GAC_MSIL\Intuit.Spc.Map.EntitlementClient.Common\v4.0_8.0.0.0__5dc4fe72edbcacf5\Intuit.Spc.Map.EntitlementClient.Common.dll"

:: start quickbooks
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

:: export and open minified readme
pushd "%wdir%"
set "0=%~f0"
%pwsh% "$f=[IO.File]::ReadAllText($env:0) -split ':qbreadme\:.*'; [IO.File]::WriteAllText('README.txt',$f[1].Trim(),[System.Text.Encoding]::UTF8)"
popd & start notepad.exe "README.txt"

@mode 60,18
cls & echo.
%pwsh% "Write-Host ' qbactivator ' -ForegroundColor White -BackgroundColor DarkGreen"
echo.
echo Follow the steps below to activate QuickBooks software.
echo.
echo 1. QuickBooks should open automatically
echo -- DO NOT check for updates
echo 2. Select "Open Practice Mode"
echo 3. Select "Use Sample Data..."
echo 4. Click "Register by phone now"
echo 5. Enter the code 999999
echo 6. Click Next
echo 7. Click Finish
echo.
echo -- Continue when finished.
echo. & pause
goto end_activation

:standard_activation
@mode 60,17
cls & echo.
%pwsh% "Write-Host ' qbactivator ' -ForegroundColor White -BackgroundColor DarkGreen"
echo.
echo Follow the steps below to activate QuickBooks software.
echo.
echo 1. Open the QuickBooks software
echo 2. Click "Help" then "About..." 
echo 3. Press CTRL+R+P
echo 4. Enter the code 99999930
echo 5. Click Next
echo 6. Click Finish
echo 7. Close QuickBooks
echo.
echo -- Continue when finished.
echo. & pause
goto end_activation

:end_activation
:: end activation and end all QuickBooks processes
cls & echo.
echo Terminating QuickBooks processes...
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
echo Attempting to restore client module...
copy /v /y /z "%CLIENT_MODULE%.bak" "%CLIENT_MODULE%" >nul
fc "%CLIENT_MODULE%" "%CLIENT_MODULE%.bak" > nul
:: error handling if files have not been restored
if %ERRORLEVEL% EQU 1 (
  cls & echo.
  echo qbactivator ran into a problem while attempting to restore
  echo the client.
  echo.
  echo Restart qbactivator and go through the troubleshooting
  echo "Lv1: Restore" to resolve the error. You may choose to
  echo exit the script afterwards.
  echo. & pause
  goto :exitQBA
) else (
  del /q /f /a "%CLIENT_MODULE%.bak"
  echo Restoration successful.
  ping -n 1 127.0.0.1 >nul
  echo Patch completed without errors.
  ping -n 1 127.0.0.1 >nul
  goto :exitQBA
)

:exitQBA
:: clean up files and exit script
taskkill /f /fi "WindowTitle eq README*" >nul 2>&1
del "%wdir%README.txt" >nul 2>&1
cls & echo.
echo qbactivator will now terminate.
ping -n 1 127.0.0.1 >nul
goto :eof
