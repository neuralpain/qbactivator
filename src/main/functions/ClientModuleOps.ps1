<# --- CLIENT MODULE FUNCTIONS --- #>

$PATCH_FILE = ".\EntClient.dll"
$PATCH_HASH = "1A1816C78925E734FCA16974BDBAA4AA"
$clientfilehost = "https://raw.githubusercontent.com/neuralpain/qbactivator/v0.20.2/src/bin/ecc/EntClient.dll"
$CLIENT_MODULE = "$env:SystemRoot\Microsoft.NET\assembly\GAC_MSIL\Intuit.Spc.Map.EntitlementClient.Common\v4.0_8.0.0.0__5dc4fe72edbcacf5\Intuit.Spc.Map.EntitlementClient.Common.dll"

function Get-ClientModule {
  Write-Host -NoNewline "Testing connectivity... "
  if (Test-Connection www.google.com -Quiet) {
    Write-Host "OK"
    Write-Host -NoNewLine "Downloading client module... "
    Start-BitsTransfer $clientfilehost $CLIENT_MODULE
    Write-Host "Done"
  } else { 
    Write-NoInternetConnectivity
    exit $PAUSE 
  }
}

function Find-GenuineClientModule {
  # Determine if the client module is present on the system. This is necessary for proper activation.
  if (-not(Test-Path $CLIENT_MODULE -PathType Leaf)) {
    Write-QuickBooksNotInstalled
    exit $PAUSE
  }
}

function Repair-GenuineClientModule {
  if (Test-Path "${CLIENT_MODULE}.bak" -PathType Leaf) {
    Write-Host -NoNewLine "Fixing error in client module... "
    Remove-Item $CLIENT_MODULE -Force >$null 2>&1
    Rename-Item "${CLIENT_MODULE}.bak" $CLIENT_MODULE
    Write-Host "Done"

    $query = Read-Host "Continue to patch QuickBooks POS? (Y/n)"
    
    switch ($query) { 
      "n" { exit $NONE } 
      default { break } 
    }
  }
}

function Install-ClientModule {
  Write-Host -NoNewLine "Patching client module... "
  
  Rename-Item $CLIENT_MODULE "${CLIENT_MODULE}.bak" >$null 2>&1

  if (Test-Path "$PATCH_FILE" -PathType Leaf) {
    # Perform verification for file integrity on the patch file if present
    $result = Compare-Hash -Hash $PATCH_HASH -File $PATCH_FILE
    if ($result -ne $ERR) { Copy-Item $PATCH_FILE $CLIENT_MODULE } 
    else { 
      Write-Host "`nPatch file may be corrupted."
      Get-ClientModule
      Write-Host "Patch successful."
      return
    }
  }
  else { 
    Write-Host "`nLocal patch file not found."
    Write-Host "Requesting client module..."
    Get-ClientModule
    Write-Host "Patch successful."
    return
  }

  Write-Host "Done"
}

<#--- DATA MODULE ---#>

$CLIENT_MODULE_DATA_PATH = "$env:ProgramData\Intuit\Entitlement Client\v8"
$CLIENT_MODULE_DATA = "$CLIENT_MODULE_DATA_PATH\EntitlementDataStore.ecml"
$EDS19 = "https://github.com/neuralpain/qbactivator/files/11451420/EDS19.zip"
$EDS18 = "https://github.com/neuralpain/qbactivator/files/11451419/EDS18.zip"
$EDS12 = "https://github.com/neuralpain/qbactivator/files/11451418/EDS12.zip"
$EDS11 = "https://github.com/neuralpain/qbactivator/files/11451417/EDS11.zip"

function Remove-ClientDataModulePatch {
  Write-Host "---"
  
  if (Test-Path "${CLIENT_MODULE_DATA}.bak" -PathType Leaf) {
    Write-Host -NoNewline "Removing previous data patch... "
    Copy-Item "${CLIENT_MODULE_DATA}.bak" $CLIENT_MODULE_DATA
    Remove-Item "${CLIENT_MODULE_DATA}.bak"
    Write-Host "Done."
    Start-Sleep -Milliseconds $TIME_NORMAL
  } else { 
    Write-Host "No data patch found. Client data module was not modified."
    Start-Sleep -Milliseconds $TIME_NORMAL
  }
  
  Write-NextOperationMenu
}


function Install-ClientDataModule {
  param ($Version)
  
  <# 
    `Install-ClientDataModule` is still in development and is not 
    functional enough to be included in an official release
  #>
  
  Remove-ClientDataModulePatch # if previously patched
  
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
    Write-NoInternetConnectivity
    exit $PAUSE 
  }
}
