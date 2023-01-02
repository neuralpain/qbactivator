$qbhash = "1682036591228F5AAB241D17AC8727AEA122D74F"
if (-not(Test-Path -Path .\qbpatch.dat -PathType Leaf)) {
  Write-Host "Patch file not found. Patcher will now close."
  Start-Sleep -Seconds 2; exit 1
} else {
  $_hash = Get-FileHash qbpatch.dat -Algorithm SHA1 | Select-Object Hash
  $_hash = $_hash -split " "
  $_hash = $_hash.Trim("@{Hash=}")
  if ($_hash -ne $qbhash) {
    Write-Host "Patch file is corrupted. Patcher will now close."
    Start-Sleep -Seconds 2; exit 1
  }
}