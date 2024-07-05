function Write-License {
  param([String]$LicenseNumber, [String]$ProductNumber)
  return '<Registration InstallDate="" LicenseNumber="', $LicenseNumber, '" ProductNumber="', $ProductNumber, '"/>' -join ''
}

function Install-IntuitLicense {
  if ($Script:CUSTOM_LICENSING) {
    return
  }
  
  Write-Host -NoNewLine "Installing registration keys... "
  
  switch (Get-Version) {
    $POS19InstObj.VerNum {
      $path = $POS19InstObj.Path
      mkdir $env:ProgramData\$path | Out-Null
      Out-File -FilePath $env:ProgramData\$path\qbregistration.dat `
               -InputObject (Get-License) `
               -Encoding UTF8 `
               -NoNewline
    }
    
    $POS18InstObj.VerNum {
      $path = $POS18InstObj.Path
      mkdir $env:ProgramData\$path | Out-Null
      Out-File -FilePath $env:ProgramData\$path\qbregistration.dat `
               -InputObject (Get-License) `
               -Encoding UTF8 `
               -NoNewline
    }
    
    $POS12InstObj.VerNum {
      $path = $POS12InstObj.Path
      mkdir $env:ProgramData\$path | Out-Null
      Out-File -FilePath $env:ProgramData\$path\qbregistration.dat `
               -InputObject (Get-License) `
               -Encoding UTF8 `
               -NoNewline
    }

    $POS11InstObj.VerNum {
      $path = $POS11InstObj.Path
      mkdir $env:ProgramData\$path | Out-Null
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
        Set-License (Write-License -LicenseNumber $POS19InstObj.LNum2 -ProductNumber $POS19InstObj.PNum)
      } elseif ($Script:ADDITIONAL_CLIENTS) {
        $_license = ($pos19_licenses | Get-Random)
        Set-License (Write-License -LicenseNumber $_license -ProductNumber $POS19InstObj.PNum)
      } else {
        Set-License (Write-License -LicenseNumber $POS19InstObj.LNum1 -ProductNumber $POS19InstObj.PNum)
      }
    }

    $POS18InstObj.Hash {
      Set-Version $POS18InstObj.VerNum
      $Script:INSTALLER_SIZE = $POS18InstObj.Size
      $Script:INSTALLER_BYTES = $POS18InstObj.XByte

      if ($Script:CUSTOM_LICENSING) {
        return
      } elseif ($Script:SECOND_STORE) {
        Set-License (Write-License -LicenseNumber $POS18InstObj.LNum2 -ProductNumber $POS18InstObj.PNum)
      } elseif ($Script:ADDITIONAL_CLIENTS) {
        $_license = ($pos18_licenses | Get-Random)
        Set-License (Write-License -LicenseNumber $_license -ProductNumber $POS18InstObj.PNum)
      } else {
        Set-License (Write-License -LicenseNumber $POS18InstObj.LNum1 -ProductNumber $POS18InstObj.PNum)
      }
    }

    $POS12InstObj.Hash {
      Set-Version $POS12InstObj.VerNum
      $Script:INSTALLER_SIZE = $POS12InstObj.Size
      $Script:INSTALLER_BYTES = $POS12InstObj.XByte

      if ($Script:CUSTOM_LICENSING) {
        return
      } elseif ($Script:SECOND_STORE) {
        Set-License (Write-License -LicenseNumber $POS12InstObj.LNum2 -ProductNumber $POS12InstObj.PNum)
      } elseif ($Script:ADDITIONAL_CLIENTS) {
        $_license = ($pos12_licenses | Get-Random)
        Set-License (Write-License -LicenseNumber $_license -ProductNumber $POS12InstObj.PNum)
      } else {
        Set-License (Write-License -LicenseNumber $POS12InstObj.LNum1 -ProductNumber $POS12InstObj.PNum)
      }
    }
    
    $POS11InstObj.Hash {
      Set-Version $POS11InstObj.VerNum
      $Script:INSTALLER_SIZE = $POS11InstObj.Size
      $Script:INSTALLER_BYTES = $POS11InstObj.XByte

      if ($Script:CUSTOM_LICENSING) {
        return
      } elseif ($Script:SECOND_STORE) {
        Set-License (Write-License -LicenseNumber $POS11InstObj.LNum2 -ProductNumber $POS11InstObj.PNum)
      } elseif ($Script:ADDITIONAL_CLIENTS) {
        $_license = ($pos11_licenses | Get-Random)
        Set-License (Write-License -LicenseNumber $_license -ProductNumber $POS11InstObj.PNum)
      } else {
        Set-License (Write-License -LicenseNumber $POS11InstObj.LNum1 -ProductNumber $POS11InstObj.PNum)
      }
    }
  }
}
