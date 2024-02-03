function Get-QuickBooksInstaller {
  param (
    $Version, # receives version number from `Select-QuickBooksVersion`
    $Target = "$pwd"
  )

  if ($Version -eq $CANCEL) { 
    Write-MainMenu_NoInstaller 
  } else {
    switch ($Version) {
      $POS19InstObj.VerNum {
        $ReleaseYear = $POS19InstObj.Year
        $Script:INSTALLER_SIZE = $POS19InstObj.Size
        $Script:INSTALLER_BYTES = $POS19InstObj.XByte
        $Script:INSTALLER_BITS = $POS19InstObj.XBits
      }
      $POS18InstObj.VerNum {
        $ReleaseYear = $POS18InstObj.Year
        $Script:INSTALLER_SIZE = $POS18InstObj.Size
        $Script:INSTALLER_BYTES = $POS18InstObj.XByte
        $Script:INSTALLER_BITS = $POS18InstObj.XBits
      }
      $POS12InstObj.VerNum {
        $ReleaseYear = $POS12InstObj.Year
        $Script:INSTALLER_SIZE = $POS12InstObj.Size
        $Script:INSTALLER_BYTES = $POS12InstObj.XByte
        $Script:INSTALLER_BITS = $POS12InstObj.XBits
      }
      $POS11InstObj.VerNum {
        $ReleaseYear = $POS11InstObj.Year
        $Script:INSTALLER_SIZE = $POS11InstObj.Size
        $Script:INSTALLER_BYTES = $POS11InstObj.XByte
        $Script:INSTALLER_BITS = $POS11InstObj.XBits
      }
    }
  }

  Clear-Host
  Write-Host "`nPreparing to download POS v${Version}... "
  Write-Host "This may take a couple of minutes." -ForegroundColor Yellow
  Write-Host "Testing connectivity... " -NoNewLine
  
  if (-not(Test-Connection www.google.com -Quiet)) { 
    Write-Error_NoInternetConnectivity
  } else {
    Write-Host "OK"

    # Test network connection
    
    # [double]$Script:BANDWIDTH = 303298                     # Debug sample
    # Write-Host " Done. (debugging sample)"                 # Debug
    
    # 1741119    # Debug sample values, bandwidth
    # 13928952   # Debug sample values, bandwidth / 0.125
    # 1048576    # Debug sample values, $BYTE_TO_MEGABYTE
    
    # 1768071    # sample json download
    # 18181648   # sample json bytes download
    
    Get-SpeedTestResults

    # Write-Host "Version:         $Version"                 # Debug
    # Write-Host "ReleaseYear:     $ReleaseYear"             # Debug
    # Write-Host "INSTALLER_SIZE:  $Script:INSTALLER_SIZE"   # Debug
    # Write-Host "INSTALLER_MBYTE: $Script:INSTALLER_BYTES"  # Debug
    # Write-Host "BANDWIDTH:       $Script:BANDWIDTH"        # Debug
    # Pause                                                  # Debug
    
    Write-Host "Need to download $($Script:INSTALLER_SIZE)MB installer."
    $query = Read-Host "Do you want to continue? (Y/n)"
    
    switch ($query) {
      "n" {
        Write-Action_OperationCancelled
        Select-QuickBooksVersion
        Get-QuickBooksInstaller -Version (Get-Version)
      }
      default {
        Compare-BandwidthSpeedToTime -Version (Get-Version) -Bandwidth $Script:BANDWIDTH
        Start-InstallerDownload -Version (Get-Version) -Year $ReleaseYear
      }
    }
  }
}

function Compare-BandwidthSpeedToTime {
  param($Version, $Bandwidth)
  if ($Version -gt 12 -and $Bandwidth -le 2) {
    Write-Host "Download may take more than 5 minutes to complete`nover your current network." -ForegroundColor Yellow
    $query = Read-Host "Are you ready to start the download? (Y/n)"
    
    if ($query -eq "n") {
      Write-Action_OperationCancelled
      Select-QuickBooksVersion
      Get-QuickBooksInstaller -Version (Get-Version)
    }
  }
}

function Start-InstallerDownload {
  param($Version, $Year)
  Clear-Host
  Write-Host "`n Downloading POS v$($Version), $($Script:INSTALLER_SIZE)MB... " -ForegroundColor White -BackgroundColor DarkCyan
  
  if (-not($Script:BANDWIDTH_UNKNOWN)) {
    $estimated_download_time = Get-TimeToComplete $Script:INSTALLER_BITS $Script:BANDWIDTH_BITS
    Write-Host "`nDST: $Target`nETC: $estimated_download_time @ $($Script:BANDWIDTH) Mbps" -ForegroundColor White
  } else {
    Write-Host "`nDST: $Target`nETC: UNKNOWN @ >0.01 Mbps" -ForegroundColor White
  }
  
  Write-Host "`nEstimated time is calculated from the point that your`ninternet speed was tested. This is just an estimation and`nmay not reflect the actual time that it would take for the`ndownload to complete on your system. This is subject to`nchange as your internet speed fluctuates."
  Write-Host "`nPlease wait while the installer is being downloaded.`nThe installer will be satrted automatically after the`ndownload is complete.`n" -ForegroundColor Yellow
  
  $installer_download_path = "$Target\QuickBooksPOSV${Version}.exe"
  $installer_download_url = "https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/${Year}/Latest/QuickBooksPOSV${Version}.exe"

  $installer_download_job = Start-Job -ScriptBlock {
    param($url, $installer_download_path)
    Invoke-WebRequest -Uri $url -OutFile $installer_download_path
    # Start-BitsTransfer $url $installer_download_path
  } -ArgumentList $installer_download_url, $installer_download_path
  
  if (-not($Script:BANDWIDTH_UNKNOWN)) {
    Start-Progress -DownloadSize $Script:INSTALLER_BITS `
                   -Bandwidth $Script:BANDWIDTH `
                   -DownloadJob $installer_download_job
  }

  # Write-Host $installer_download_path                      # Debug
  Wait-Job $installer_download_job >$null 2>&1
  Remove-Job $installer_download_job
  # Pause                                                    # Debug  
}

function Start-Progress {
  param (
    $DownloadSize, 
    $Bandwidth, 
    $DownloadJob
  )

  $smoothing = 4
  $sleep = 1000 / [math]::Pow(2, $smoothing) # ~62.5ms -> 75ms
  # Write-Host "$sleep (milliseconds)"                       # Debug
  $download_duration = $Script:RAW_DOWNLOAD_TIME * [math]::Pow(2, $smoothing) # x16+n

  # Write-Host "$download_duration (steps)"                  # Debug

  for ($i = 0; $i -le $download_duration; $i++) {
    switch ($DownloadJob.State) {
      'Running' {
        $x = "{0:F2}" -f [math]::Round(($i / $download_duration) * 100, 2)
        Write-Host -NoNewLine "`r [ $x% ] "
        Start-Sleep -Milliseconds $sleep
      }
      'Completed' { break }
      'Failed' { Write-Host ":: Download encountered an error." -ForegroundColor DarkYellow; Pause }
      'Stopped' { Write-Host ":: Download was manually stopped." -ForegroundColor DarkYellow; Pause }
      default { Write-Host ":: Unknown job state: $($DownloadJob.State)" -ForegroundColor DarkYellow; Pause }
    }
  }
}