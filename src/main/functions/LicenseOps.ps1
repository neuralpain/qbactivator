# pos store group 1
$QBREGV11_STORE_1 = '<Registration InstallDate="" LicenseNumber="1063-0575-1585-222" ProductNumber="023-147"/>'
$QBREGV12_STORE_1 = '<Registration InstallDate="" LicenseNumber="6740-7656-8840-594" ProductNumber="448-229"/>'
$QBREGV18_STORE_1 = '<Registration InstallDate="" LicenseNumber="2421-4122-2213-596" ProductNumber="818-769"/>'
$QBREGV19_STORE_1 = '<Registration InstallDate="" LicenseNumber="0106-3903-4389-908" ProductNumber="595-828"/>'

# pos store group 2
$QBREGV11_STORE_2 = '<Registration InstallDate="" LicenseNumber="8432-0480-0178-029" ProductNumber="023-147"/>'
$QBREGV12_STORE_2 = '<Registration InstallDate="" LicenseNumber="0877-0442-6111-615" ProductNumber="448-229"/>'
$QBREGV18_STORE_2 = '<Registration InstallDate="" LicenseNumber="3130-3560-7860-900" ProductNumber="818-769"/>'
$QBREGV19_STORE_2 = '<Registration InstallDate="" LicenseNumber="7447-0864-8898-657" ProductNumber="595-828"/>'

function Clear-IntuitData {
  # Delete Intuit POS installation debris
  
  Write-Host -NoNewLine "Removing junk files... "
  
  foreach ($path in $qbPathList) {
    if (Test-Path "${env:ProgramFiles(x86)}\$path\QBPOSShell.exe" -PathType Leaf) { Write-QuickBooksIsInstalled; exit $PAUSE }
    else {
      Remove-Item -Path $env:ProgramData\Intuit\$path -Recurse -Force >$null 2>&1 # remove pos program data folder
      Remove-Item -Path "${env:ProgramFiles(x86)}\$path" -Recurse -Force >$null 2>&1  # remove installation folder
      Remove-Item -Path "$env:PUBLIC\Documents\$path\Data\Sample Practice" -Recurse -Force >$null 2>&1  #remove previous copy of sample practice 
    }
  }
  
  # Remove entitlement data store
  Remove-Item -Path $CLIENT_MODULE_DATA_PATH -Recurse -Force >$null 2>&1
  Write-Host "Done"
}

function Install-IntuitLicense {
  param ($Version, $License)
  
  Write-Host -NoNewLine "Installing registration keys... "
  
  switch ($Version) {
    19 {
      mkdir $env:ProgramData\$QBPATH19 >$null 2>&1
      Out-File -FilePath $env:ProgramData\$QBPATH19\qbregistration.dat `
               -InputObject $License `
               -Encoding UTF8 `
               -NoNewline
    }
    
    18 {
      mkdir $env:ProgramData\$QBPATH18 >$null 2>&1
      Out-File -FilePath $env:ProgramData\$QBPATH18\qbregistration.dat `
               -InputObject $License `
               -Encoding UTF8 `
               -NoNewline
    }
    
    12 {
      mkdir $env:ProgramData\$QBPATH12 >$null 2>&1
      Out-File -FilePath $env:ProgramData\$QBPATH12\qbregistration.dat `
               -InputObject $License `
               -Encoding UTF8 `
               -NoNewline
    }

    11 {
      mkdir $env:ProgramData\$QBPATH11 >$null 2>&1
      Out-File -FilePath $env:ProgramData\$QBPATH11\qbregistration.dat `
               -InputObject $License `
               -Encoding UTF8 `
               -NoNewline
    }
  }

  Write-Host "Done"
}

function Get-IntuitLicense {
  param ($Hash, $Version)

  Clear-IntuitData
  
  switch ($Hash) {
    $QBHASH19 { 
      $Version = 19
      if ($script:SECOND_STORE) { $License = $QBREGV19_STORE_2 }
      else { $License = $QBREGV19_STORE_1 }
    }

    $QBHASH18 { 
      $Version = 18
      if ($script:SECOND_STORE) { $License = $QBREGV18_STORE_2 }
      else { $License = $QBREGV18_STORE_1 }
    }

    $QBHASH12 { 
      $Version = 12
      if ($script:SECOND_STORE) { $License = $QBREGV12_STORE_2 }
      else { $License = $QBREGV12_STORE_1 }
    }
    
    $QBHASH11 { 
      $Version = 11
      if ($script:SECOND_STORE) { $License = $QBREGV11_STORE_2 }
      else { $License = $QBREGV11_STORE_1 }
    }
  }

  Install-IntuitLicense $Version $License
}
