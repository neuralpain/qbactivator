# add speedtest cli license
$speedtest_folder = "$env:APPDATA\Ookla\Speedtest CLI"
$speedtest_license_file = "$env:APPDATA\Ookla\Speedtest CLI\speedtest-cli.ini"
$speedtest_license_text = "[Settings]`r`nLicenseAccepted=604ec27f828456331ebf441826292c49276bd3c1bee1a2f65a6452f505c4061c" # utf8, noBOM

if (-not(Test-Path "$speedtest_license_file" -PathType Leaf)) {
  mkdir $speedtest_folder >$null 2>&1 
  [IO.File]::WriteAllLines($speedtest_license_file, $speedtest_license_text)
}

function Get-SpeedTestResults {
  $speedtest_archive = "https://github.com/neuralpain/qbactivator/files/11450516/speedtest.zip"
  
  # don't waste time downloading the cli again if it's available
  if (-not(Test-Path "$qbactivator_temp\speedtest.exe")) {
    Start-BitsTransfer $speedtest_archive "$qbactivator_temp\speedtest.zip"
    Add-Type -Assembly System.IO.Compression.FileSystem
    $_zip = [IO.Compression.ZipFile]::OpenRead("$qbactivator_temp\speedtest.zip")
    [System.IO.Compression.ZipFileExtensions]::ExtractToFile((
        $_zip.Entries | Where-Object { $_.Name -eq "speedtest.exe" }
      ), "$qbactivator_temp\speedtest.exe", $true)
    $_zip.Dispose()
  }

  [int]$speedtestresult = [math]::Round((((Invoke-Expression "$qbactivator_temp\speedtest.exe --accept-gdpr --format json --progress no"
        ) -replace ".*download").Trim(':{"bandwidth":') -replace ",.*") / $BYTE_TO_MEGABYTE, 2)

  return [int]$speedtestresult
}

function Get-TimeToComplete {
  param ([int]$DownloadSize, [int]$DownloadSpeed)

  [int]$Time = [math]::Round($DownloadSize / $DownloadSpeed)

  if ($Time -gt 60) {
    $Time = [math]::Round($Time / 60)
    return "$Time minutes"
  }

  return "$Time seconds"
}