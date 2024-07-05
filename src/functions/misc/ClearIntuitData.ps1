function Clear-IntuitData {
  # Delete Intuit POS installation debris
  Write-Host "Removing previous installation files... "
  
  foreach ($path in $qbPathList) {
    # remove quickbooks pos program data folder
    if (Test-Path "$env:ProgramData\$path") {
      Remove-Item "$env:ProgramData\$path" -Recurse -Force | Out-Null 
      Write-Host "Removed $(Format-Text "$env:ProgramData\$path" -Foreground Yellow -Formatting Underline)"
    }
    # remove folder of the last quickbooks pos version installed
    if (Test-Path "${env:ProgramFiles(x86)}\$path") {
      Remove-Item "${env:ProgramFiles(x86)}\$path" -Recurse -Force | Out-Null
      Write-Host "Removed $(Format-Text "${env:ProgramFiles(x86)}\$path" -Foreground Yellow -Formatting Underline)"
    }
    # remove previous copy of sample practice company
    if (Test-Path "$env:PUBLIC\Documents\$path\Data\Sample Practice") {
      Remove-Item "$env:PUBLIC\Documents\$path\Data\Sample Practice" -Recurse -Force | Out-Null
      Write-Host "Removed sample practice data at`n$(Format-Text "$env:PUBLIC\Documents\$path" -Foreground Yellow -Formatting Underline)"
    }
  }
  
  # Remove entitlement data store
  if (Test-Path "$env:PUBLIC\Documents\$path\Data\Sample Practice") {
    Remove-Item -Path $CLIENT_MODULE_DATA_PATH -Recurse -Force | Out-Null
    Write-Host "Removed activation data at`n$(Format-Text "$CLIENT_MODULE_DATA_PATH" -Foreground Yellow -Formatting Underline)"
  }
}
