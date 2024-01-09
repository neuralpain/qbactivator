
$BYTE_TO_MEGABYTE = 1048576

function Get-TimeNow { return Get-Date -UFormat "%I%M%S" }

function Start-Progress {
  param (
    $DownloadSize,
    $Bandwidth
  )
  
  $duration = [math]::Round($DownloadSize / $Bandwidth)
  
  Write-Host "download size ..... $DownloadSize"
  Write-Host "bandwidth ......... $Bandwidth"
  Write-Host "duration .......... $duration`n"
  
  for ($i = 0; $i -le $duration; $i++) {
    $x = [math]::Round(($i / $duration) * 100, 2)
    Write-Host -NoNewLine "`r[$x% complete]"
    Start-Sleep -Seconds 1
  }
}

Write-Host

# $download_size = 1017415680 / $BYTE_TO_MEGABYTE
# $download_size = 1017415680 * 0.125
$download_size = 101741568 * 0.125
# $bandwidth =   10298640
$bandwidth = 542062
# Start-Progress -DownloadSize $download_size -Bandwidth $bandwidth

$global:ProgressPreference = "SilentlyContinue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$URL = "https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2019/Latest/QuickBooksPOSV19.exe"
$size_header = ((Invoke-WebRequest $URL -UseBasicParsing -Method Head).Headers.'Content-Length') * 0.125
# $size_header.GetType().Name
# $size_header = [Convert]::ToInt32("$size_header", 10)
$speedtestresult = (((Invoke-Expression ".\speedtest --format json") -replace ".*download").Trim(':{"bandwidth":') -replace ",.*") * 1
# $speedtestresult.GetType().Name
# $speedtestresult = [Convert]::ToInt32("$speedtestresult", 10)
Start-Progress -DownloadSize $size_header -Bandwidth $speedtestresult





Write-Host

<#
for ((k = 0; k <= 10 ; k++))
do
echo -n "[ "
for ((i = 0 ; i <= k; i++)); do echo -n "###"; done
for ((j = i ; j <= 10 ; j++)); do echo -n "   "; done
v=$((k * 10))
echo -n " ] "
echo -n "$v %" $'\r'
sleep 0.05
done
echo
#>