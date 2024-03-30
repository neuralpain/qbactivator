<# --- CLIENT MODULE FUNCTIONS --- #>

function Get-ClientModule {
  param($ClientModule)
  Write-Host -NoNewline "Testing connectivity... "
  if (-not(Test-Connection www.google.com -Quiet)) { 
    Write-Error_NoInternetConnectivity
  }
  else {
    Write-Host "OK"
    Write-Host -NoNewLine "Downloading client module... "
    Start-BitsTransfer $ClientModule $CLIENT_MODULE_PATH
    Write-Host "Done"
  }
}

function Find-GenuineClientModule {
  if (-not(Test-Path $CLIENT_MODULE_PATH -PathType Leaf)) {
    Write-Error_QuickBooksNotInstalled
  }
}

function Repair-GenuineClientModule {
  param([Switch]$SanityCheck)
  
  if (-not(Test-Path $CLIENT_MODULE_PATH -PathType Leaf)) {
    Write-Error_QuickBooksNotInstalled # or file missing ### add this next
  }

  if ($SanityCheck) {
    if ((Compare-IsValidHash $CLIENT_MODULE_PATH -Hash $PATCH_HASH)) {
      Copy-Item $LOCAL_GENUINE_FILE $CLIENT_MODULE_PATH
      else { Get-ClientModule $GENUINE_CLIENT_FILE_ON_HOST }
    }
    else { 
      Write-Host "No issues found. Nothing to repair." 
      Start-Sleep -Milliseconds $TIME_NORMAL
      return
    }
    Write-Host "Client module repaired."
    Start-Sleep -Milliseconds $TIME_NORMAL
    return
  }
  
  if (Test-Path "${CLIENT_MODULE_PATH}.bak" -PathType Leaf) {
    Write-Host -NoNewLine "Fixing error on client module... "
    Remove-Item $CLIENT_MODULE_PATH -Force >$null 2>&1
    Rename-Item "${CLIENT_MODULE_PATH}.bak" $CLIENT_MODULE_PATH
    Write-Host "Done"

    $query = Read-Host "Continue to patch QuickBooks POS? (Y/n)"
    
    switch ($query) { 
      "n" { exit $NONE } 
      default { break } 
    }
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

<#--- DATA MODULE ---#>

# $EDS19 = "https://github.com/neuralpain/qbactivator/files/11451420/EDS19.zip"
# $EDS18 = "https://github.com/neuralpain/qbactivator/files/11451419/EDS18.zip"
# $EDS12 = "https://github.com/neuralpain/qbactivator/files/11451418/EDS12.zip"
# $EDS11 = "https://github.com/neuralpain/qbactivator/files/11451417/EDS11.zip"

function Repair-ClientDataModulePatch {
  Write-Host "---"
  
  if (Test-Path "${CLIENT_MODULE_DATA}.bak" -PathType Leaf) {
    Write-Host -NoNewline "Removing previous data patch... "
    Copy-Item "${CLIENT_MODULE_DATA}.bak" $CLIENT_MODULE_DATA
    Remove-Item "${CLIENT_MODULE_DATA}.bak"
    Write-Host "Done."
    Start-Sleep -Milliseconds $TIME_NORMAL
  }
  else { 
    Write-Host "No data patch found. Client data module was not modified."
    Start-Sleep -Milliseconds $TIME_NORMAL
  }
}

<# 
  # `Install-ClientDataModule` is still in development and is not 
  # functional enough to be included in an official release

  function Install-ClientDataModule {
    param ($Version)
    
      
      Repair-ClientDataModulePatch # if previously patched
      
      if (Test-Path $CLIENT_MODULE_DATA -PathType Leaf) { 
        Copy-Item $CLIENT_MODULE_DATA "${CLIENT_MODULE_DATA}.bak" 
      }
      
      Write-Host -NoNewline "Testing connectivity... "
      if (Test-Connection www.google.com -Quiet) {
        Write-Host "OK"
        Write-Host -NoNewLine "Installing data module... "
        if (-not(Test-Path -Path "$CLIENT_MODULE_DATA_PATH" -PathType Leaf)) { mkdir "$CLIENT_MODULE_DATA_PATH" >$null 2>&1 }
        
        switch ($Version) {
          19 { Start-BitsTransfer $EDS19 $CLIENT_MODULE_DATA }
          18 { Start-BitsTransfer $EDS18 $CLIENT_MODULE_DATA }
          12 { Start-BitsTransfer $EDS12 $CLIENT_MODULE_DATA }
          11 { Start-BitsTransfer $EDS11 $CLIENT_MODULE_DATA }
        }
        
        Write-Host "Done"
      } else { 
        Write-Error_NoInternetConnectivity 
      }
    }
  }
#>
