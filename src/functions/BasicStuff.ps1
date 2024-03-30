function Compare-IsHashMatch {
  param ($Hash, $File)
  $_hash = ((Get-FileHash $File -Algorithm MD5 | 
      Select-Object Hash) -split " ").Trim("@{Hash=}")
  if ($_hash -ne $Hash) { return $false }
  else { return $true }
}

function Confirm-IsQuickBooksInstalled {
  foreach ($path in $qbPathList) {
    if (Test-Path "${env:ProgramFiles(x86)}\$path\QBPOSShell.exe" -PathType Leaf) { return $true }
    else { return $false }
  }
}

function Clear-IntuitData {`
  # Delete Intuit POS installation debris
  Write-Host -NoNewLine "Removing junk files... "
  
  foreach ($path in $qbPathList) {
    # remove quickbooks pos program data folder
    Remove-Item "$env:ProgramData\$path" -Recurse -Force >$null 2>&1 
    # remove folder of the last quickbooks pos version installed
    Remove-Item "${env:ProgramFiles(x86)}\$path" -Recurse -Force >$null 2>&1
    # remove previous copy of sample practice company
    Remove-Item "$env:PUBLIC\Documents\$path\Data\Sample Practice" -Recurse -Force >$null 2>&1
  }
  
  # Remove entitlement data store
  Remove-Item -Path $CLIENT_MODULE_DATA_PATH -Recurse -Force >$null 2>&1
  Write-Host "Done"
}

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

<#
function Remove-TemporaryActvationFiles {
  if (Test-Path "$qbactivator_temp") { 
    Remove-Item $qbactivator_temp -Recurse -Force
  }
}
#>
