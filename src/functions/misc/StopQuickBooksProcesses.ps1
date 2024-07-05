function Stop-QuickBooksProcesses {
  Write-Host "Terminating QuickBooks processes... "
  try { 
    taskkill.exe /fi "imagename eq qb*" /f /t | Out-Null
    taskkill.exe /fi "imagename eq intuit*" /f /t | Out-Null
    taskkill.exe /f /im qbw.exe | Out-Null
    taskkill.exe /f /im qbw32.exe | Out-Null
    taskkill.exe /f /im qbupdate.exe | Out-Null
    taskkill.exe /f /im qbhelp.exe | Out-Null
    taskkill.exe /f /im QBCFMonitorService.exe | Out-Null
    taskkill.exe /f /im QBUpdateService.exe | Out-Null
    taskkill.exe /f /im IBuEngHost.exe | Out-Null
    taskkill.exe /f /im msiexec.exe | Out-Null
    taskkill.exe /f /im mscorsvw.exe | Out-Null
    taskkill.exe /f /im QBWebConnector.exe | Out-Null
    taskkill.exe /f /im QBDBMgr9.exe | Out-Null
    taskkill.exe /f /im QBDBMgr.exe | Out-Null
    taskkill.exe /f /im QBDBMgrN.exe | Out-Null
    taskkill.exe /f /im QuickBooksMessaging.exe | Out-Null
    Write-Host "QuickBooks processes terminated."
    New-ToastNotification -ToastText "QuickBooks processes terminated" -ToastTitle "qbactivator"
  }
  catch {
    Write-Host "Error terminating QuickBooks processes. Error: $_"
    New-ToastNotification -ToastText "Error terminating QuickBooks processes" -ToastTitle "qbactivator"
  }
}
