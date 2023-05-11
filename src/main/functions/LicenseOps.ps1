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
  param ($Version)
  
  Write-Host -NoNewLine "Installing registration keys... "
  
  switch ($Version) {
    19 {
      mkdir $env:ProgramData\$QBPATH19 >$null 2>&1
      Out-File -FilePath $env:ProgramData\$QBPATH19\qbregistration.dat `
               -InputObject $QBREGV19 `
               -Encoding UTF8 `
               -NoNewline
    }
    
    18 {
      mkdir $env:ProgramData\$QBPATH18 >$null 2>&1
      Out-File -FilePath $env:ProgramData\$QBPATH18\qbregistration.dat `
               -InputObject $QBREGV18 `
               -Encoding UTF8 `
               -NoNewline
    }
    
    12 {
      mkdir $env:ProgramData\$QBPATH12 >$null 2>&1
      Out-File -FilePath $env:ProgramData\$QBPATH12\qbregistration.dat `
               -InputObject $QBREGV12 `
               -Encoding UTF8 `
               -NoNewline
    }

    11 {
      mkdir $env:ProgramData\$QBPATH11 >$null 2>&1
      Out-File -FilePath $env:ProgramData\$QBPATH11\qbregistration.dat `
               -InputObject $QBREGV11 `
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
    $QBHASH19 { $Version = 19 }
    $QBHASH18 { $Version = 18 }
    $QBHASH12 { $Version = 12 }
    $QBHASH11 { $Version = 11 }
  }

  Install-IntuitLicense -Version $Version
  return
}
