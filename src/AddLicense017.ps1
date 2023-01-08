$EXE_QBPOSV11 = "QuickBooksPOSV11.exe"
$EXE_QBPOSV12 = "QuickBooksPOSV12.exe"
$EXE_QBPOSV18 = "QuickBooksPOSV18.exe"
$EXE_QBPOSV19 = "QuickBooksPOSV19.exe"

$HASH_QBPOSV11 = "BD825846D2B9D2F80EE9CF65765EC14655878876"
$HASH_QBPOSV12 = "80A48CE36CCB7DC89169CFFDD99BB87C3373C785"
$HASH_QBPOSV18 = "91B606C6DFD803DDC5A2BDA971006FD6ED966FCF"
$HASH_QBPOSV19 = "1FC5E318D8617BD03C7D92A9AD558C477F080578"

$QBDATA11 = "C:\ProgramData\Intuit\QuickBooks Point of Sale 11.0"
$QBDATA12 = "C:\ProgramData\Intuit\QuickBooks Point of Sale 12.0"
$QBDATA18 = "C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 18.0"
$QBDATA19 = "C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 19.0"

$QBPOSV11 = '<Registration InstallDate="" LicenseNumber="1063-0575-1585-222" ProductNumber="023-147"/>'
$QBPOSV12 = '<Registration InstallDate="" LicenseNumber="6740-7656-8840-594" ProductNumber="448-229"/>'
$QBPOSV18 = '<Registration InstallDate="" LicenseNumber="2421-4122-2213-596" ProductNumber="818-769"/>'
$QBPOSV19 = '<Registration InstallDate="" LicenseNumber="0106-3903-4389-908" ProductNumber="595-828"/>'

function Compare-Hash {
  param ( $Hash, $File, [string]$FileType )
  $_hash = Get-FileHash $File -Algorithm SHA1 | Select-Object Hash
  $_hash = $_hash -split " "
  $_hash = $_hash.Trim("@{Hash=}")
  if ($_hash -ne $Hash) {
    Write-Host "$FileType is corrupted." -ForegroundColor Red
    Write-Host "Activator will now terminate."
    Start-Sleep -Seconds 2; exit 1
  }
}

$PatchHash = "1682036591228F5AAB241D17AC8727AEA122D74F"
if (-not(Test-Path -Path .\qbpatch.dat -PathType Leaf)) {
  Write-Host "Patch file not found." -ForegroundColor Red
  Write-Host "Activator will now terminate."
  Start-Sleep -Seconds 2; exit 1
} else { Compare-Hash -Hash $PatchHash -File .\qbpatch.dat -FileType "Patch file" }

Remove-Item -Path C:\ProgramData\Intuit\* -Recurse -Force >$null 2>&1

if (Test-Path -Path .\$EXE_QBPOSV19 -PathType Leaf) {
  Compare-Hash -Hash $HASH_QBPOSV19 -File .\$EXE_QBPOSV19 -FileType "Installer"
  if (-not(Test-Path -Path $QBDATA19 -PathType Leaf)) { mkdir $QBDATA19 >$null 2>&1 }
  Out-File -FilePath $QBDATA19\qbregistration.dat -InputObject $QBPOSV19 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV19
} elseif (Test-Path -Path .\$EXE_QBPOSV18 -PathType Leaf) {
  Compare-Hash -Hash $HASH_QBPOSV18 -File .\$EXE_QBPOSV18 -FileType "Installer"
  if (-not(Test-Path -Path $QBDATA18 -PathType Leaf)) { mkdir $QBDATA18 >$null 2>&1 }
  Out-File -FilePath $QBDATA18\qbregistration.dat -InputObject $QBPOSV18 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV18
} elseif (Test-Path -Path .\$EXE_QBPOSV12 -PathType Leaf) {
  Compare-Hash -Hash $HASH_QBPOSV12 -File .\$EXE_QBPOSV12 -FileType "Installer"
  if (-not(Test-Path -Path $QBDATA12 -PathType Leaf)) { mkdir $QBDATA12 >$null 2>&1 }
  Out-File -FilePath $QBDATA12\qbregistration.dat -InputObject $QBPOSV12 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV12
} elseif (Test-Path -Path .\$EXE_QBPOSV11 -PathType Leaf) {
  Compare-Hash -Hash $HASH_QBPOSV11 -File .\$EXE_QBPOSV11 -FileType "Installer"
  if (-not(Test-Path -Path $QBDATA11 -PathType Leaf)) { mkdir $QBDATA11 >$null 2>&1 }
  Out-File -FilePath $QBDATA11\qbregistration.dat -InputObject $QBPOSV11 -Encoding UTF8 -NoNewline
  Start-Process -FilePath .\$EXE_QBPOSV11
} else {
  Write-Host "QuickBooks installer was not found." -ForegroundColor Yellow
  Write-Host "Assuming activation-only request."
  Start-Sleep -Seconds 5; exit 0
}
