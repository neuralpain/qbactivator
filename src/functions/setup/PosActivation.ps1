function Start-PosActivation {
  Stop-QuickBooksProcesses
  Repair-GenuineClientModule # if damaged
  
  # toll gate #1 --------- why?
  if ($null -eq $Script:RUN_PROCEDURE) { return }
  
  &$VerifyIfQuickBooksIsInstalled
  if (-not($Script:QUICKBOOKS_IS_INSTALLED)) {
    Write-Error_QuickBooksNotInstalled
    $Script:RUN_PROCEDURE = $null
  }

  # toll gate #2
  if ($null -eq $Script:RUN_PROCEDURE) { return }

  # Find-GenuineClientModule # will exit if missing
  Install-ClientModule # inject modified client module
  Write-Host "Proceeding with activation..."
  Start-Sleep -Milliseconds $TIME_SLOW
}
