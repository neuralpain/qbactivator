
# verify that the patch was successful
$VerifyClientModulePatch = {
  if (Compare-IsValidHash -File "$CLIENT_MODULE_FULL_PATH" -Hash $PATCH_HASH) {
    Write-Host "Patch successful."
  }
  else {
    Write-Host "Unable to patch POS."; Pause
    Invoke-NextProcess $PROC_RETURN_MAIN
  }
}

function Get-ClientModule {
  param ($Local, $FromHostUrl)
  # check if the local file exists
  if ($Local) {
    if (Test-Path $Local -PathType Leaf) {
      Copy-Item $Local $CLIENT_MODULE_FULL_PATH
      return
    }
  }
  
  Write-Host "Local file not found."
  # if its a host request only
  &$TestInternetAvailable
  Write-Host "Downloading, please wait..."
  Start-BitsTransfer $FromHostUrl $CLIENT_MODULE_FULL_PATH
  return
}

function Install-ClientModule {
  Write-Host "Patching client module... "
  Rename-Item $CLIENT_MODULE_FULL_PATH "${CLIENT_MODULE_FULL_PATH}.bak" >$null 2>&1
  # attempt to patch with the local patch file first
  if (Test-Path "$LOCAL_PATCH_FILE" -PathType Leaf) {
    $isValid = Compare-IsValidHash -Hash $PATCH_HASH -File $LOCAL_PATCH_FILE
    if ($isValid) { Copy-Item $LOCAL_PATCH_FILE $CLIENT_MODULE_FULL_PATH } 
    else { 
      Write-Host "`nPatch file may be corrupted."
      Get-ClientModule -FromHostUrl $CLIENT_FILE_ON_HOST
      &$VerifyClientModulePatch # call back and verify that the patch was successful
    }
  }
  else { 
    Get-ClientModule -FromHostUrl $CLIENT_FILE_ON_HOST
    &$VerifyClientModulePatch # call back and verify that the patch was successful
  }
}
