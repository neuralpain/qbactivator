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
$download_size = 164665944
# $bandwidth =   10298640
$bandwidth =     936091

Write-Host download size ...................... $download_size
Write-Host bandwidth .......................... $bandwidth

# download size / bandwidth
[int]$download_start_time = (Get-TimeNow)
[int]$estimated_download_duration = [math]::Round($download_size / $bandwidth)
[int]$download_estimated_complete_time = (Get-TimeNow) + $estimated_download_duration




# if ($estimated_download_duration -gt 59) {
#   [int]$sixties = [math]::Round($estimated_download_duration / 60)
#   [int]$remainder = $estimated_download_duration % 60
#   [Int64]$download_estimated_complete_time = (Get-TimeNow) + (100 * $sixties) + $remainder
# } else {
#   [int]$download_estimated_complete_time = (Get-TimeNow) + $estimated_download_duration
# }


Write-Host download_start_time ................ $download_start_time
Write-Host estimated_download_duration ........ $estimated_download_duration
Write-Host download_estimated_complete_time ... $download_estimated_complete_time

for ($current_time = $download_start_time; $current_time -le $download_estimated_complete_time; $current_time = Get-TimeNow) {
  
  # (120 - ( 012705 - 012701 )) / 120

  [double]$x = [math]::Round((($estimated_download_duration - ($download_estimated_complete_time - $current_time)) / $estimated_download_duration), 2)
  # $x1 = [math]::Round((($ETC - (($download_estimated_complete_time + 1) - $current_time)) / $ETC) * 100)
  # Add-FillerPercentage $x $x1
  Write-Host -NoNewLine "`r$x% complete ($current_time)"
  
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