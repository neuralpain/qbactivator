<# --- WRITE-INFO --- #>

function Write-HeaderLabel {
  param ([string]$Mssg)
  if (-not($Mssg -eq "")) { $Mssg = "- $Mssg " }
  Clear-Host; Write-Host "`n qbactivator $Mssg`n" -ForegroundColor White -BackgroundColor DarkGreen
}

function Write-InfoLink {
  param([Switch]$WithFAQs, [Switch]$NoExit)
  Write-Host "`nFor more information, visit:" -ForegroundColor White
  Write-Host "https://github.com/neuralpain/qbactivator" -ForegroundColor Green
  if ($WithFAQs) { Write-Host "https://github.com/neuralpain/qbactivator/wiki/FAQs" -ForegroundColor Green }
  if (-not($NoExit)) { exit $PAUSE }
}

function Write-WaitingScreen {
  Write-HeaderLabel
  Write-Host "QuickBooks software installation in progress..." -ForegroundColor White
  Write-Host "`nPlease ensure that the QuickBooks software is completely`ninstalled on your system. Activation will proceed after`nthe installation is completed."
  Write-Host "`nIf you need to cancel the installation for any reason,`nplease close this window afterwards." -ForegroundColor Cyan
  Write-InfoLink -NoExit
}

# --- FUNCTION MSSG --- #

function Write-MainMenu {
  Write-HeaderLabel
  Write-Host "Select QuickBooks product"
  Write-Host "-------------------------"
  Write-Host "1 - POS Store 1 (Server/Client)"
  Write-Host "2 - POS Store 2 (Server/Client)"
  Write-Host "3 - I have my own license :p"
  Write-Host "4 - Troubleshooting"
  Write-Host "0 - Exit"
  $query = Read-Host "`n#"
  
  switch ($query) {
    0 { Write-Action_ExitActivator; exit $NONE }
    1 { Invoke-QuickBooksInstaller }
    2 { 
      $Script:SECOND_STORE = $true
      Invoke-QuickBooksInstaller
    }
    3 { 
      Write-LieResponse
      Invoke-QuickBooksInstaller
    }
    4 { Write-TroubleshootingMenu }
    default { Write-MainMenu }
  }
}

function Write-TroubleshootingMenu {
  Write-HeaderLabel
  Write-Host "Select troubleshooting option"
  Write-Host "-----------------------------"
  Write-Host "1 - General QuickBooks activation"
  Write-Host "2 - Lv0 Terminate QuickBooks Processes"
  Write-Host "3 - Lv1 Client module: Restore"
  Write-Host "4 - Lv2 Client module: Repair"
  Write-Host "5 - Lv3 Client module: Re-activation"
  Write-Host "6 - Lv4 Re-install QuickBooks" 
  Write-Host "0 - Back"
  $query = Read-Host "`n#"
  switch ($query) {
    1 {
      Write-Action_OptionUnavailable 
      Write-TroubleshootingMenu
    }
    10 {
      Clear-Host; Write-Host
      Invoke-Activation -GeneralActivation
    }
    2 { 
      Clear-Host; Write-Host
      Stop-QuickBooksProcesses
      Write-TroubleshootingMenu
    }
    3 {
      Repair-ClientDataModulePatch
      Write-TroubleshootingMenu
    }
    4 {
      Repair-GenuineClientModule -SanityCheck
      Write-TroubleshootingMenu 
    }
    5 {
      Clear-ClientActivationFolder
      Write-Host "Starting reactivation process..."
      Invoke-Activation -ActivationOnly
    }
    6 { 
      Write-Error_UninstallUnsupported
      Write-TroubleshootingMenu
    }
    0 { Write-MainMenu }
    default { Write-TroubleshootingMenu }
  }
}

function Write-LieScolding {
  # from `Write-LieResponse`
  param($Mssg, [Switch]$ReadAKey)

  Clear-Host
  Write-Host "`n$Mssg" -ForegroundColor White -BackgroundColor DarkRed
  Write-InfoLink -NoExit

  if ($ReadAKey) { Read-Host }
  else { Start-Sleep -Milliseconds $TIME_SLOW }

  Write-MainMenu
}

function Write-LieResponse {
  # from `Write-MainMenu`
  Write-HeaderLabel
  Write-Host "Do you really have one?`n"
  Write-Host "1. No, I lied."
  Write-Host "2. I have a cat."
  Write-Host "3. I can't remeber it."
  Write-Host "4. My dog ate my license."
  Write-Host "5. Yes, I do."
  Write-Host "6. I just wanted to see what would happen."
  $query = Read-Host "`n#"
    
  switch ($query) {
    1 { Write-LieScolding "Lying is bad." }
    2 { Write-LieScolding "Having a cat does not make you a good person." }
    3 { Write-LieScolding "It's likely you never will." }
    4 { Write-LieScolding "Ha ha... nice try." }
    5 { Get-UserOwnLicense }
    6 { Write-LieScolding "And now you've wasted both our time." -ReadAKey }
    default { Write-LieResponse }
  }
}

function Write-SubMenu_NoInstallerFound {
  Write-HeaderLabel
  Write-Host "Select next operation"
  Write-Host "---------------------"
  Write-Host "1 - Request software activation"
  Write-Host "2 - Download and install QuickBooks POS"
  Write-Host "3 - Locate installer"
  Write-Host "0 - Cancel"
  $query = Read-Host "`n#"
  
  switch ($query) {
    0 { Write-Action_OperationCancelled; Write-MainMenu }
    1 { Invoke-Activation -ActivationOnly }
    2 { 
      Select-QuickBooksVersion
      Get-QuickBooksInstaller -Version (Get-Version) 
      break 
    }
    3 { break }
    default { Write-SubMenu_NoInstallerFound }
  }   
  
  Invoke-QuickBooksInstaller
}

function Write-VersionSelectionMenu {
  Write-HeaderLabel
  Write-Host "Select QuickBooks POS verison"
  Write-Host "Only enter the version number" -ForegroundColor Yellow
  Write-Host "-----------------------------"
  Write-Host "v11 - QuickBooks POS 2013"
  Write-Host "v12 - QuickBooks POS 2015"
  Write-Host "v18 - QuickBooks POS 2018"
  Write-Host "v19 - QuickBooks POS 2019"
  Write-Host "0 --- Cancel"
}  

# --- ACTION MSSG --- #

function Write-Action_ExitActivator {
  Write-Host "---"
  Write-Host -NoNewline "Exiting qbactivator..." -ForegroundColor Yellow
  Start-Sleep -Milliseconds $TIME_BLINK
}

function Write-Action_OperationCancelled {
  Write-Host "---"
  Write-Host -NoNewline "Operation cancelled by user." -ForegroundColor Yellow
  Start-Sleep -Milliseconds $TIME_BLINK
}

function Write-Action_OptionUnavailable {
  Write-Host "---"
  Write-Host -NoNewline "This function has been temporarily disabled." -ForegroundColor Yellow
  Start-Sleep -Milliseconds $TIME_NORMAL
}

# --- ERROR MSSG --- #

function Write-Error_UninstallUnsupported {
  Clear-Host
  Write-Host "`nThis operation is currently unsupported" -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nUnfortunately, uninstallation of QuickBooks software`na manual process and is not currently supported by`nqbactivator. After uninstalling the software, you`ncan use qbactivator to install and activate again." -ForegroundColor White
  Write-InfoLink -NoExit
  Write-Host; Pause
}
function Write-Error_IsManualAdministrator {
  Clear-Host
  Write-Host "`nUser started as Administrator" -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nDo not manually (right-click) run qbactivator as`nadministrator. This will result in errors during`ninstallation. Please restart the script." -ForegroundColor White
  Write-InfoLink
}

function Write-Error_CannotStartInstaller {
  Clear-Host
  Write-Host "`nUnable to execute the installer" -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nPlease ensure that you are using a genuine installer`ndownloaded from Intuit." -ForegroundColor White
  Write-InfoLink
}

function Write-Error_NoInternetConnectivity {
  Clear-Host
  Write-Host "`nUnable to start the download" -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nThere is no internet connectivity at this time.`nPlease check the connection and try again." -ForegroundColor White
  Write-InfoLink
}  

function Write-Error_QuickBooksIsInstalled {
  Clear-Host
  Write-Host "`nA version of QuickBooks is already installed" -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nAll previous versions must be removed before installation." -ForegroundColor Yellow
  Write-Host "`nIf you are requesting activation-only, remove the installer`nfrom this location and restart the activator. The activator`nimmediately checks for a QuickBooks installation executable`nand runs it if one is available." -ForegroundColor White
  Write-InfoLink
}  

function Write-Error_QuickBooksNotInstalled {
  Clear-Host
  Write-Host "`nQuickBooks is not installed on the system" -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nThe activation cannot be completed." -ForegroundColor Yellow
  Write-Host "`nPlease ensure that a QuickBooks product is correctly and`ncompletely installed before requesting activation." -ForegroundColor White
  Write-InfoLink
}

function Write-Error_FileNotFound($File) {
  Clear-Host
  Write-Host "`nThe requested file could not be downloaded" -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nThe file was not found on the server at `"$File`"" -ForegroundColor White
  Write-Host "Please submit this issue to @neuralpain. Thank you." -ForegroundColor White
  Write-InfoLink
}

function Write-Error_IncorrectLicense {
  param(
    [Switch]$LicenseNumber, 
    [Switch]$ProductNumber
  )

  Clear-Host
  
  if ($LicenseNumber) {
    Write-Host "`nLicense number must be 18 characters long!" -ForegroundColor White -BackgroundColor DarkRed
    Write-Host "`nCheck your license and try again." -ForegroundColor White
  }

  if ($ProductNumber) {
    Write-Host "`nProduct number must be 7 characters long!" -ForegroundColor White -BackgroundColor DarkRed
    Write-Host "`nCheck your license and try again." -ForegroundColor White
  }

  Start-Sleep -Milliseconds $TIME_SLOW

  $query = Read-Host "`nTry again? (y/N)"

  switch ($query) {
    "y" { Get-UserOwnLicense }
    default { Write-MainMenu }
  }
}
