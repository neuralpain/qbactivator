function Start-PosActivation {
  Clear-Terminal
  
  if ($Script:QUICKBOOKS_IS_INSTALLED) {
    Stop-QuickBooksProcesses
    # check for any errors with the client module
    Repair-LevelOne_GenuineClientModule
  }
  else {
    Write-Error_QuickBooksNotInstalled
    Invoke-NextProcess PROC_RETURN_MAIN
  }

  Install-ClientModule # inject modified client module
  Write-Host "Proceeding with activation..."
  Start-Sleep -Milliseconds $TIME_SLOW
}
