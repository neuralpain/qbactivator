function Stop-QuickBooksProcesses {
  Write-Host "Terminating QuickBooks processes... "
  try { 
    taskkill.exe /fi "imagename eq qb*" /f /t >$null 2>&1
    taskkill.exe /fi "imagename eq intuit*" /f /t >$null 2>&1
    taskkill.exe /f /im qbw.exe >$null 2>&1
    taskkill.exe /f /im qbw32.exe >$null 2>&1
    taskkill.exe /f /im qbupdate.exe >$null 2>&1
    taskkill.exe /f /im qbhelp.exe >$null 2>&1
    taskkill.exe /f /im QBCFMonitorService.exe >$null 2>&1
    taskkill.exe /f /im QBUpdateService.exe >$null 2>&1
    taskkill.exe /f /im IBuEngHost.exe >$null 2>&1
    taskkill.exe /f /im msiexec.exe >$null 2>&1
    taskkill.exe /f /im mscorsvw.exe >$null 2>&1
    taskkill.exe /f /im QBWebConnector.exe >$null 2>&1
    taskkill.exe /f /im QBDBMgr9.exe >$null 2>&1
    taskkill.exe /f /im QBDBMgr.exe >$null 2>&1
    taskkill.exe /f /im QBDBMgrN.exe >$null 2>&1
    taskkill.exe /f /im QuickBooksMessaging.exe >$null 2>&1
    Write-Host "QuickBooks processes terminated."
    New-ToastNotification -ToastText "QuickBooks processes terminated" -ToastTitle "qbactivator"
  }
  catch {
    Write-Host "Error terminating QuickBooks processes. Error: $_"
    New-ToastNotification -ToastText "Error terminating QuickBooks processes" -ToastTitle "qbactivator"
  }
}
