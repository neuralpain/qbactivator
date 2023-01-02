$QBDATA19 = "C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 19.0"
$QBDATA18 = "C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 18.0"
$QBDATA12 = "C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 12.0"
$QBDATA11 = "C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 11.0"

$QBPOSV19 = '<Registration InstallDate="2023-01-01" LicenseNumber="0106-3903-4389-908" ProductNumber="595-828"/>'
$QBPOSV18 = '<Registration InstallDate="2023-01-01" LicenseNumber="2421-4122-2213-596" ProductNumber="818-769"/>'
$QBPOSV12 = '<Registration InstallDate="2023-01-01" LicenseNumber="6740-7656-8840-594" ProductNumber="015-985"/>'
$QBPOSV11 = '<Registration InstallDate="2023-01-01" LicenseNumber="1063-0575-1585-222" ProductNumber="810-968"/>'

if (Test-Path -Path .\QuickBooksPOSV19.exe -PathType Leaf) {
  if (-not(Test-Path -Path $QBDATA19 -PathType Leaf)) { mkdir $QBDATA19 >$null 2>&1 }
  Out-File -FilePath $QBDATA19\qbregistration.dat -InputObject $QBPOSV19 -NoNewline
} elseif (Test-Path -Path .\QuickBooksPOSV18.exe -PathType Leaf) {
  if (-not(Test-Path -Path $QBDATA18 -PathType Leaf)) { mkdir $QBDATA18 >$null 2>&1 }
  Out-File -FilePath $QBDATA18\qbregistration.dat -InputObject $QBPOSV18 -NoNewline
} elseif (Test-Path -Path .\QuickBooksPOSV12.exe -PathType Leaf) {
  if (-not(Test-Path -Path $QBDATA12 -PathType Leaf)) { mkdir $QBDATA12 >$null 2>&1 }
  Out-File -FilePath $QBDATA12\qbregistration.dat -InputObject $QBPOSV12 -NoNewline
} elseif (Test-Path -Path .\QuickBooksPOSV11.exe -PathType Leaf) {
  if (-not(Test-Path -Path $QBDATA11 -PathType Leaf)) { mkdir $QBDATA11 >$null 2>&1 }
  Out-File -FilePath $QBDATA11\qbregistration.dat -InputObject $QBPOSV11 -NoNewline
} else {
  Write-Host "QuickBooks installer was not found. Patcher will now close."
  Start-Sleep -Seconds 2; exit 1
}