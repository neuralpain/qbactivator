function Repair-GenuineClientModule_LevelOne {
  # param([Switch]$Lv2AddedGenuineClientModule)
  # Step 2: Check if the .bak file exists
  if (Test-Path "${CLIENT_MODULE_FULL_PATH}.bak" -PathType Leaf) {
    Write-Host "Lv1: Fixing error on client module... "
    Remove-Item $CLIENT_MODULE_FULL_PATH -Force >$null 2>&1
    Rename-Item "${CLIENT_MODULE_FULL_PATH}.bak" $CLIENT_MODULE_FULL_PATH >$null 2>&1
    # check if the `.bak` file was successfully removed, else escalate to Lv2
    if (Test-Path "${CLIENT_MODULE_FULL_PATH}.bak" -PathType Leaf) {
      Write-Host "Lv1: Unable to resolve error."
      Write-Host "Lv1: Escalating to Lv2..."
      Start-Sleep -Milliseconds $TIME_SLOW
      Repair-GenuineClientModule_LevelTwo_SanityCheck
    }
  }
  else {
    Write-Host "Lv1: Modified client module was not found."
    Start-Sleep -Milliseconds $TIME_SLOW
  }
}

function Repair-GenuineClientModule_LevelTwo_SanityCheck {
  # Step 3: Check if the client file is the genuine one. Will only run if this is requested.
  # if a client module is found on the system then, do a comparison with the PATCH_HASH for genuineity
  Write-Host "Lv2: Performing a sanity check..."
  if (Test-Path $CLIENT_MODULE_FULL_PATH -PathType Leaf) {
    Write-Host "Lv2: Found a client module."
    # if the comparison returns true, then this client module was modified
    if ((Compare-IsHashMatch -File $CLIENT_MODULE_FULL_PATH -Hash $PATCH_HASH)) {
      Write-Host "Lv2: Client module is modified. Repairing..."
      # remove all files 
      Remove-Item "$CLIENT_MODULE_PATH\*" -Force >$null 2>&1
      # fix this error by using the LOCAL_GENUINE_FILE on user system to repair, if this is available
      # if a LOCAL_GENUINE_FILE is not found, then download it from the host
      Get-ClientModule -Local $LOCAL_GENUINE_FILE -FromHost $GENUINE_CLIENT_FILE_ON_HOST -Type "Genuine"
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
    Get-ClientModule -Local $LOCAL_GENUINE_FILE -FromHost $GENUINE_CLIENT_FILE_ON_HOST -Type "Genuine"
    # remove the `.bak` file, if it exists
    if (Test-Path "${CLIENT_MODULE_FULL_PATH}.bak" -PathType Leaf) { 
      Remove-Item "${CLIENT_MODULE_FULL_PATH}.bak" -Force >$null 2>&1
      Write-Host "Lv2: Removed unusable client module backup."
    }
  }
  
  # check if the client module was repaired successfully
  if ((Compare-IsHashMatch -File $CLIENT_MODULE_FULL_PATH -Hash $PATCH_HASH)) {
    Write-Host "Lv2: Unable to repair the client module." # create fullscreen prompt for this
    return
  }
  else {
    Write-Host "Lv2: Client module repaired."
    Start-Sleep -Milliseconds $TIME_SLOW
  }
  
  return
}

function Repair-GenuineClientModule {
  param([Switch]$IsInstallation)
  # Step 1: Check if QuickBooks is installed
  # this just says whether or not the script already checked if QuickBooks is installed
  if ($IsInstallation) { Repair-GenuineClientModule_LevelOne }
  else {
    switch ((Get-QuickBooksShell -ForRepair)) {
      $true { Repair-GenuineClientModule_LevelOne; break }
      $false { Write-Error_QuickBooksNotInstalled; break }
    }
  }
  # Step 2: Repair-GenuineClientModule_LevelOne -> Check if the .bak file exists
  # Step 3: Repair-GenuineClientModule_LevelTwo_SanityCheck -> Check if the client file is the genuine one. Will only run if this is requested.
}
