function Get-SpeedTestResults {
  $Script:BANDWIDTH_BITS = (Measure-UserBandwidth -Type Download -Unit Bits)
  # $Script:BANDWIDTH_BITS = 0                        # Debug
  if ($Script:BANDWIDTH_BITS -eq 0) {
    Write-Host "Proceeding without an estimated time..."
    # Write-Host "[DEBUG] Proceeding without an estimated time..." # Debug
    $Script:BANDWIDTH_UNKNOWN = $true
    return
  }
  else {
    if ($Script:BANDWIDTH -le 80000) { # 0.01 MB
      $Script:BANDWIDTH_UNKNOWN = $true
    } else {
      $Script:BANDWIDTH = (Convert-UserBandwidth -InputUnit Bits -Value $Script:BANDWIDTH_BITS -OutputUnit Megabytes)
    }
    Write-Host " Done."
  }
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

function Get-QuickBooksInstaller {
  <#
  .SYNOPSIS
  Downloads the QuickBooks POS installer from the internet.
  
  .DESCRIPTION
  This function is the first function called by the Install-QuickBooksPOS function.
  It gets the QuickBooks POS installer from the internet.
  
  .NOTES
  Linked to Install-QuickBooksPOS
  #>
  param (
    [String]$Version, # receives version number from `Select-QuickBooksVersion`
    [String]$Target = "$pwd"
  )

  if ($Version -eq $CANCEL) { 
    Write-SubMenu_NoInstallerFound
  }
  else {
    switch ($Version) {
      $POS19InstObj.VerNum {
        $ReleaseYear = $POS19InstObj.Year
        $Script:INSTALLER_SIZE = $POS19InstObj.Size
        $Script:INSTALLER_BYTES = $POS19InstObj.XByte
        $Script:INSTALLER_BITS = $POS19InstObj.XBits
        $Script:SELECTED_QB_VERSION = $POS19InstObj
      }
      $POS18InstObj.VerNum {
        $ReleaseYear = $POS18InstObj.Year
        $Script:INSTALLER_SIZE = $POS18InstObj.Size
        $Script:INSTALLER_BYTES = $POS18InstObj.XByte
        $Script:INSTALLER_BITS = $POS18InstObj.XBits
        $Script:SELECTED_QB_VERSION = $POS18InstObj
      }
      $POS12InstObj.VerNum {
        $ReleaseYear = $POS12InstObj.Year
        $Script:INSTALLER_SIZE = $POS12InstObj.Size
        $Script:INSTALLER_BYTES = $POS12InstObj.XByte
        $Script:INSTALLER_BITS = $POS12InstObj.XBits
        $Script:SELECTED_QB_VERSION = $POS12InstObj
      }
      $POS11InstObj.VerNum {
        $ReleaseYear = $POS11InstObj.Year
        $Script:INSTALLER_SIZE = $POS11InstObj.Size
        $Script:INSTALLER_BYTES = $POS11InstObj.XByte
        $Script:INSTALLER_BITS = $POS11InstObj.XBits
        $Script:SELECTED_QB_VERSION = $POS11InstObj
      }
    }
  }

  Clear-Host
  Write-Host "`nPreparing to download POS v${Version}... "
  Write-Host "This may take a couple of minutes." -ForegroundColor Yellow
  Write-Host "Testing connectivity... " -NoNewLine
  
  if (-not(Test-Connection www.google.com -Quiet)) { 
    Write-Error_NoInternetConnectivity
  }
  else {
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
    Write-Host -NoNewLine "Selected: $query"; Write-Host -NoNewLine "`r                              `r" # To transcript # Debug
    
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

function Start-InstallerDownload {
  <#
  .SYNOPSIS
  Downloads the QuickBooks POS installer from the internet.

  .DESCRIPTION
  This function starts the download of the QuickBooks POS installer
  from the internet. The download progress is displayed in the console
  and estimated time of completion is calculated based on the user's
  internet speed.
  #>
  param(
    [Parameter(Mandatory = $true)]
    $Version,
    [Parameter(Mandatory = $true)]
    [int]$Year
  )

  Clear-Host
  Write-Host "`n Downloading POS v$($Version), $($Script:INSTALLER_SIZE)MB... " -ForegroundColor White -BackgroundColor DarkCyan
  
  if (-not($Script:BANDWIDTH_UNKNOWN)) {
    $estimated_download_time = Get-TimeToComplete $Script:INSTALLER_SIZE $Script:BANDWIDTH
    Write-Host "`nDST: $Target`nETC: $estimated_download_time @ $($Script:BANDWIDTH) MB/s" -ForegroundColor White
  }
  else {
    Write-Host "`nDST: $Target`nETC: UNKNOWN_DURATION @ >0.01 Mbps" -ForegroundColor White
  }
  
  Write-Host "`nEstimated time is calculated from the point that your`ninternet speed was tested. This is just an estimation and`nmay not reflect the actual time that it would take for the`ndownload to complete on your system. This is subject to`nchange as your internet speed fluctuates."
  Write-Host "`nPlease wait while the installer is being downloaded.`nThe installer will be started automatically after the`ndownload is complete.`n" -ForegroundColor Yellow
  
  $installer_download_path = "$Target\QuickBooksPOSV${Version}.exe"
  $installer_download_url = "https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/${Year}/Latest/QuickBooksPOSV${Version}.exe"

  $installer_download_job = Start-Job -ScriptBlock {
    param($url, $Destination)
    try { Invoke-WebRequest -Uri $url -OutFile $Destination }
    catch { Write-Host "Error: $_" -ForegroundColor Red }
    finally { Compare-InstallerDownloadSize }
  } -ArgumentList $installer_download_url, $installer_download_path
  
  Show-WebRequestDownloadJobState -DownloadJob $installer_download_job -Message "Downloading installer"
  
  # Write-Host $installer_download_path                      # Debug
  Wait-Job $installer_download_job >$null 2>&1
  Remove-Job $installer_download_job
  # Pause                                                    # Debug  
}

function Compare-InstallerDownloadSize {  
  # clean up uncompleted donwnload
  if (-not(Compare-IsHashMatch -File $Script:SELECTED_QB_VERSION.Name -Hash $Script:SELECTED_QB_VERSION.Hash)) {
    # Write-Host $Script:SELECTED_QB_VERSION.Name            # Debug
    Remove-Item $Target\$Script:SELECTED_QB_VERSION.Name
  }
}

function Compare-BandwidthSpeedToTime {
  param($Version, $Bandwidth)
  if ($Version -gt 12 -and $Bandwidth -le 2) {
    Write-Host "Download may take more than 5 minutes to complete`nover your current network." -ForegroundColor Yellow
    $query = Read-Host "Are you ready to start the download? (Y/n)"
    Write-Host -NoNewLine "Selected: $query"; Write-Host -NoNewLine "`r                              `r" # To transcript # Debug
    
    if ($query -eq "n") {
      Write-Action_OperationCancelled
      Select-QuickBooksVersion
      Get-QuickBooksInstaller -Version (Get-Version)
    }
  }
}
