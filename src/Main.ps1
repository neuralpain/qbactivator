function Invoke-NextProcess {
  param ([Parameter(Mandatory = $true)]$NextProcess)
  
  $Script:RUN_NEXT_PROCEDURE = $NextProcess
  
  switch ($NextProcess) {
    $PROC_DOWNLOAD {
      Select-QuickBooksVersion
      Get-QuickBooksObject
      if ($null -eq $Script:RUN_NEXT_PROCEDURE) { break }
      elseif ($Script:INSTALLER_DOWNLOAD_ONLY) {
        &$TestInternetAvailable
        Start-InstallerDownload
        break
      }
      else {
        &$TestInternetAvailable
        Start-InstallerDownload
        Invoke-NextProcess $PROC_LICENSE
      }
    }
    $PROC_LICENSE {
      &$LocateQuickBooksInstaller
      if ($Script:INSTALLER_AVAILABLE) { &$ValidateQuickBooksInstaller }
      else { Invoke-NextProcess $PROC_DOWNLOAD } # get an installer
      Get-IntuitLicense $Script:INSTALLER_HASH
      Install-IntuitLicense
      Invoke-NextProcess $PROC_INSTALL
      break
    }
    $PROC_INSTALL {
      if ($Script:INSTALLER_IS_VALID) {
        Invoke-QuickBooksInstaller
        &$VerifyIfQuickBooksIsInstalled
        if ($Script:QUICKBOOKS_INSTALL_ONLY) { break }
        else { Invoke-NextProcess $PROC_ACTIVATE }
      }
      else { break }
    }
    $PROC_ACTIVATE {
      Start-PosActivation
      if ($null -eq $Script:RUN_NEXT_PROCEDURE) { break }
      else { Invoke-NextProcess $PROC_NEXT_STAGE }
    }
    $PROC_TROUBLESHOOT { Write-Menu_Troubleshooting }
    $PROC_EXIT {
      Write-Action_ExitActivator
      exit $EXIT_QBA
    }
    $PROC_NEXT_STAGE { exit $OK }
    $PROC_RETURN_MAIN { Write-Menu_Main }
    default { Invoke-NextProcess $PROC_RETURN_MAIN }
  }

  Invoke-NextProcess $PROC_RETURN_MAIN
}

# -------- start PowerShell execution -------- #

Start-Transcript $LOG
Clear-Terminal

if ("C:\Windows\system32" -eq $pwd) {
  Write-Error_IsManualAdministrator
  exit $EXIT_QBA
}
else {
  &$VerifyIfQuickBooksIsInstalled
  Write-Menu_Main
}

# -------- end PowerShell execution -------- #

exit
