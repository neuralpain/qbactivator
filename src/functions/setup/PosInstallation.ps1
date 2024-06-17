function Invoke-QuickBooksInstaller {  
  if ($Script:INSTALLER_AVAILABLE) {
    Start-Installer .\$Script:INSTALLER_OBJECT
  }
  else {
    Write-Host "A QuickBooks POS installer was not found." -ForegroundColor Yellow
    Start-Sleep -Milliseconds $TIME_SLOW
    $Script:RUN_NEXT_PROCEDURE = $null
    return
  }
}

function Start-Installer {
  param ($Installer)
  # clear temporary installation files from previous 
  # installer launch and start a new installation process
  Remove-Item $intuit_temp -Recurse -Force >$null 2>&1
  Write-WaitingScreen
  
  try { 
    New-ToastNotification -ToastText "Installing QuickBooks POS..." -ToastTitle "qbactivator"
    Start-Process -FilePath $Installer -Wait 
  }
  catch { Write-Error_CannotStartInstaller }
  
}
