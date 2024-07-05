function Clear-Terminal { Clear-Host; Write-Host }
function Set-Version {
  param([Parameter(Mandatory = "true", ValueFromPipeline = "true")]$v)
  $Script:QB_VERSION = $v
}
function Get-Version { return $Script:QB_VERSION }
function Set-License { 
  param([Parameter(Mandatory = "true", ValueFromPipeline = "true")]$l)
  $Script:LICENSE_KEY = $l
}
function Get-License { return $Script:LICENSE_KEY }
