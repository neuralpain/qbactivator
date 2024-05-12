function Write-HeaderLabel {
  Clear-Terminal
  Format-Text " qbactivator `n" -Foreground White -Background DarkGreen -Formatting Bold
  
  # store selection information
  if ($Script:SECOND_STORE) {
    Write-Host "Workstation: $(Format-Text "Secondary Server" -Foreground DarkYellow)"
  } elseif ($Script:ADDITIONAL_CLIENTS) {
    Write-Host "Workstation: $(Format-Text "Additional Clients and Other" -Foreground DarkYellow)"
  } else {
    Write-Host "Workstation: $(Format-Text "Primary Server (Default)" -Foreground DarkYellow)"
  }
  
  # quickbooks installation status
  if ($Script:QUICKBOOKS_IS_INSTALLED) {
    Write-Host "QuickBooks POS: $(Format-Text "Installed" -Foreground Green)"
    Write-Host "Path: $(Format-Text "$($Script:QUICKBOOKS_INSTALLED_PATH)" -Foreground Green)"
  } else {
    Write-Host "QuickBooks POS: $(Format-Text "Not installed" -Foreground DarkYellow)"
    Write-Host "Path: $(Format-Text "Unavailable" -Foreground DarkYellow)"
  }  
  
  # pos version
  if (Get-Version -ne $null) {
    Write-Host "POS Version: $(Format-Text "POS v$(Get-Version)" -Foreground DarkYellow)"
  } elseif (-not($Script:QUICKBOOKS_IS_INSTALLED)) {
    Write-Host "POS Version: $(Format-Text "Unknown" -Foreground DarkYellow)"
  }

  Write-Host # break line
}

function Write-InfoLink {
  param([Switch]$WithFAQs, [Switch]$ReturnToMenu)
  Write-Host "`nFor more information, visit:" -ForegroundColor White
  Write-Host "https://github.com/neuralpain/qbactivator" -ForegroundColor Green
  if ($WithFAQs) { Write-Host "https://github.com/neuralpain/qbactivator/wiki/FAQs" -ForegroundColor Green }
  if ($ReturnToMenu) { $Script:RUN_NEXT_PROCEDURE = $null }
}

function Write-WaitingScreen {
  Write-HeaderLabel
  Write-Host "QuickBooks software installation in progress..." -ForegroundColor White
  Write-Host "`nPlease ensure that the QuickBooks software is completely`ninstalled on your system. Activation will proceed after`nthe installation is completed."
  Write-Host "`nIf you need to cancel the installation for any reason, `nplease close this window afterwards." -ForegroundColor Cyan
  Write-InfoLink
}

function Write-Action_ExitActivator {
  Write-Host "---"
  Write-Host "Exiting qbactivator..." -ForegroundColor Yellow
  Start-Sleep -Milliseconds $TIME_BLINK
}

function Write-Action_OperationCancelled {
  Write-Host "---"
  Write-Host "Operation cancelled by user." -ForegroundColor Yellow
  Start-Sleep -Milliseconds $TIME_BLINK
}

function Write-Action_OptionUnavailable {
  Write-Host "---"
  Write-Host "Disabled when QuickBooks is installed." -ForegroundColor Yellow
  Start-Sleep -Milliseconds $TIME_NORMAL
}
