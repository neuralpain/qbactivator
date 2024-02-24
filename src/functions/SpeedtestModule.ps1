# add speedtest cli license
$speedtest_folder = "$env:APPDATA\Ookla\Speedtest CLI"
$speedtest_license_file = "$env:APPDATA\Ookla\Speedtest CLI\speedtest-cli.ini"
$speedtest_license_text = "[Settings]`r`nLicenseAccepted=604ec27f828456331ebf441826292c49276bd3c1bee1a2f65a6452f505c4061c`r`nGDPRTimeStamp=1704516852" # utf8, noBOM

if (-not(Test-Path "$speedtest_license_file" -PathType Leaf)) {
  mkdir $speedtest_folder >$null 2>&1
  [IO.File]::WriteAllLines($speedtest_license_file, $speedtest_license_text)
}

function Get-SpeedTestResults {
  $speedtest_archive = "https://github.com/neuralpain/qbactivator/files/11450516/speedtest.zip"

  if (-not(Test-Path "$qbactivator_temp\speedtest.exe")) {
    if (-not(Test-Path "$qbactivator_temp\speedtest.zip")) {
      Start-BitsTransfer $speedtest_archive "$qbactivator_temp\speedtest.zip"
    }
    Add-Type -Assembly System.IO.Compression.FileSystem
    $_zip = [IO.Compression.ZipFile]::OpenRead("$qbactivator_temp\speedtest.zip")
    [System.IO.Compression.ZipFileExtensions]::ExtractToFile((
        $_zip.Entries | Where-Object { $_.Name -eq "speedtest.exe" }
      ), "$qbactivator_temp\speedtest.exe", $true)
    $_zip.Dispose()
  }

  # accept CLI usage license and General Data Protection Regulation (EU) before use
  # Invoke-Expression "$qbactivator_temp\speedtest.exe --accept-gdpr --accept-license" >$null 2>&1
  
  Write-Host "Testing internet speed..." -NoNewline
  
  try {
    $Script:BANDWIDTH_BITS = ((Invoke-Expression "$qbactivator_temp\speedtest.exe --format json") -replace '.*"bandwidth":(\d+).*', '$1')
    # $Script:BANDWIDTH_BITS = ((Invoke-Expression "$qbactivator_temp\speedtest.exe --format json") -replace '.*"bytes":(\d+).*', '$1')
  }
  catch {
    Write-Host "`nSpeed test failed."
    Write-Host "Proceeding without an estimated time..."
    $Script:BANDWIDTH_UNKNOWN = $true
    return
  }
  
  # $Script:BANDWIDTH = [math]::Round($speedtestresult / $BYTE_TO_MEGABYTE, 2)
  # $Script:BANDWIDTH = [math]::Round($speedtestresult / 0.125 / $BYTE_TO_MEGABYTE / 8, 2)
  # $Script:BANDWIDTH = [math]::Round(($speedtestresult * 8) / $BYTE_TO_MEGABYTE, 2)
  $Script:BANDWIDTH = [math]::Round($Script:BANDWIDTH_BITS * 0.000001, 2)
  Write-Host " Done."
}

function Get-TimeToComplete {
  param ([int]$DownloadSize, [int]$Bandwidth)
  
  [double]$time = ($DownloadSize / $Bandwidth)
  [int]$time = [math]::Round($time)

  $Script:RAW_DOWNLOAD_TIME = $time

  if ($time -gt 60) {
    [int]$time_m = $time / 60
    [int]$time_s = $time % 60
    return "${time_m}m${time_s}s"
  }

  return "$time seconds"
}
