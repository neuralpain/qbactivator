<# --- WRITE-INFO --- #>

function Write-CannotStartInstaller {
  Clear-Host
  Write-Host "`nUnable to execute the installer." -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nPlease ensure that you are using a genuine installer`ndownloaded from Intuit." -ForegroundColor White
  Write-InfoLink
}

function Write-HeaderLabel {
  param ([string]$Mssg)
  if (-not($Mssg -eq "")) { $Mssg = "- $Mssg " }
  Write-Host "`n qbactivator $Mssg" -ForegroundColor White -BackgroundColor DarkGreen
}  

function Write-InfoLink {
  Write-Host "`nFor more information, visit:" -ForegroundColor White
  Write-Host "https://github.com/neuralpain/qbactivator" -ForegroundColor Green
}      

function Write-FileNotFound($File) {
  Clear-Host
  Write-Host "`nThe requested file could not be downloaded." -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nThe file was not found on the server at `"$File`"" -ForegroundColor White
  Write-Host "Please submit this issue to @neuralpain. Thank you." -ForegroundColor White
  Write-InfoLink
}

function Write-MainMenu {
  Clear-Host
  Write-HeaderLabel
  Write-Host "`nSelect QuickBooks product"
  Write-Host "-------------------------"
  Write-Host "1 - POS Store 1 (Server/Client)"
  Write-Host "2 - POS Store 2 (Server/Client)"
  Write-Host "3 - General QuickBooks activation"
  Write-Host "    ^^^^ Pro/Enterprise/Other ^^^^"
  Write-Host "0 - Exit"
  $query = Read-Host "`n#"
  
  switch ($query) {
    0 { Write-ExitActivator; exit $NONE }
    1 { Invoke-QuickBooksInstaller }
    2 { 
      $script:SECOND_STORE = $true
      Invoke-QuickBooksInstaller
    }
    # 3 { Write-OptionUnavailable; Write-MainMenu }
    3 { Clear-Host; Write-Host; Invoke-Activation -GeneralActivation }
    default { Write-MainMenu }
  }
}

function Write-NextOperationMenu {
  Clear-Host
  Write-HeaderLabel
  Write-Host "`nSelect next operation"
  Write-Host "---------------------"
  Write-Host "1 - Request software activation"
  Write-Host "2 - Download and install QuickBooks POS"
  Write-Host "3 - Locate installer"
  Write-Host "4 - Restore entitlement data"
  Write-Host "0 - Cancel"
  $query = Read-Host "`n#"
  
  switch ($query) {
    0 { Write-OperationCancelled; Write-MainMenu }
    1 { Invoke-Activation -ActivationOnly }
    2 { 
      Select-QuickBooksVersion
      Get-QuickBooksInstaller -Version (Get-Version) 
      break 
    }
    3 { break }
    4 { Remove-ClientDataModulePatch; break }
    default { Write-NextOperationMenu }
  }   
  
  Invoke-QuickBooksInstaller
}  

function Write-NoInternetConnectivity {
  Clear-Host
  Write-Host "`nUnable to start the download." -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nThere is no internet connectivity at this time." -ForegroundColor White
  Write-Host "Please check the connection and try again." -ForegroundColor White
  Write-InfoLink
}  

function Write-QuickBooksIsInstalled {
  Clear-Host
  Write-Host "`nA version of QuickBooks is already installed." -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nAll previous versions must be removed before installation." -ForegroundColor Yellow
  Write-Host "`nIf you are requesting activation-only, remove the installer`nfrom this location and restart the activator. The activator`nimmediately checks for a QuickBooks installation executable`nand runs it if one is available." -ForegroundColor White
  Write-InfoLink
}  

function Write-QuickBooksNotInstalled {
  Clear-Host
  Write-Host "`nQuickBooks is not installed on the system." -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nThe activation cannot be completed." -ForegroundColor Yellow
  Write-Host "`nPlease ensure that a QuickBooks product is correctly and`ncompletely installed before requesting activation." -ForegroundColor White
  Write-InfoLink
}    

function Write-ExitActivator {
  Write-Host "---"
  Write-Host -NoNewline "Exiting qbactivator..." -ForegroundColor Yellow
  Start-Sleep -Milliseconds $TIME_BLINK
}

function Write-OperationCancelled {
  Write-Host "---"
  Write-Host -NoNewline "Operation cancelled by user." -ForegroundColor Yellow
  Start-Sleep -Milliseconds $TIME_BLINK
}

function Write-OptionUnavailable {
  Write-Host "---"
  Write-Host -NoNewline "Unable to perform this action." -ForegroundColor Yellow
  Start-Sleep -Milliseconds $TIME_NORMAL
}

function Write-VersionSelectionMenu {
  Clear-Host
  Write-HeaderLabel
  Write-Host "`nSelect QuickBooks POS verison"
  Write-Host "Only enter the version number" -ForegroundColor Yellow
  Write-Host "-----------------------------"
  Write-Host "v11 - QuickBooks POS 2013"
  Write-Host "v12 - QuickBooks POS 2015"
  Write-Host "v18 - QuickBooks POS 2018"
  Write-Host "v19 - QuickBooks POS 2019"
  Write-Host "0 --- Cancel"
}  

function Write-WaitingScreen {
  Clear-Host; Write-HeaderLabel
  Write-Host "`nQuickBooks software installation in progress..." -ForegroundColor White
  Write-Host "`nPlease ensure that the QuickBooks software is completely`ninstalled on your system. Activation will proceed after`nthe installation is completed."
  Write-Host "`nIf you need to cancel the installation for any reason,`nplease close this window afterwards." -ForegroundColor Cyan
  Write-InfoLink
}
