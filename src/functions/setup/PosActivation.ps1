function Start-PosActivation {
  Stop-QuickBooksProcesses
  &$VerifyIfQuickBooksIsInstalled
  
  switch ($Script:QUICKBOOKS_IS_INSTALLED) {
    $true {
      Repair-GenuineClientModule_LevelOne
      break 
    }
    $false {
      Write-Error_QuickBooksNotInstalled
      Invoke-NextProcess $PROC_RETURN_MAIN
      break
    }
  }

  Install-ClientModule # inject modified client module
  Write-Host "Proceeding with activation..."
  Start-Sleep -Milliseconds $TIME_SLOW
}
