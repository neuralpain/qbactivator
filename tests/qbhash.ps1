$qbhash = "1682036591228F5AAB241D17AC8727AEA122D74F"
if (-not(Test-Path -Path .\qbpatch.dat -PathType Leaf)) {
  Write-Host "Patch file not found. Activator will now close."
  Start-Sleep -Seconds 2; exit 1
} else {
  $_hash = Get-FileHash qbpatch.dat -Algorithm SHA1 | Select-Object Hash
  $_hash = $_hash -split " "
  $_hash = $_hash.Trim("@{Hash=}")
  if ($_hash -ne $qbhash) {
    Write-Host "Patch file is corrupted. Activator will now close."
    Start-Sleep -Seconds 2; exit 1
  }
}


function Compare-Hash {
  param ( $Hash, $File, [string]$FileType )
  
  $_hash = Get-FileHash $File -Algorithm SHA1 | Select-Object Hash
  $_hash = $_hash -split " "
  $_hash = $_hash.Trim("@{Hash=}")
  if ($_hash -ne $Hash) {
    Write-Host "$FileType is corrupted. Patcher will now close."
    Start-Sleep -Seconds 2; exit 1
  }
}

Compare-Hash -Hash $qbhash -File .\qbpatch.dat -FileType "Patch file"
