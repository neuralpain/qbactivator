function Get-QuickBooksInstaller {
  param (
    $Version, # receives version number from `Select-QuickBooksVersion`
    $Target = $pwd
  )

  if ($Version -eq $CANCEL) { Write-MainMenu_NoInstaller }

  Clear-Host
  Write-Host "`nPreparing to download POS v${Version}... "
  Write-Host "This may take a couple of minutes." -ForegroundColor Yellow
  Write-Host "Testing connectivity... " -NoNewLine
  
  if (-not(Test-Connection www.google.com -Quiet)) { 
    Write-Error_NoInternetConnectivity
  } else {
    Write-Host "OK"
    Write-Host "Testing internet speed..." -NoNewline
    
    # [double]$bandwidth = 10298640 # Debug Sample
    # Write-Host " Done. (debugging sample)" # Debug

    [double]$bandwidth = (Get-SpeedTestResults)
    [double]$bandwidth = [math]::Round($bandwidth / 0.125 / $BYTE_TO_MEGABYTE, 2)
    
    Write-Host " Done."
    
    switch ($Version) {
      $POS19InstObj.VerNum {
        $ReleaseYear = $POS19InstObj.Year
        $Script:INSTALLER_SIZE = $POS19InstObj.Size
        $Script:INSTALLER_BYTES = $POS19InstObj.XByte
      }
      $POS18InstObj.VerNum {
        $ReleaseYear = $POS18InstObj.Year
        $Script:INSTALLER_SIZE = $POS18InstObj.Size
        $Script:INSTALLER_BYTES = $POS18InstObj.XByte
      }
      $POS12InstObj.VerNum {
        $ReleaseYear = $POS12InstObj.Year
        $Script:INSTALLER_SIZE = $POS12InstObj.Size
        $Script:INSTALLER_BYTES = $POS12InstObj.XByte
      }
      $POS11InstObj.VerNum {
        $ReleaseYear = $POS11InstObj.Year
        $Script:INSTALLER_SIZE = $POS11InstObj.Size
        $Script:INSTALLER_BYTES = $POS11InstObj.XByte
      }
    }

    # Write-Host "Version:         $Version" # Debug
    # Write-Host "ReleaseYear:     $ReleaseYear" # Debug
    # Write-Host "INSTALLER_SIZE:  $Script:INSTALLER_SIZE" # Debug
    # Write-Host "INSTALLER_MBYTE: $Script:INSTALLER_BYTES" # Debug
    # Write-Host "bandwidth:       $bandwidth" # Debug
    # Pause # Debug

    Write-Host -NoNewLine "Requesting installer size... "
    $installer_download_url = "https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/${ReleaseYear}/Latest/QuickBooksPOSV${Version}.exe"
    $time_to_complete = Get-TimeToComplete $Script:INSTALLER_SIZE $bandwidth
    Write-Host "Done"

    $xyz = "$Script:INSTALLER_SIZE"
    Write-Host "Need to download ${xyz}MB installer."
    $query = Read-Host "Do you want to continue? (Y/n)"
    
    switch ($query) {
      "n" {
        Write-Action_OperationCancelled
        Select-QuickBooksVersion
        Get-QuickBooksInstaller -Version (Get-Version)
      }
      default {
        if ($Version -gt 12 -and $bandwidth -le 2) {
          Write-Host "Download may take more than 5 minutes to complete`nover your current network." -ForegroundColor Yellow
          $query = Read-Host "Are you ready to start the download? (Y/n)"
          
          if ($query -eq "n") {
            Write-Action_OperationCancelled
            Select-QuickBooksVersion
            Get-QuickBooksInstaller -Version (Get-Version)
          }
        }

        Clear-Host
        Write-Host "`n Downloading POS v${Version}, ${xyz}MB... " -ForegroundColor White -BackgroundColor DarkCyan
        Write-Host "`nDST: $Target`nETC: $time_to_complete @ $bandwidth MB/s" -ForegroundColor White
        Write-Host "`nEstimated time is calculated from the point that your`ninternet speed was tested. This is just an estimation and`nmay not reflect the actual time that it would take for the`ndownload to complete on your system. This is subject to`nchange as your internet speed fluctuates."
        Write-Host "`nPlease wait while the installer is being downloaded.`nThe installer will be satrted automatically after the`ndownload is complete.`n" -ForegroundColor Yellow
        
        $destinationPath = "$Target\QuickBooksPOSV${Version}.exe"

        $downloadJob = Start-Job -ScriptBlock {
          param($url, $destinationPath)
          Invoke-WebRequest -Uri $url -OutFile $destinationPath
        } -ArgumentList $installer_download_url, $destinationPath
        
        Start-Progress -DownloadSize $Script:INSTALLER_SIZE -Bandwidth $bandwidth -DownloadJob $downloadJob

        # Write-Host $destinationPath # Debug
        Wait-Job $downloadJob >$null 2>&1
        Remove-Job $downloadJob
        # Pause # Debug
      }
    }
  }
}

function Start-Progress {
  param (
    $DownloadSize, 
    $Bandwidth, 
    $DownloadJob
  )

  $exp = 4
  $sleep = (1000 / [math]::Pow(2, $exp)) # ~62ms
  $duration = [math]::Round($DownloadSize / $Bandwidth) * [math]::Pow(2, $exp) # x16
  
  for ($i = 0; $i -le $duration; $i++) {
    switch ($DownloadJob.State) {
      'Running' {
        $x = "{0:F2}" -f ([math]::Round(($i / $duration) * 100, 2))
        Write-Host -NoNewLine "`r [ $x% ]"
        Start-Sleep -Milliseconds $sleep
      }
      'Completed' { break }
      'Failed' { Write-Host -NoNewLine "`rDownload encountered an error."; Pause }
      'Stopped' { Write-Host -NoNewLine "`rDownload was manually stopped."; Pause }
      default { Write-Host -NoNewLine "Unknown job state: $($DownloadJob.State)" }
    }   
  }
}