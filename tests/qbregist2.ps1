$EXE_QBPOSV11 = "QuickBooksPOSV11.exe"
$EXE_QBPOSV12 = "QuickBooksPOSV12.exe"
$EXE_QBPOSV18 = "QuickBooksPOSV18.exe"
$EXE_QBPOSV19 = "QuickBooksPOSV19.exe"

$QBDATA11 = "C:\ProgramData\Intuit\QuickBooks Point of Sale 11.0"
$QBDATA12 = "C:\ProgramData\Intuit\QuickBooks Point of Sale 12.0"
$QBDATA18 = "C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 18.0"
$QBDATA19 = "C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 19.0"

$QBPOSV11 = '<Registration InstallDate="" LicenseNumber="1063-0575-1585-222" ProductNumber="810-968"/>'
$QBPOSV12 = '<Registration InstallDate="" LicenseNumber="6740-7656-8840-594" ProductNumber="448-229"/>'
$QBPOSV18 = '<Registration InstallDate="" LicenseNumber="2421-4122-2213-596" ProductNumber="818-769"/>'
$QBPOSV19 = '<Registration InstallDate="" LicenseNumber="0106-3903-4389-908" ProductNumber="595-828"/>'

$hashCheck = @( 
  "BD825846D2B9D2F80EE9CF65765EC14655878876", # QBPOSV11
  "80A48CE36CCB7DC89169CFFDD99BB87C3373C785", # QBPOSV12
  "91B606C6DFD803DDC5A2BDA971006FD6ED966FCF", # QBPOSV18
  "1FC5E318D8617BD03C7D92A9AD558C477F080578"  # QBPOSV19
)

$exeCheck = @( 
  "$EXE_QBPOSV11","$EXE_QBPOSV12",
  "$EXE_QBPOSV18","$EXE_QBPOSV19" 
)

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

function Compare-HashOnly {
  param ( $Hash, $File)
  $_hash = Get-FileHash $File -Algorithm SHA1 | Select-Object Hash
  $_hash = $_hash -split " "
  $_hash = $_hash.Trim("@{Hash=}")
  if ($_hash -ne $Hash) { return $true } 
  else { return $false }
}

function Invoke-QBInstaller {
  param( 
    $Item, 
    [bool]$isMatch 
  )
    
  if ($isMatch -eq $true) { 
    switch ($Item) {
      $EXE_QBPOSV11 {
        New-Item -Path $QBDATA11 -ItemType Directory >$null 2>&1
        Out-File -FilePath $QBDATA11\qbregistration.dat -InputObject $QBPOSV11 -Encoding UTF8 -NoNewline
        Start-Process -FilePath .\$EXE_QBPOSV11; exit 0
      }
      
      $EXE_QBPOSV12 {
        New-Item -Path $QBDATA12 -ItemType Directory >$null 2>&1
        Out-File -FilePath $QBDATA12\qbregistration.dat -InputObject $QBPOSV12 -Encoding UTF8 -NoNewline
        Start-Process -FilePath .\$EXE_QBPOSV12; exit 0
      }
      
      $EXE_QBPOSV18 {
        New-Item -Path $QBDATA18 -ItemType Directory >$null 2>&1
        Out-File -FilePath $QBDATA18\qbregistration.dat -InputObject $QBPOSV18 -Encoding UTF8 -NoNewline
        Start-Process -FilePath .\$EXE_QBPOSV18; exit 0
      }
      
      $EXE_QBPOSV19 {
        New-Item -Path $QBDATA19 -ItemType Directory >$null 2>&1
        Out-File -FilePath $QBDATA19\qbregistration.dat -InputObject $QBPOSV19 -Encoding UTF8 -NoNewline
        Start-Process -FilePath .\$EXE_QBPOSV19; exit 0
      }
    }
  }
}

$PatchHash = "1682036591228F5AAB241D17AC8727AEA122D74F"
if (-not(Test-Path -Path .\qbpatch.dat -PathType Leaf)) {
  Write-Host "Patch file not found." -ForegroundColor Red
  Write-Host "Activator will now terminate."
  Start-Sleep -Seconds 2; exit 1
} else { Compare-Hash -Hash $PatchHash -File .\qbpatch.dat -FileType "Patch file" }

Remove-Item -Path C:\ProgramData\Intuit\* -Recurse -Force >$null 2>&1

foreach ($exe in $exeCheck) {
  foreach ($hash in $hashCheck) {
    if (Test-Path -Path $exe -PathType Leaf) {
      Invoke-QBInstaller -Item $exe -isMatch (Compare-HashOnly -Hash $hash -File .\$exe)
    }
  }
}

Write-Host "QuickBooks installer was not found." -ForegroundColor Yellow
Write-Host "Assuming activation-only request."
Start-Sleep -Seconds 5; exit 0