$global:ProgressPreference = "SilentlyContinue"

$Version = 19
$ReleaseYear = 2019
$qbdownloadurl = "https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/${ReleaseYear}/Latest/QuickBooksPOSV${Version}.exe"

Start-Job -ScriptBlock { Start-BitsTransfer $qbdownloadurl "$pwd\QuickBooksPOSV${Version}.exe" }
