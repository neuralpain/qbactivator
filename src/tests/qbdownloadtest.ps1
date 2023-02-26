function Get-TimeToComplete {
  param ($Time)

  if ($Time -gt 60) {
    $Time = $Time/60
    $Time = [math]::round($Time,2)
    return "$Time minutes"
  }
  
  [int]$Time = $Time
  return "$Time seconds"
}

function Get-QuickBooksInstaller {
  param ( $Target = $pwd, $Version )

  $BYTE_CONVERT = 1048576
  $ProgressPreference = "SilentlyContinue"

  Clear-Host
  Write-Host; Write-Host "Preparing to download..."
  $speedtestarchive = "https://github.com/neuralpain/qbactivator/files/10474537/ookla-speedtest-1.2.0-win64.zip"
  Start-BitsTransfer $speedtestarchive "${Target}\speedtest.zip"
  Expand-Archive .\speedtest.zip $Target\speedtest -Force

  Write-Host; Write-Host "Checking your internet connection..."
  Write-Host "This may take up to a minute depending on your system." -ForegroundColor Yellow
  $netspeed = .\speedtest\speedtest.exe --format json --progress no
  $netspeed = $netspeed -replace ".*download"
  $netspeed = $netspeed.Trim(':{"bandwidth":') -replace ",.*"
  [double]$netspeed = [math]::round($netspeed/$BYTE_CONVERT,2)
  Remove-Item .\speedtest -Recurse
  Remove-Item .\speedtest.zip

  switch ($Version) {
    18 { $ReleaseYear = 2018 }
    12 { $ReleaseYear = 2015 }
    11 { $ReleaseYear = 2013 }
    Default { $ReleaseYear = 2019 }
  }

  $url = "https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/${ReleaseYear}/Latest/QuickBooksPOSV${Version}.exe"
  
  Write-Host
  [int]$downloadsize = ((Invoke-WebRequest $url -Method Head).Headers.'Content-Length')/$BYTE_CONVERT
  $query = Read-Host "Download ${downloadsize} MB? (Y/n)"
  $TimeToComplete = Get-TimeToComplete ($downloadsize/$netspeed)

  Clear-Host

  switch ($query) {
    "n" { return }
    Default {  
      Write-Host "Downloading ${downloadsize} MB to `"$Target`""
      Write-Host "Estimated $TimeToComplete to download @ $netspeed MB/s" -ForegroundColor Blue
      Write-Host; Write-Host "Please wait while the installer is being downloaded..."
      Invoke-WebRequest $url -OutFile $Target\QuickBooksPOSV${Version}.exe
      Write-Host Download complete. -ForegroundColor Green
    }
  }
}

Get-QuickBooksInstaller -Version 19
