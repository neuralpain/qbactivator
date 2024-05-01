function Compare-IsValidHash {
  <#
  .SYNOPSIS
    Compares the file hash (MD5) of the specified file against the provided hash.

  .DESCRIPTION
    This function uses PowerShell's Get-FileHash cmdlet to retrieve the hash of the specified file.
    It then compares the retrieved hash against the provided hash. If the two hashes match, the function returns $true,
    otherwise it returns $false.

  .PARAMETER Hash
    A string containing the expected MD5 hash value

  .PARAMETER File
    A string containing the path to the file to be compared

  .EXAMPLE
    Compare-IsValidHash -Hash "1234567890ABCDEF" -File "C:\path\to\file.txt"

    If the MD5 hash of "C:\path\to\file.txt" is "1234567890ABCDEF", this function will return $true. Otherwise it will return $false.

  .OUTPUTS
    Boolean
  #>
  [CmdletBinding()]
  param ($Hash, $File)
  
  # retrieve the hash of the specified file
  $_hash = ((Get-FileHash $File -Algorithm MD5 | 
      Select-Object Hash) -split " ").Trim("@{Hash=}")
      
  # compare the retrieved hash against the provided hash
  if ($_hash -ne $Hash) { return $false }
  else { return $true }
}
