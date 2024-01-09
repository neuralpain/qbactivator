<# legacy code
  # add speedtest cli license
  $speedtest_folder = "$env:APPDATA\Ookla\Speedtest CLI"
  $speedtest_license_file = "$env:APPDATA\Ookla\Speedtest CLI\speedtest-cli.ini"
  $speedtest_license_text = "[Settings]`r`nLicenseAccepted=604ec27f828456331ebf441826292c49276bd3c1bee1a2f65a6452f505c4061c"  utf8, noBOM

  if (-not(Test-Path "$speedtest_license_file" -PathType Leaf)) {
    mkdir $speedtest_folder >$null 2>&1 
    [IO.File]::WriteAllLines($speedtest_license_file, $speedtest_license_text)
  }
#>

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
  Invoke-Expression "$qbactivator_temp\speedtest.exe --accept-gdpr --accept-license" >$null 2>&1

  [int]$speedtestresult = (((Invoke-Expression "$qbactivator_temp\speedtest.exe --accept-gdpr --accept-license --format json"
        ) -replace ".*download").Trim(':{"bandwidth":') -replace ",.*")

  return $speedtestresult
}

function Get-TimeToComplete {
  param ([int]$DownloadSize, [int]$Bandwidth)

  [double]$Time = ($DownloadSize / $Bandwidth)
  [int]$Time = [math]::Round($Time)

  $Script:RAW_DOWNLOAD_TIME = $Time

  if ($Time -gt 60) {
    $Time = [math]::Round($Time / 60)
    return "$Time minutes"
  }

  return "$Time seconds"
}
