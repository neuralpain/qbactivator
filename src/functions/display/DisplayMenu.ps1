<#
  Menu Shortcuts / HotKeys
    100: Exit Qbactivator
    200: Open Troubleshooting Menu
    300: Open wiki
    500: Open logs
#>

function Write-Menu_Main {
  &$InitializeMain
  &$VerifyIfQuickBooksIsInstalled
  Write-HeaderLabel
  Write-Host "$(Format-Text "Select activation option" -Foreground Gray -Formatting Bold, Underline)`n"
  Write-Host "1 - POS Primary Server/Workstation"
  Write-Host "2 - POS Secondary Server/Workstation"
  Write-Host "3 - POS Client Workstations"
  Write-Host "4 - I have my own license :p"
  Write-Host "5 - Troubleshooting"
  Write-Host "6 - Refresh qbactivator"
  Write-Host "0 - Exit"
  $query = Read-Host "`n#"
  
  switch ($query) {
    0 { &$ExitQbactivator }
    10 { &$InvokeGeneralActivation }
    100 { &$ExitQbactivator }
    200 { Invoke-NextProcess $PROC_TROUBLESHOOT }
    300 { &$OpenWiki; Write-Menu_Main }
    500 { &$OpenLogs; Write-Menu_Main }
    1 {
      $Script:SECOND_STORE = $false
      $Script:ADDITIONAL_CLIENTS = $false
      Write-Menu_SubMenu 
    }
    2 {
      $Script:SECOND_STORE = $true
      $Script:ADDITIONAL_CLIENTS = $false
      Write-Menu_SubMenu
    }
    3 {
      $Script:SECOND_STORE = $false
      $Script:ADDITIONAL_CLIENTS = $true
      Write-Menu_SubMenu
    }
    4 {
      &$CheckQuickBooksIsInstalled_ReturnToMainMenu
      Write-LieResponse
      if ($null -eq $Script:RUN_NEXT_PROCEDURE) {
        Write-Menu_SubMenu
      }
    }
    5 {
      &$CheckQuickBooksIsNotInstalled_ReturnToMainMenu
      Invoke-NextProcess $PROC_TROUBLESHOOT
    }
    6 {
      &$InitializeMain
      &$VerifyIfQuickBooksIsInstalled    
      Invoke-NextProcess $PROC_RETURN_MAIN
    }
    default { Invoke-NextProcess $PROC_RETURN_MAIN }
  }
}

function Write-Menu_SubMenu {
  Write-HeaderLabel
  Write-Host "$(Format-Text "Select next operation" -Foreground Gray -Formatting Bold, Underline)`n"
  Write-Host "1 - Install & Activate"
  Write-Host "2 - Activate Only"
  Write-Host "3 - Install Only"
  Write-Host "4 - Download a POS installer"
  
  Write-Host "0 - Cancel"
  $query = Read-Host "`n#"
  Write-Host -NoNewLine "Selected: $query"; Write-Host -NoNewLine "`r                              `r" # To transcript # Debug
  switch ($query) {
    0 { 
      $Script:SECOND_STORE = $false
      $Script:ADDITIONAL_CLIENTS = $false
      Write-Menu_Main
      break
    }
    10 { &$InvokeGeneralActivation }
    100 { &$ExitQbactivator }
    200 { Invoke-NextProcess $PROC_TROUBLESHOOT }
    300 { &$OpenWiki; Write-Menu_SubMenu }
    500 { &$OpenLogs; Write-Menu_SubMenu }
    1 {
      &$CheckQuickBooksIsInstalled_ReturnToMainMenu
      Invoke-NextProcess $PROC_LICENSE
      break
    }
    2 {
      &$CheckQuickBooksIsNotInstalled_ReturnToMainMenu
      Invoke-NextProcess $PROC_ACTIVATE
      break
    }
    3 {
      $Script:QUICKBOOKS_INSTALL_ONLY = $true
      &$CheckQuickBooksIsInstalled_ReturnToMainMenu
      Invoke-NextProcess $PROC_LICENSE
      break
    }
    4 {
      $Script:INSTALLER_DOWNLOAD_ONLY = $true
      Invoke-NextProcess $PROC_DOWNLOAD
      break
    }
    default { Write-Menu_SubMenu; break }
  }
}

function Write-Menu_VersionSelection {
  Write-HeaderLabel
  Write-Host "$(Format-Text "Select QuickBooks POS verison" -Foreground Gray -Formatting Bold, Underline)`n"
  Write-Host "11 - QuickBooks POS 2013"
  Write-Host "12 - QuickBooks POS 2015"
  Write-Host "18 - QuickBooks POS 2018"
  Write-Host "19 - QuickBooks POS 2019"
  Write-Host "0 --- Cancel"
  $query = Read-Host "`nVersion"
  Set-Version $query

  # allow exit at any point in time
  switch ($query) {
    10 { &$InvokeGeneralActivation }
    100 { &$ExitQbactivator }
    200 { Invoke-NextProcess $PROC_TROUBLESHOOT }
    300 { &$OpenWiki; Write-Menu_VersionSelection }
    500 { &$OpenLogs; Write-Menu_VersionSelection }
  }
}

function Write-Menu_Troubleshooting {
  Write-HeaderLabel
  Write-Host "$(Format-Text "Select troubleshooting option" -Foreground Gray -Formatting Bold, Underline)`n"
  Write-Host "1 - Lv1 Client module: Restore"
  Write-Host "2 - Lv2 Client module: Repair"
  Write-Host "3 - Lv3 Client module: Re-activation"
  Write-Host "4 - Lv4 Re-install QuickBooks"
  Write-Host "5 - QuickBooks Patch Test"
  Write-Host "6 - View links to stuff"
  Write-Host "0 - Back"
  $query = Read-Host "`n#"
  Write-Host -NoNewLine "Selected: $query"; Write-Host -NoNewLine "`r                              `r" # To transcript # Debug
  switch ($query) {
    0 { Write-Menu_Main; break }
    10 { &$InvokeGeneralActivation }
    100 { &$ExitQbactivator }
    200 { Invoke-NextProcess $PROC_TROUBLESHOOT }
    300 { &$OpenWiki; Write-Menu_Troubleshooting }
    500 { &$OpenLogs; Write-Menu_Troubleshooting }
    1 {
      Stop-QuickBooksProcesses
      Repair-LevelOne_GenuineClientModule
      Write-Menu_Troubleshooting
      break
    }
    2 {
      Stop-QuickBooksProcesses
      Repair-LevelTwo_GenuineClientModule_SanityCheck
      Write-Menu_Troubleshooting
      break
    }
    3 {
      Repair-LevelThree_Reactivation
      Write-Host "Starting reactivation process..."
      Invoke-NextProcess $PROC_ACTIVATE
      break
    }
    4 { 
      Write-Error_UninstallUnsupported
      Write-Menu_Troubleshooting
      break
    }
    5 {
      Stop-QuickBooksProcesses
      Install-ClientModule
      Write-Menu_Troubleshooting
      break
    }
    6 { Write-Menu_LinkOptions; break }
    default { Write-Menu_Troubleshooting; break }
  }
}

function Write-Menu_LinkOptions {
  Write-HeaderLabel
  Write-Host "$(Format-Text "Select a link to jump to" -Foreground Gray -Formatting Bold, Underline)`n"
  Write-Host "1 - View the qbactivator Wiki"
  Write-Host "2 - Terminate QuickBooks processes"
  Write-Host "3 - View qbactivator logs"
  Write-Host "0 - Back"
  $query = Read-Host "`n#"
  Write-Host -NoNewLine "Selected: $query"; Write-Host -NoNewLine "`r                              `r" # To transcript # Debug
  switch ($query) {
    0 { Write-Menu_Troubleshooting; break }
    10 { &$InvokeGeneralActivation }
    100 { &$ExitQbactivator }
    200 { Invoke-NextProcess $PROC_TROUBLESHOOT }
    300 { &$OpenWiki; Write-Menu_LinkOptions }
    500 { &$OpenLogs; Write-Menu_LinkOptions }
    1 {
      Write-Host "Opening qbactivator Wiki..."
      &$OpenWiki
      Write-Menu_LinkOptions
      break
    }
    2 { 
      Stop-QuickBooksProcesses
      Write-Menu_LinkOptions
      break
    }
    3 {
      &$OpenLogs
      Write-Menu_LinkOptions
      break
    }
    default { Write-Menu_LinkOptions; break }
  }
}
