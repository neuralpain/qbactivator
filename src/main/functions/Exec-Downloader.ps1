function Get-InstallerSize($URL) {

  # catch potential errors in making requests 
  # to the server for the QuickBooks installer 
  # size for the user's reference
  
  $Error.Clear()
  [int]$size_header = ((Invoke-WebRequest $URL -UseBasicParsing -Method Head).Headers.'Content-Length')
  [int]$MB_size = [math]::Round($size_header / $BYTE_TO_MEGABYTE)
  $script:INSTALLER_SIZE = $MB_size
  
  if ($Error) {
    Clear-Host
    Write-Host "`nFailure retrieving headers!`n" -BackgroundColor DarkRed -ForegroundColor White
    Write-Host "Year: ${ReleaseYear}"
    Write-Host "Version: ${Version}"
    Write-Host "Byte_Size: $size_header"
    Write-Host "MB_Size: ${MB_size}MB"
    Write-Host "`nPlease take a screenshot and send to neuralpain." -ForegroundColor White
    Write-InfoLink -WithFAQs
    exit $PAUSE
    # Pause
  } 
  
  return $MB_size
}

function Start-DownloadProgress($TotalSeconds) {

  # Write-Host download size ...................... $download_size
  # Write-Host bandwidth .......................... $bandwidth
  # Write-Host estimated_download_duration ........ $estimated_download_duration
  # Write-Host
  
  for ($i = 0; $i -le $TotalSeconds; $i++) {
    $x = [math]::Round(($i / $TotalSeconds) * 100, 2)
    Write-Host -NoNewLine "`r$x% complete"
    Start-Sleep -Seconds 1
  }
}

function Get-QuickBooksInstaller {
  param (
    $Version, # receives version from `Select-QuickBooksVersion`
    $Target = $pwd
  )

  if ($Version -eq $CANCEL) { Write-MainMenu_NoInstaller }

  Clear-Host
  Write-Host "`nPreparing to download POS v${Version}... "
  Write-Host "This may take up to a minute." -ForegroundColor Yellow
  Write-Host "Testing connectivity... " -NoNewLine
  
  if (Test-Connection www.google.com -Quiet) {
    Write-Host "OK"
    
    Write-Host "Testing internet speed..." -NoNewline
    # $download_speed = (Get-SpeedTestResults)
    $download_speed = 1
    Write-Host " Done."
    
    switch ($Version) {
      19 { $ReleaseYear = 2019 }
      18 { $ReleaseYear = 2018 }
      12 { $ReleaseYear = 2015 }
      11 { $ReleaseYear = 2013 }
    }
    
    Write-Host -NoNewLine "Requesting installer size... "
    $installer_download_url = "https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/${ReleaseYear}/Latest/QuickBooksPOSV${Version}.exe"
    $installer_size_MB = Get-InstallerSize -URL $installer_download_url
    $time_to_complete = Get-TimeToComplete $installer_size_MB $download_speed
    Write-Host "Done"

    Write-Host "Need to download ${installer_size_MB}MB installer."
    $query = Read-Host "Do you want to continue? (Y/n)"
    
    switch ($query) {
      "n" {
        Write-Action_OperationCancelled
        Select-QuickBooksVersion
        Get-QuickBooksInstaller -Version (Get-Version)
      }
      default {
        if ($Version -gt 12 -and $download_speed -le 2) {
          Write-Host "Download may take more than 5 minutes to complete`nover your current network." -ForegroundColor Yellow
          $query = Read-Host "Are you ready to start the download? (Y/n)"
          
          if ($query -eq "n") {
            Write-Action_OperationCancelled
            Select-QuickBooksVersion
            Get-QuickBooksInstaller -Version (Get-Version)
          }
        }

        Clear-Host
        Write-Host "`n Downloading POS v${Version}, ${installer_size_MB}MB... " -ForegroundColor White -BackgroundColor DarkCyan
        Write-Host "`nDST: $Target`nETC: $time_to_complete @ $download_speed MB/s" -ForegroundColor White
        Write-Host "`nEstimated time is calculated from the point that your`ninternet speed was tested. This is just an estimation and`nmay not reflect the actual time that it would take for the`ndownload to complete on your system. This is subject to`nchange as your internet speed fluctuates."
        Write-Host "`nPlease wait while the installer is being downloaded." -ForegroundColor Yellow





        
        # Start-Job -Name "DownloadPOSInstaller" `
        #   -ScriptBlock { 
          Start-BitsTransfer $installer_download_url "$Target\QuickBooksPOSV${Version}.exe" -Priority High
        # }

        # Start-DownloadProgress -Seconds ([math]::Round($script:INSTALLER_SIZE / $script:BANDWIDTH))

        # Wait-Job -Name "DownloadPOSInstaller"





# Pause

        Write-Host "`nDownload complete."
        Start-Sleep -Milliseconds $TIME_BLINK
      }
    }
  }
  
  else { Write-Error_NoInternetConnectivity; exit $PAUSE }
}
