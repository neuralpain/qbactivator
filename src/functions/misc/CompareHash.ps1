function Compare-IsValidHash {
  param ($Hash, $File)
  $_hash = ((Get-FileHash $File -Algorithm MD5 | 
      Select-Object Hash) -split " ").Trim("@{Hash=}")
  if ($_hash -ne $Hash) { return $false }
  else { return $true }
}
