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
