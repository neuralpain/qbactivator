function Repair-LevelOne_GenuineClientModule {
  <#
  .SYNOPSIS
    Check if the .bak file exists
  #>
  if (Test-Path "${CLIENT_MODULE_FULL_PATH}.bak" -PathType Leaf) {
    Write-Host "Lv1: Fixing error on client module... "
    Remove-Item $CLIENT_MODULE_FULL_PATH -Force | Out-Null
    Rename-Item "${CLIENT_MODULE_FULL_PATH}.bak" $CLIENT_MODULE_FULL_PATH | Out-Null
    # check if the `.bak` file was successfully removed, else escalate to Lv2
    if (Test-Path "${CLIENT_MODULE_FULL_PATH}.bak" -PathType Leaf) {
      Write-Host "Lv1: Unable to resolve error."
      Write-Host "Lv1: Escalating to Lv2..."
      Start-Sleep -Milliseconds $TIME_SLOW
      Repair-LevelTwo_GenuineClientModule_SanityCheck
    } else {
      # notify the user that the client module was successfully repaired
      New-ToastNotification -ToastText "Lv1: Client module restored." -ToastTitle "Client Module Repair"
    }
  }
  else {
    Write-Host "Lv1: Modified client module was not found."
    Start-Sleep -Milliseconds $TIME_SLOW
  }
}

function Repair-LevelTwo_GenuineClientModule_SanityCheck {
  <#
  .SYNOPSIS
    Check if the client file is the genuine one and make any additional repairs. Will only run if this is requested.
  #>
  param([switch]$SanityCheck)
  # if a client module is found on the system then, do a comparison with the PATCH_HASH for genuineity
  if ($SanityCheck) { Write-Host "Lv2: Performing a sanity check..." }
  
  if (Test-Path $CLIENT_MODULE_FULL_PATH -PathType Leaf) {
    Write-Host "Lv2: Found a client module."
    # if the comparison returns true, then this client module was modified
    if ((Compare-IsValidHash -File $CLIENT_MODULE_FULL_PATH -Hash $PATCH_HASH)) {
      Write-Host "Lv2: Client module is modified. Repairing..."
      # remove client files
      Remove-Item "$CLIENT_MODULE_PATH\*" -Force | Out-Null
      # fix this error by using the LOCAL_GENUINE_FILE on user system to repair, if this is available
      # if a LOCAL_GENUINE_FILE is not found, then download it from the host
      Get-ClientModule -Local $LOCAL_GENUINE_FILE -FromHostUrl $GENUINE_CLIENT_FILE_ON_HOST
    }
    else {
      # if the comparison with PATCH_HASH returns false, then there is no issue
      Write-Host "Lv2: No issues found. Nothing to repair."
      Start-Sleep -Milliseconds $TIME_SLOW
      return
    }
  }
  else {
    # if no client module is found on the system, then download it from the host
    Write-Host "Lv2: No client module found. Retrieving..."
    Get-ClientModule -Local $LOCAL_GENUINE_FILE -FromHostUrl $GENUINE_CLIENT_FILE_ON_HOST
    # remove the `.bak` file, if it exists
    if (Test-Path "${CLIENT_MODULE_FULL_PATH}.bak" -PathType Leaf) { 
      Remove-Item "${CLIENT_MODULE_FULL_PATH}.bak" -Force | Out-Null
      Write-Host "Lv2: Removed unusable client module backup."
    }
  }
  # ----------------------------------------------------
  # check if the client module was repaired successfully
  if ((Compare-IsValidHash -File $CLIENT_MODULE_FULL_PATH -Hash $PATCH_HASH)) {
    Write-Host "Lv2: Unable to repair the client module." # create fullscreen prompt for this
    # notify the user that the client module was not repaired
    New-ToastNotification -ToastText "Lv2: Unable to repair the client module." -ToastTitle "Client Module Repair"
  }
  else {
    Write-Host "Lv2: Client module repaired successfully."
    # notify the user that the client module was successfully repaired
    New-ToastNotification -ToastText "Lv2: Client module repaired successfully." -ToastTitle "Client Module Repair"
    Start-Sleep -Milliseconds $TIME_SLOW
  }
}

function Repair-LevelThree_Reactivation {
  # ensure the the quickbooks entitlement client is available for reactivation
  if (-not($Script:QUICKBOOKS_IS_INSTALLED)) {
    Write-Error_QuickBooksNotInstalled
    return
  }
  
  # 如 entitlement client 不在, 没问题，就创建新的
  if (-not(Test-Path $CLIENT_MODULE_DATA_PATH -PathType Container)) {
    Write-Host "Lv3: Data folder not found."
    New-Item $CLIENT_MODULE_DATA_PATH -ItemType Directory | Out-Null
    Write-Host "Lv3: Created new data folder."
    return
  }
  
  Write-Host -NoNewline "Lv3: Removing old activation data... "
  Remove-Item "$CLIENT_MODULE_DATA_PATH\*" -Force | Out-Null
  Write-Host "Done"

  New-ToastNotification -ToastText "Activation data has been cleared." -ToastTitle "Client Module Repair"
}
