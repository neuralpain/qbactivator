$ReleaseYear = 2013
$Version = 11

$URL = "https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/${ReleaseYear}/Latest/QuickBooksPOSV${Version}.exe"

Write-Host ((Invoke-WebRequest $URL -UseBasicParsing -Method Head).Headers.'Content-Length')