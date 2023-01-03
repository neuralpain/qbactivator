$EXE_QBPOSV11 = "QuickBooksPOSV11.exe"
$EXE_QBPOSV12 = "QuickBooksPOSV12.exe"
$EXE_QBPOSV18 = "QuickBooksPOSV18.exe"
$EXE_QBPOSV19 = "QuickBooksPOSV19.exe"

$QBDATA11 = "C:\ProgramData\Intuit\QuickBooks Point of Sale 11.0"
$QBDATA12 = "C:\ProgramData\Intuit\QuickBooks Point of Sale 12.0"
$QBDATA18 = "C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 18.0"
$QBDATA19 = "C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 19.0"

$QBPOSV11 = '<Registration InstallDate="2023-01-01" LicenseNumber="1063-0575-1585-222" ProductNumber="810-968"/>'
$QBPOSV12 = '<Registration InstallDate="2023-01-01" LicenseNumber="6740-7656-8840-594" ProductNumber="448-229"/>'
$QBPOSV18 = '<Registration InstallDate="2023-01-01" LicenseNumber="2421-4122-2213-596" ProductNumber="818-769"/>'
$QBPOSV19 = '<Registration InstallDate="2023-01-01" LicenseNumber="0106-3903-4389-908" ProductNumber="595-828"/>'

$HASH_QBPOSV11 = "bd825846d2b9d2f80ee9cf65765ec14655878876"
$HASH_QBPOSV12 = "80a48ce36ccb7dc89169cffdd99bb87c3373c785"
$HASH_QBPOSV18 = "91b606c6dfd803ddc5a2bda971006fd6ed966fcf"
$HASH_QBPOSV19 = "1fc5e318d8617bd03c7d92a9ad558c477f080578"

# if (Test-Path -Path C:\ProgramData\Intuit -PathType Leaf) { Remove-Item -Path C:\ProgramData\Intuit\* }

if (Test-Path -Path .\$EXE_QBPOSV19 -PathType Leaf) {
  Compare-Hash -Hash $HASH_QBPOSV19 -File .\$EXE_QBPOSV19 -FileType "Installer"
  if (-not(Test-Path -Path $QBDATA19 -PathType Leaf)) { New-Item -Path $QBDATA19 >$null 2>&1 }
  Out-File -FilePath $QBDATA19\qbregistration.dat -InputObject $QBPOSV19 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV19
} elseif (Test-Path -Path .\$EXE_QBPOSV18 -PathType Leaf) {
  Compare-Hash -Hash $HASH_QBPOSV18 -File .\$EXE_QBPOSV18 -FileType "Installer"
  if (-not(Test-Path -Path $QBDATA18 -PathType Leaf)) { New-Item -Path $QBDATA18 >$null 2>&1 }
  Out-File -FilePath $QBDATA18\qbregistration.dat -InputObject $QBPOSV18 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV18
} elseif (Test-Path -Path .\$EXE_QBPOSV12 -PathType Leaf) {
  Compare-Hash -Hash $HASH_QBPOSV12 -File .\$EXE_QBPOSV12 -FileType "Installer"
  if (-not(Test-Path -Path $QBDATA12 -PathType Leaf)) { New-Item -Path $QBDATA12 >$null 2>&1 }
  Out-File -FilePath $QBDATA12\qbregistration.dat -InputObject $QBPOSV12 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV12
} elseif (Test-Path -Path .\$EXE_QBPOSV11 -PathType Leaf) {
  Compare-Hash -Hash $HASH_QBPOSV11 -File .\$EXE_QBPOSV11 -FileType "Installer"
  if (-not(Test-Path -Path $QBDATA11 -PathType Leaf)) { New-Item -Path $QBDATA11 >$null 2>&1 }
  Out-File -FilePath $QBDATA11\qbregistration.dat -InputObject $QBPOSV11 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV11
} else {
  Write-Host "QuickBooks installer was not found. Assuming activation-only request."
  Start-Sleep -Seconds 5; exit 0
}



# Remove-Item -Path C:\ProgramData\Intuit\* -Recurse -Force
