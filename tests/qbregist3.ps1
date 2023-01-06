$QBPOSV11 = "QuickBooksPOSV11.exe"
$QBPOSV12 = "QuickBooksPOSV12.exe"
$QBPOSV18 = "QuickBooksPOSV18.exe"
$QBPOSV19 = "QuickBooksPOSV19.exe"

$QBHASH11 = "a1af552a49adff40e6462a968dd552a4"
$QBHASH12 = "30fb99c5e98df6874d438c478314ef9d"
$QBHASH18 = "dd45aa4ec0df431243c9836816e2305a"
$QBHASH19 = "bd83235f86d879d2d67d05b978a6a316"

$QBPATH11 = "Intuit\QuickBooks Point of Sale 11.0"
$QBPATH12 = "Intuit\QuickBooks Point of Sale 12.0"
$QBPATH18 = "Intuit\QuickBooks Desktop Point of Sale 18.0"
$QBPATH19 = "Intuit\QuickBooks Desktop Point of Sale 19.0"

$QBREGV11 = '<Registration InstallDate="" LicenseNumber="1063-0575-1585-222" ProductNumber="023-147"/>'
$QBREGV12 = '<Registration InstallDate="" LicenseNumber="6740-7656-8840-594" ProductNumber="448-229"/>'
$QBREGV18 = '<Registration InstallDate="" LicenseNumber="2421-4122-2213-596" ProductNumber="818-769"/>'
$QBREGV19 = '<Registration InstallDate="" LicenseNumber="0106-3903-4389-908" ProductNumber="595-828"/>'

$qbExeCheck = @( $QBPOSV11,$QBPOSV12,$QBPOSV18,$QBPOSV19 )
$qbHashCheck = @( $QBHASH11,$QBHASH12,$QBHASH18,$QBHASH19 )
$qbPathList = @( $QBPATH11,$QBPATH12,$QBPATH18,$QBPATH19 )

function Compare-Hash {
  param ( $Hash, $File, [string]$FileType )
  $_hash = Get-FileHash $File -Algorithm MD5 | Select-Object Hash
  $_hash = $_hash -split " "
  $_hash = $_hash.Trim("@{Hash=}")
  if ($_hash -ne $Hash) {
    Write-Host "$FileType is corrupted." -ForegroundColor Red
    Start-Sleep -Seconds 2; exit 1
  }
}

function Remove-IntuitData {
  Remove-Item -Path $env:ProgramData\Intuit\* -Recurse -Force >$null 2>&1
}

function Add-IntuitLicense {
  param( $Hash )

  # -----------

  Write-Host "Adding WITH license"
  Start-Sleep -Seconds 1

  # -----------

  switch ($Hash) {
    $QBHASH11 {
      if (-not(Test-Path -Path $env:ProgramData\$QBPATH11 -PathType Leaf)) { 
        mkdir $env:ProgramData\$QBPATH11 >$null 2>&1 }
      Out-File -FilePath $env:ProgramData\$QBPATH11\qbregistration.dat -InputObject $QBREGV11 -Encoding UTF8 -NoNewline
      return
    }

    $QBHASH12 {
      if (-not(Test-Path -Path $env:ProgramData\$QBPATH12 -PathType Leaf)) { 
        mkdir $env:ProgramData\$QBPATH12 >$null 2>&1 }
      Out-File -FilePath $env:ProgramData\$QBPATH12\qbregistration.dat -InputObject $QBREGV12 -Encoding UTF8 -NoNewline
      return
    }

    $QBHASH18 {
      if (-not(Test-Path -Path $env:ProgramData\$QBPATH18 -PathType Leaf)) { 
        mkdir $env:ProgramData\$QBPATH18 >$null 2>&1 }
      Out-File -FilePath $env:ProgramData\$QBPATH18\qbregistration.dat -InputObject $QBREGV18 -Encoding UTF8 -NoNewline
      return
    }

    $QBHASH19 {
      if (-not(Test-Path -Path $env:ProgramData\$QBPATH19 -PathType Leaf)) { 
        mkdir $env:ProgramData\$QBPATH19 >$null 2>&1 }
      Out-File -FilePath $env:ProgramData\$QBPATH19\qbregistration.dat -InputObject $QBREGV19 -Encoding UTF8 -NoNewline
      return
    }
  }

  # -----------

  Write-Host "checking paths for quickbooks install"
  Start-Sleep -Seconds 1

  # -----------

  foreach ($path in $qbPathList) {
    if (Test-Path -Path ${env:ProgramFiles(x86)}\$path\QBPOSShell.exe -PathType Leaf) { 
      Write-Host "Found $path"
      Start-Sleep -Seconds 2
      return 
    }
  }
  
  Write-Host "There is no QuickBooks software installed." -ForegroundColor Red
  Start-Sleep -Seconds 5; exit 1
}


# verify patch file
$PatchHash = "1a1816c78925e734fca16974bdbaa4aa"
if (-not(Test-Path -Path .\qbpatch.dat -PathType Leaf)) {
  Write-Host "Patch file not found." -ForegroundColor Red
  Start-Sleep -Seconds 2; exit 1
} else {
  Compare-Hash -Hash $PatchHash -File .\qbpatch.dat -FileType "Patch file"
}

# clear old install data
Remove-IntuitData

# check if POS installer is available
foreach ($exe in $qbExeCheck) {
  if (Test-Path -Path .\$exe -PathType Leaf) {
    foreach ($hash in $qbHashCheck) {
      Compare-Hash -Hash $hash -File .\$exe -FileType "Installer"
      Add-IntuitLicense -Hash $hash
      Start-Process -FilePath .\$exe
      Start-Sleep -Seconds 5; exit 0
    }
  }
}

# default result
Write-Host "QuickBooks installer was not found." -ForegroundColor Yellow
Write-Host "Assuming activation-only request."; Write-Host
Start-Sleep -Seconds 2; exit 0
Add-IntuitLicense
Start-Sleep -Seconds 5; exit 0
