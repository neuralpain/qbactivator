function Get-UserOwnLicense {
  Clear-Terminal
  Write-Host "Enter a valid license below`n" -ForegroundColor White -BackgroundColor DarkCyan
  Write-Host "A valid license pattern: 0000-0000-0000-000" -ForegroundColor White
  Write-Host "A valid product key pattern: 000-000`n" -ForegroundColor White

  $custom_license_number = Read-Host "License"
  $custom_product_number = Read-Host "Product Key"
  
  Write-Host "`nIs this license information correct? (Y/n): " -ForegroundColor Yellow -NoNewline
  $query = Read-Host

  switch ($query) {
    "n" { Get-UserOwnLicense }
    default { break }
  }

  if ($custom_license_number.Length -lt 18 -or $custom_license_number.Length -gt 18 -or $custom_product_number.Length -lt 7 -or $custom_product_number.Length -gt 7) { 
    Clear-Terminal
    Write-Host "`nLicense is invalid" -ForegroundColor White -BackgroundColor DarkRed
    Write-Host "`nCheck your license and try again." -ForegroundColor White
    $query = Read-Host "`nTry again? (y/N)"
    Write-Host -NoNewLine "Selected: $query"; Write-Host -NoNewLine "`r                              `r" # To transcript # Debug
    switch ($query) {
      "y" { Get-UserOwnLicense; break }
      default { $Script:RUN_NEXT_PROCEDURE = $null; break }
    }
  }
  
  Set-License (Write-License $custom_license_number $custom_product_number)
  $Script:CUSTOM_LICENSING = $true
}
