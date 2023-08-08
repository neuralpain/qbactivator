function Stop-QuickBooksProcesses {
  Write-Host -NoNewLine "Terminating QuickBooks processes... "
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
  
  # if (Test-Path $CLIENT_MODULE_DATA) { Remove-Item $CLIENT_MODULE_DATA -Force }
  
  Write-Host "Done"
}

function Remove-TemporaryActvationFiles {
  if (Test-Path "$qbactivator_temp") { Remove-Item $qbactivator_temp -Recurse -Force }
}

function Invoke-Activation {
  param ([switch]$ActivationOnly, [Switch]$GeneralActivation)
  
  if ($ActivationOnly) { New-ActivationOnlyRequest }

  Stop-QuickBooksProcesses
  Repair-GenuineClientModule # if damaged
  Find-GenuineClientModule # will exit if missing
  Install-ClientModule # inject modified client
  # Install-ClientDataModule -Version 11
  Remove-TemporaryActvationFiles

  Write-Host "Proceeding with activation..." 
  Start-Sleep -Milliseconds $TIME_SLOW
  
  if ($GeneralActivation) { exit $GENERAL_ACT }
  else { exit $OK }
}

# ---------------------------------- start powershell execution ---------------------------------- #

Write-MainMenu
Remove-TemporaryActvationFiles
exit
