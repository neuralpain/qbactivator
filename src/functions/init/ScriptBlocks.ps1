$InitializeMain = {
  $Script:QB_VERSION = $null
  $Script:ACTIVATION_ONLY = $false
  $Script:INSTALLER_SIZE = 0
  $Script:INSTALLER_BITS = 0
  $Script:INSTALLER_BYTES = 0
  $Script:INSTALLER_OBJECT = $null
  $Script:INSTALLER_PATH = $null
  $Script:INSTALLER_HASH = $null
  $Script:INSTALLER_IS_VALID = $false
  $Script:INSTALLER_AVAILABLE = $false
  # $Script:BANDWIDTH = 0
  # $Script:BANDWIDTH_BITS = 0
  # $Script:BANDWIDTH_BYTES = 0
  # $Script:BANDWIDTH_UNKNOWN = $false
  $Script:RAW_DOWNLOAD_TIME = 0
  $Script:SECOND_STORE = $false
  $Script:CUSTOM_LICENSING = $false
  $Script:QUICKBOOKS_IS_INSTALLED = $false
  $Script:ADDITIONAL_CLIENTS = $false
}

$OpenLogs = {
  New-ToastNotification -ToastText "Opening qbactivator log directory..." -ToastTitle "qbactivator"
  explorer.exe "C:\Windows\Logs\qbactivator"
}

$InvokeGeneralActivation = {
  Clear-Terminal
  Stop-QuickBooksProcesses
  New-ToastNotification -ToastText "Forced General Activation initiated" -ToastTitle "qbactivator"
  Invoke-NextProcess PROC_NEXT_STAGE
}  

$ExitQbactivator = {
  Invoke-NextProcess PROC_EXIT
}  

$OpenWiki = { 
  New-ToastNotification -ToastText "Opening qbactivator Wiki..." -ToastTitle "qbactivator"
  Invoke-URLInDefaultBrowser -URL "https://github.com/neuralpain/qbactivator/wiki" 
}  

$TestInternetAvailable = {
  Write-Host -NoNewline "Testing connectivity... "
  if (-not(Test-Connection www.google.com -Quiet)) { 
    Write-Error_NoInternetConnectivity
    Invoke-NextProcess PROC_RETURN_MAIN
  }
  else { Write-Host "OK" }
}

$VerifyIfQuickBooksIsInstalled = {
  foreach ($path in $qbPathList) {
    if (Test-Path "${env:ProgramFiles(x86)}\$path\QBPOSShell.exe" -PathType Leaf) { 
      Write-Host "Found `"$path`""
      $Script:QUICKBOOKS_IS_INSTALLED = $true
      $Script:QUICKBOOKS_INSTALLED_PATH = $path
      $Script:INSTALLER_DOWNLOAD_ONLY = $true
      break
    }
  }
}

$CheckQuickBooksIsNotInstalled_ReturnToMainMenu = {
  if (-not($Script:QUICKBOOKS_IS_INSTALLED)) { 
    Write-Host "Disabled when QuickBooks is not installed." -ForegroundColor Yellow
    $Script:SECOND_STORE = $false
    $Script:ADDITIONAL_CLIENTS = $false
    Start-Sleep -Milliseconds $TIME_NORMAL
    Invoke-NextProcess PROC_RETURN_MAIN
  }
}

$CheckQuickBooksIsInstalled_ReturnToMainMenu = {
  if ($Script:QUICKBOOKS_IS_INSTALLED) { 
    Write-Host "Disabled when QuickBooks is installed." -ForegroundColor Yellow
    $Script:SECOND_STORE = $false
    $Script:ADDITIONAL_CLIENTS = $false
    Start-Sleep -Milliseconds $TIME_NORMAL
    Invoke-NextProcess PROC_RETURN_MAIN
  }
}

$ValidateQuickBooksInstaller = {
  Write-Host -NoNewLine "Verifying `"$($Script:INSTALLER_OBJECT)`"... "
  foreach ($hash in $qbHashList) {
    if (Compare-IsValidHash -Hash $hash -File $Script:INSTALLER_OBJECT) {
      Write-Host "$($Script:INSTALLER_OBJECT) is valid."
      $Script:INSTALLER_IS_VALID = $true
      $Script:INSTALLER_HASH = $hash
      return
    }
  }
  # mark installer as invalid
  Write-Host "Invalid."
  $Script:INSTALLER_IS_VALID = $false
  Write-Error_UnableToVerifyInstaller
}

$LocateQuickBooksInstaller = {
  Write-Host "`nLocating QuickBooks POS installer..."
  # Find which installer version is available and compare 
  # known hashes against the installer for verification
  foreach ($exe in $qbExeList) {
    if (Test-Path ".\$exe" -PathType Leaf) {
      Write-Host "Found `"$exe`""
      $Script:INSTALLER_AVAILABLE = $true
      $Script:INSTALLER_OBJECT = $exe
      Set-Version ($exe.Trim("QuickBooksPOSV.exe"))
    }
  }
}
