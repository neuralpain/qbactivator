function Write-Error_IsManualAdministrator {
  Clear-Terminal
  Write-Host "User started as Administrator" -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nDo not manually (right-click) run qbactivator as`nadministrator. This will result in errors during`ninstallation. Please start the script normally." -ForegroundColor White
  Write-InfoLink -ReturnToMenu
  Pause
}

function Write-Error_CannotStartInstaller {
  Clear-Terminal
  Write-Host "Unable to execute the installer" -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nPlease ensure that you are using a genuine installer`ndownloaded from Intuit." -ForegroundColor White
  Write-InfoLink -ReturnToMenu
  Pause
}

function Write-Error_NoInternetConnectivity {
  Clear-Terminal
  Write-Host "Unable to start the download" -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nThere is no internet connectivity at this time.`nPlease check the connection and try again." -ForegroundColor White
  Write-InfoLink -ReturnToMenu
  Pause
}

function Write-Error_QuickBooksIsInstalled {
  Clear-Terminal
  Write-Host "A version of QuickBooks is already installed" -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nAll previous versions must be removed before installation." -ForegroundColor Yellow
  Write-Host "`nIf you are requesting activation-only, remove the installer`nfrom this location and restart the activator. The activator`nimmediately checks for a QuickBooks installation executable`nand runs it if one is available." -ForegroundColor White
  Write-InfoLink -ReturnToMenu
  Pause
}

function Write-Error_QuickBooksNotInstalled {
  Clear-Terminal
  Write-Host "QuickBooks is not installed on the system" -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nThe activation cannot be completed." -ForegroundColor Yellow
  Write-Host "`nPlease ensure that a QuickBooks product is correctly and`ncompletely installed before requesting activation." -ForegroundColor White
  Write-InfoLink -ReturnToMenu
  Pause
}

function Write-Error_FileNotFound($File) {
  Clear-Terminal
  Write-Host "The requested file could not be downloaded" -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nThe file was not found on the server at `"$File`"" -ForegroundColor White
  Write-Host "Please submit this issue to @neuralpain. Thank you." -ForegroundColor White
  Write-InfoLink -ReturnToMenu
  Pause
}

function Write-Error_UnableToVerifyInstaller {
  Clear-Terminal
  Write-Host "Failed to verify the installer." -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nThe installer `"$Script:INSTALLER_OBJECT`" may be corrupted." -ForegroundColor Yellow
  Write-InfoLink -ReturnToMenu
  Pause
}
