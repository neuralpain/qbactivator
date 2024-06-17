# log file
$LOG = "C:\Windows\Logs\qbactivator\qbactivator_$(Get-Date -Format "yyyyMMdd_HHmmss").log"

# temp folder for Intuit (is this folder still being used?)
$intuit_temp = "$env:TEMP\Intuit"

function Clear-Terminal { Clear-Host; Write-Host }
function Set-Version($v) { $Script:QB_VERSION = $v }
function Get-Version { return $Script:QB_VERSION }
function Set-License($l) { $Script:LICENSE_KEY = $l }
function Get-License { return $Script:LICENSE_KEY }
