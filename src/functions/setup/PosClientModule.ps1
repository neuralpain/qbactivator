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



<#
function Get-ClientModule {
  Write-Host -NoNewline "Testing connectivity... "
  if (-not(Test-Connection www.google.com -Quiet)) { 
    Write-Error_NoInternetConnectivity
  }
  else { 
    Write-Host "OK"
    Write-Host -NoNewLine "Downloading client module... "
    Start-BitsTransfer $CLIENT_FILE_ON_HOST $CLIENT_MODULE
    Write-Host "Done"
  }
}
#>



function Get-ClientModule {
  param ($Local, $FromHostUrl)

  # check if the local file exists
  if ($Local) {
    if (Test-Path $Local -PathType Leaf) {
      Copy-Item $Local $CLIENT_MODULE_FULL_PATH
      return
    }
  }
  else {
    Write-Host "Local file not found."
    # if its a host request only
    Write-Host -NoNewline "Testing connectivity... "
    if (-not(Test-Connection www.google.com -Quiet)) { 
      Write-Error_NoInternetConnectivity
      Invoke-NextProcess $null
    }
    else {
      Write-Host "OK"
      Write-Host "Retrieving..."
    }
    
    # Get-ClientFileFromHostUrl -File $FromHostUrl -Destination $CLIENT_MODULE_FULL_PATH
    
    $client_file_download_job = Start-Job -ScriptBlock {
      param($url)
      Invoke-WebRequest -Uri $url -OutFile $CLIENT_MODULE_FULL_PATH
    } -ArgumentList $FromHostUrl
  
    Show-WebRequestDownloadJobState -DownloadJob $client_file_download_job -Message "Downloading client module"
    return
  }
}





# function Find-GenuineClientModule {
#   if (-not(Test-Path $CLIENT_MODULE -PathType Leaf)) {
#     Write-Error_QuickBooksNotInstalled
#   }
# }



function Install-ClientModule {
  param([Switch]$Verify)
  
  # verify that the patch was successful
  if ($Verify) {
    if (Compare-IsValidHash -File "$CLIENT_MODULE_FULL_PATH" -Hash $PATCH_HASH) {
      Write-Host "Patch successful."
      return
    }
    else {
      Write-Host "Unable to patch POS."; Pause
      Invoke-NextProcess $null
      return
    }
  }

  Write-Host "Patching client module... "
  
  Rename-Item $CLIENT_MODULE_FULL_PATH "${CLIENT_MODULE_$CLIENT_MODULE_FULL_PATH}.bak" >$null 2>&1

  # attempt to patch with the local patch file first
  if (Test-Path "$LOCAL_PATCH_FILE" -PathType Leaf) {
    $isValid = Compare-IsValidHash -Hash $PATCH_HASH -File $LOCAL_PATCH_FILE
    if ($isValid) { Copy-Item $LOCAL_PATCH_FILE $CLIENT_MODULE_FULL_PATH } 
    else { 
      Write-Host "`nPatch file may be corrupted."
      Get-ClientModule -FromHostUrl $CLIENT_FILE_ON_HOST
      Install-ClientModule -Verify # call back and verify that the patch was successful
    }
  }
  else { 
    Get-ClientModule -FromHostUrl $CLIENT_FILE_ON_HOST
    Install-ClientModule -Verify # call back and verify that the patch was successful
  }

  # Write-Host "Done"
}
