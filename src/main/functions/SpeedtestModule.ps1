function Get-TimeToComplete {
  param ($Time)

  if ($Time -gt 60) {
    $Time = $Time / 60
    $Time = [math]::Round($Time, 2)
    return "$Time minutes"
  }
  
  [int]$Time = $Time
  return "$Time seconds"
}

function Get-SpeedTestResults {
  $speedtestinstallfolder = "$env:APPDATA\Ookla\Speedtest CLI"
  $speedtestlicensefile = "$env:APPDATA\Ookla\Speedtest CLI\speedtest-cli.ini"
  $speedtestlicensetext = "[Settings]`r`nLicenseAccepted=604ec27f828456331ebf441826292c49276bd3c1bee1a2f65a6452f505c4061c" # utf8, noBOM
  $speedtestarchive = "https://github.com/neuralpain/qbactivator/files/11450516/speedtest.zip"
  
  # add cli license text
  if (-not(Test-Path "$speedtestlicensefile" -PathType Leaf)) {
    mkdir $speedtestinstallfolder
    [IO.File]::WriteAllLines($speedtestlicensefile, $speedtestlicensetext)
  }
  
  # don't waste time downloading the cli again if it's available
  if (-not(Test-Path "$qbactivator_temp\speedtest.exe")) {
    Start-BitsTransfer $speedtestarchive "$qbactivator_temp\speedtest.zip"
    Add-Type -Assembly System.IO.Compression.FileSystem
    $_zip = [IO.Compression.ZipFile]::OpenRead("$qbactivator_temp\speedtest.zip")
    [System.IO.Compression.ZipFileExtensions]::ExtractToFile((
        $_zip.Entries | Where-Object { $_.Name -eq "speedtest.exe" }
      ), "$qbactivator_temp\speedtest.exe", $true)
    $_zip.Dispose()
  }

  Write-Host "This may take up to a minute based on your system." -ForegroundColor Yellow
  Write-Host "Querying internet speed..." -NoNewline
  
  $speedtestresult = [math]::Round((((Invoke-Expression "$qbactivator_temp\speedtest.exe --format json --progress no"
        ) -replace ".*download").Trim(':{"bandwidth":') -replace ",.*") / $BYTE_TO_MEGABYTE, 2)

  Write-Host " Done."

  return $speedtestresult
}
