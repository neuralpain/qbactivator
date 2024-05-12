function Get-BandwidthTestResults {
  $Script:BANDWIDTH_BITS = (Measure-UserBandwidth -Type Download -Unit Bits)
  # $Script:BANDWIDTH_BITS = 0                        # Debug
  if ($Script:BANDWIDTH_BITS -eq 0) {
    Write-Host "Proceeding without an estimated time..."
    # Write-Host "[DEBUG] Proceeding without an estimated time..." # Debug
    $Script:BANDWIDTH_UNKNOWN = $true
    return
  }
  else {
    if ($Script:BANDWIDTH -lt 80000) {
      # 0.01 MB
      $Script:BANDWIDTH_UNKNOWN = $true
    }
    else {
      $Script:BANDWIDTH = (Convert-UserBandwidth -InputUnit Bits -Value $Script:BANDWIDTH_BITS -OutputUnit Megabytes)
    }
    Write-Host " Done."
  }
}
