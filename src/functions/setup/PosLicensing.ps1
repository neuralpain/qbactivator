function Write-License {
  param([String]$LNumber, [String]$PNumber)
  return '<Registration InstallDate="" LicenseNumber="', $LNumber, '" ProductNumber="', $PNumber, '"/>' -join ''
}

function Get-UserOwnLicense {
  <#
  .NOTES
    Triggered by `Write-LieResponse`
  #>
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

function Install-IntuitLicense {
  Clear-IntuitData
  Write-Host -NoNewLine "Installing registration keys... "
  
  switch (Get-Version) {
    $POS19InstObj.VerNum {
      $path = $POS19InstObj.Path
      mkdir $env:ProgramData\$path >$null 2>&1
      Out-File -FilePath $env:ProgramData\$path\qbregistration.dat `
               -InputObject (Get-License) `
               -Encoding UTF8 `
               -NoNewline
    }
    
    $POS18InstObj.VerNum {
      $path = $POS18InstObj.Path
      mkdir $env:ProgramData\$path >$null 2>&1
      Out-File -FilePath $env:ProgramData\$path\qbregistration.dat `
               -InputObject (Get-License) `
               -Encoding UTF8 `
               -NoNewline
    }
    
    $POS12InstObj.VerNum {
      $path = $POS12InstObj.Path
      mkdir $env:ProgramData\$path >$null 2>&1
      Out-File -FilePath $env:ProgramData\$path\qbregistration.dat `
               -InputObject (Get-License) `
               -Encoding UTF8 `
               -NoNewline
    }

    $POS11InstObj.VerNum {
      $path = $POS11InstObj.Path
      mkdir $env:ProgramData\$path >$null 2>&1
      Out-File -FilePath $env:ProgramData\$path\qbregistration.dat `
               -InputObject (Get-License) `
               -Encoding UTF8 `
               -NoNewline
    }
  }
  
  # Pause # Debug
  Write-Host "Done"
}

function Get-IntuitLicense {
  param ($Hash)
  
  switch ($Hash) {
    $POS19InstObj.Hash {
      Set-Version $POS19InstObj.VerNum
      $Script:INSTALLER_SIZE = $POS19InstObj.Size
      $Script:INSTALLER_BYTES = $POS19InstObj.XByte
      
      if ($Script:CUSTOM_LICENSING) {
        return
      } elseif ($Script:SECOND_STORE) {
        Set-License (Write-License -LNumber $POS19InstObj.LNum2 -PNumber $POS19InstObj.PNum)
      } else {
        Set-License (Write-License -LNumber $POS19InstObj.LNum1 -PNumber $POS19InstObj.PNum)
      }
    } 

    $POS18InstObj.Hash {
      Set-Version $POS18InstObj.VerNum
      $Script:INSTALLER_SIZE = $POS18InstObj.Size
      $Script:INSTALLER_BYTES = $POS18InstObj.XByte

      if ($Script:CUSTOM_LICENSING) {
        return
      } elseif ($Script:SECOND_STORE) {
        Set-License (Write-License -LNumber $POS18InstObj.LNum2 -PNumber $POS18InstObj.PNum)
      } else {
        Set-License (Write-License -LNumber $POS18InstObj.LNum1 -PNumber $POS18InstObj.PNum)
      }
    } 

    $POS12InstObj.Hash {
      Set-Version $POS12InstObj.VerNum
      $Script:INSTALLER_SIZE = $POS12InstObj.Size
      $Script:INSTALLER_BYTES = $POS12InstObj.XByte

      if ($Script:CUSTOM_LICENSING) {
        return
      } elseif ($Script:SECOND_STORE) {
        Set-License (Write-License -LNumber $POS12InstObj.LNum2 -PNumber $POS12InstObj.PNum)
      } else {
        Set-License (Write-License -LNumber $POS12InstObj.LNum1 -PNumber $POS12InstObj.PNum)
      }
    } 
    
    $POS11InstObj.Hash {
      Set-Version $POS11InstObj.VerNum
      $Script:INSTALLER_SIZE = $POS11InstObj.Size
      $Script:INSTALLER_BYTES = $POS11InstObj.XByte

      if ($Script:CUSTOM_LICENSING) {
        return
      } elseif ($Script:SECOND_STORE) {
        Set-License (Write-License -LNumber $POS11InstObj.LNum2 -PNumber $POS11InstObj.PNum)
      } else {
        Set-License (Write-License -LNumber $POS11InstObj.LNum1 -PNumber $POS11InstObj.PNum)
      }
    } 
  }
}
