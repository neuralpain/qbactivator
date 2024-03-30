<# --- CLIENT MODULE FUNCTIONS --- #>

function Get-ClientFileFromHost {
  param(
    [Parameter(Mandatory = $true)][String]$File,
    # [Parameter(Mandatory = $true)][String]$Destination,
    [Parameter(Mandatory = $true)][String]$Type
  )
  
  $client_file_download_job = Start-Job -ScriptBlock {
    param($_File)
    Invoke-WebRequest -Uri $_File -OutFile $env:TEMP\EntClient.tmp
    Copy-Item $env:TEMP\EntClient.tmp $CLIENT_MODULE_FULL_PATH
    Remove-Item $env:TEMP\EntClient.tmp -Force
  } -ArgumentList $File

  Show-WebRequestDownloadJobState -DownloadJob $client_file_download_job -Message "Downloading client module"
  # Wait-Job $client_file_download_job >$null 2>&1
  # Remove-Job $client_file_download_job
}

function Get-ClientModule {
  param (
    [String]$Local = $null, # initialaizad with $null to be validated by the if statement
    [Parameter(Mandatory = $true)][String]$FromHost,
    [Parameter(Mandatory = $true)][String]$Type
  )

  if ($Local) {
    if (Test-Path $Local -PathType Leaf) {
      Copy-Item $Local $CLIENT_MODULE_FULL_PATH
      return
    }
  }
  else { Write-Host "Local file not found." }

  ### FALLBACK ###

  # if its a host request only
  Write-Host -NoNewline "Testing connectivity... "
  if (-not(Test-Connection www.google.com -Quiet)) { 
    Write-Error_NoInternetConnectivity
  }
 
  Write-Host "OK"
  # Get-ClientFileFromHost -File $FromHost -Destination $CLIENT_MODULE_FULL_PATH -Type $Type
  
  $client_file_download_job = Start-Job -ScriptBlock {
    param($url)
    Invoke-WebRequest -Uri $url -OutFile $CLIENT_MODULE_FULL_PATH
  } -ArgumentList $FromHost
  
  Show-WebRequestDownloadJobState -DownloadJob $client_file_download_job -Message "Downloading client module"
  return
}

function Find-GenuineClientModule {
  if (-not(Test-Path $CLIENT_MODULE_FULL_PATH -PathType Leaf)) {
    Write-Error_QuickBooksNotInstalled
  }
}

function Clear-ClientActivationFolder {
  if (-not(Test-Path $CLIENT_MODULE_FULL_PATH -PathType Leaf)) {
    Write-Error_QuickBooksNotInstalled
  }
  
  if (-not(Test-Path $CLIENT_MODULE_DATA_PATH -PathType Container)) {
    Write-Host "Data folder not found."
    New-Item $CLIENT_MODULE_DATA_PATH -ItemType Directory >$null 2>&1
    Write-Host "Created new data folder."
    return
  }
  
  Write-Host -NoNewline "Removing old activation data... "
  Remove-Item "$CLIENT_MODULE_DATA_PATH\*" -Force >$null 2>&1
  Write-Host "Done"
}

function Install-ClientModulePatch {
  Write-Host -NoNewLine "Patching client module... "
  
  Move-Item $CLIENT_MODULE_FULL_PATH "${CLIENT_MODULE_FULL_PATH}.bak" -Force >$null 2>&1

  if (Test-Path "$LOCAL_PATCH_FILE" -PathType Leaf) {
    if ((Compare-IsHashMatch -File $LOCAL_PATCH_FILE -Hash $PATCH_HASH)) { 
      Copy-Item $LOCAL_PATCH_FILE $CLIENT_MODULE_FULL_PATH
    }
    else { 
      Write-Host "`nPatch file may be corrupted."
      Get-ClientModule -Local $LOCAL_PATCH_FILE -FromHost $CLIENT_FILE_ON_HOST -Type "Patch"
      Write-Host "Patch successful."
      return
    }
  }
  else {
    Write-Host "`nLocal patch file not found."
    Write-Host "Requesting client module..."
    Get-ClientModule -FromHost $CLIENT_FILE_ON_HOST -Type "Patch"
    Write-Host "Patch successful."
    return
  }

  Write-Host "Done"
}
