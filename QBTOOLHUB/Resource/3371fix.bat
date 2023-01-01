@ECHO OFF
color 1f
@setlocal enableextensions
@cd /d "%~dp0"
for /f "tokens=2-7 delims=/.:- " %%a in ("%date%%time%") do set dt=%%c-%%a-%%b#%%d_%%e_%%f
echo Ending QB background processes (Please Wait- DO NOT CLOSE THIS WINDOW!!!)...
TASKKILL /F /IM qbw.exe >nul 2>&1
TASKKILL /F /IM qbw32.exe >nul 2>&1
TASKKILL /F /IM qbupdate.exe >nul 2>&1
TASKKILL /F /IM qbhelp.exe >nul 2>&1
TASKKILL /F /IM QBCFMonitorService.exe >nul 2>&1
TASKKILL /F /IM QBUpdateService.exe >nul 2>&1
TASKKILL /F /IM IBuEngHost.exe >nul 2>&1
TASKKILL /F /IM msiexec.exe >nul 2>&1
TASKKILL /F /IM mscorsvw.exe >nul 2>&1
TASKKILL /F /IM QBWebConnector.exe >nul 2>&1
TASKKILL /F /IM QBDBMgr9.exe >nul 2>&1
TASKKILL /F /IM QBDBMgr.exe >nul 2>&1
TASKKILL /F /IM QBDBMgrN.exe >nul 2>&1
TASKKILL /F /IM QuickBooksMessaging.exe >nul 2>&1
PING -n 3 127.0.0.1 >NUL
echo Renaming Entitlement.ECML File (Please Wait- DO NOT CLOSE THIS WINDOW!!!)...
ren "%programdata%\\Intuit\Entitlement Client\v8\EntitlementDataStore.ecml" "EntitlementDataStore.ecml old"
PING -n 3 127.0.0.1 >NUL