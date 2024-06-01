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

function Compare-InstallerDownloadSize {  
  # clean up uncompleted donwnload
  if (-not(Compare-IsValidHash -File $Script:SELECTED_QB_OBJECT.Name -Hash $Script:SELECTED_QB_OBJECT.Hash)) {
    # Write-Host $Script:SELECTED_QB_OBJECT.Name            # Debug
    Remove-Item $Script:SELECTED_QB_OBJECT.Name
  }
}

<#
function Compare-BandwidthSpeedToTime {
  param($Version, $Bandwidth)
  if ($Version -gt 12 -and $Bandwidth -le 2) {
    Write-Host "Download may take more than 5 minutes to complete`nover your current network." -ForegroundColor Yellow
    $query = Read-Host "Are you ready to start the download? (Y/n)"
    
    if ($query -eq "n") {
      Write-Action_OperationCancelled
      Select-QuickBooksVersion
      Get-QuickBooksInstaller
    }
  }
}
#>

function Select-QuickBooksVersion {
  <#
  .NOTES
    Triggered by `Write-Menu_VersionSelection`
  #>
  if ($null -ne $Script:QB_VERSION) {
    Write-Host "Already selected version: $(Get-Version)"
    Write-Host "Clear selection?"
    $query = Read-Host "Y/n"
    switch ($query) {
      "Y" { Set-Version $null }
      default { break } # do nothing and return to menu
    }
  }
  
  while ($null -eq $Script:QB_VERSION) {
    Write-Menu_VersionSelection
    switch (Get-Version) {
      "" { break }
      0 {
        Write-Action_OperationCancelled
        Set-Version $null
        return
      }
      default {
        if ($qbVersionList -notcontains $Script:QB_VERSION) {
          Write-Host "Invalid option `"${version}`"" -ForegroundColor Red
          Set-Version $null
          Start-Sleep -Milliseconds $TIME_BLINK
          break
        }
        else { return }
      }
    }
  }
}

function Get-QuickBooksObject {
  <#
  .SYNOPSIS
    Downloads the QuickBooks POS installer from the internet.
  
  .DESCRIPTION
    This function is the first function called by the Install-QuickBooksPOS function.
    It gets the QuickBooks POS installer from the internet.
  
  .NOTES
    Linked to Install-QuickBooksPOS
  #>
  if ($null -eq $Script:QB_VERSION) { Write-Menu_SubMenu } 
  else {
    switch (Get-Version) {
      $POS19InstObj.VerNum { $Script:SELECTED_QB_OBJECT = $POS19InstObj }
      $POS18InstObj.VerNum { $Script:SELECTED_QB_OBJECT = $POS18InstObj }
      $POS12InstObj.VerNum { $Script:SELECTED_QB_OBJECT = $POS12InstObj }
      $POS11InstObj.VerNum { $Script:SELECTED_QB_OBJECT = $POS11InstObj }
    }

    $Script:INSTALLER_SIZE = $Script:SELECTED_QB_OBJECT.Size
    $Script:INSTALLER_BYTES = $Script:SELECTED_QB_OBJECT.XByte
    $Script:INSTALLER_BITS = $Script:SELECTED_QB_OBJECT.XBits
  }
}

function Get-QuickBooksInstaller {
  Start-InstallerDownload -Version (Get-Version) -Year $Script:SELECTED_QB_OBJECT.Year
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
  param($Version, $Year, $Target = $Script:TARGET_LOCATION)
  
  Clear-Terminal

  Write-Host " Downloading POS v$($Version), $($Script:INSTALLER_SIZE)MB... " -ForegroundColor White -BackgroundColor DarkCyan
  
  if (-not($Script:BANDWIDTH_UNKNOWN)) {
    $estimated_download_time = Get-TimeToComplete $Script:INSTALLER_BITS $Script:BANDWIDTH_BITS
    Write-Host "`nDST: $Target`nETC: $estimated_download_time @ $($Script:BANDWIDTH) Mbps" -ForegroundColor White
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
