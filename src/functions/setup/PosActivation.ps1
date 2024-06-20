function Start-PosActivation {
  Stop-QuickBooksProcesses
  
  switch ($Script:QUICKBOOKS_IS_INSTALLED) {
    $true {
      Repair-LevelOne_GenuineClientModule
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
