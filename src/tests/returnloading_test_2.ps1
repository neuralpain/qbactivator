function Add-FillerPercentage($start, $stop) {
  for ($a=$start; $a -le $stop; $a++) {
    Write-Host -NoNewLine "`r$a% complete"
    Start-Sleep -Milliseconds 10
  }
}

$BYTE_TO_MEGABYTE = 1048576

function Get-TimeNow {
  return Get-Date -UFormat "%I%M%S"
}

Write-Host

# $download_size = 1017415680 / $BYTE_TO_MEGABYTE
$download_size = 1017415680 * 0.125
# $bandwidth =   10298640
$bandwidth =     542062


[int]$estimated_download_duration = [math]::Round($download_size / $bandwidth)

Write-Host download size ...................... $download_size
Write-Host bandwidth .......................... $bandwidth
Write-Host estimated_download_duration ........ $estimated_download_duration

Write-Host

for ($i = 0; $i -le $estimated_download_duration; $i++) {
  $x = [math]::Round(($i / $estimated_download_duration) * 100, 2)
  Write-Host -NoNewLine "`r[$x% complete]"
  Start-Sleep -Seconds 1
}

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