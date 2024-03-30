
function Get-QuickBooksShell {
  param([Switch]$ForRepair)
  
  foreach ($path in $qbPathList) {
    if (Test-Path "${env:ProgramFiles(x86)}\$path\QBPOSShell.exe" -PathType Leaf) { 
      if (-not($ForRepair)) {
        Write-Host "Found `"$path`""
      }
      return $true
    }
  }

  return $false
}

function Select-QuickBooksVersion {
  <#
  .NOTES
  Linked to Get-QuickBooksInstaller, Write-SubMenu_NoInstallerFound
  #>  
  while ($null -eq $Script:QB_VERSION) {
    Write-VersionSelectionMenu
    $version = Read-Host "`nVersion"

    switch ($version) {
      "" { break }
      0 { 
        Write-Action_OperationCancelled
        Set-Version $CANCEL
        return 
      }
      default {
        if ($qbVersionList -notcontains $version) {
          Write-Host "Invalid option `"${version}`"" -ForegroundColor Red
          Start-Sleep -Milliseconds $TIME_BLINK
          break
        } else { 
          Set-Version $version
          return 
        }
      }
    }
  }
}

function Invoke-QuickBooksInstaller {
  <#
  .SYNOPSIS
  Invokes the QuickBooks POS installer
  
  .DESCRIPTION
  Checks for a QuickBooks POS installer in the working directory, 
  verifies the installer with known hashes, and if the installer is 
  trusted or the user chooses to download a new installer, the 
  installer is launched. If no installer is found, the user is 
  given the option to download a new installer from Intuit.
  
  .NOTES
  Linked to Invoke-PosActivation
 
  Calls:
    - Get-QuickBooksInstaller
    - Get-PosLicense
    - Install-PosLicense
  #>
  Clear-Host
  Write-Host "`nChecking for QuickBooks installer..."
  
  # Find which installer version is available and compare 
  # known hashes against the installer for verification
  foreach ($exe in $qbExeList) {
    if (Test-Path ".\$exe" -PathType Leaf) {
      Write-Host "Found `"$exe`"."
      
      # quickbooks version retrieved here in the event that
      # the user's installer is not recognized from the hash
      # but they still want to use it
      Set-Version ($exe.Trim("QuickBooksPOSV.exe"))
      
      Write-Host -NoNewLine "Verifying `"$exe`"... "

      foreach ($hash in $qbHashList) {
        $isValid = (Compare-IsHashMatch -File .\$exe -Hash $hash)
        if ($isValid) {
          Write-Host "OK"
          Get-PosLicense $hash
          if (Confirm-IsQuickBooksInstalled) {
            Write-Error_QuickBooksIsInstalled
            Write-SubMenu_NoInstallerFound
            exit
          }
          Install-PosLicense
          break 
        }
      }
      
      # throw error if hashes do not match at any in the list
      if (-not($isValid)) {
        Clear-Host
        Write-Host "`nFailed to verify the installer." -ForegroundColor White -BackgroundColor DarkRed
        Write-Host "`nThe installer `"$exe`" may be corrupted." -ForegroundColor Yellow
        Write-Host "`nThis may be a false positive in some cases. Please be sure`nthat you trust the installer if you choose to use it. If`nthe installer was downloaded with this activator, or from`nIntuit, you can trust it."

        $query = Read-Host "`nDo you trust this installer? (y/N)"
        Write-Host -NoNewLine "Selected: $query"; Write-Host -NoNewLine "`r                              `r" # To transcript # Debug
        switch ($query) {
          "y" { 
            Clear-Terminal
            Get-PosLicense
            Install-PosLicense
            Start-Installer .\$exe >$null 2>&1
            Invoke-PosActivation
          }
          default {
            $query = Read-Host "Do you want to download an installer? (Y/n)"
            Write-Host -NoNewLine "Selected: $query"; Write-Host -NoNewLine "`r                              `r" # To transcript # Debug
            
            switch ($query) {
              "n" {
                Write-Action_OperationCancelled
                Write-MainMenu
              }
              default {
                Select-QuickBooksVersion
                Get-QuickBooksInstaller -Version (Get-Version)
                Invoke-QuickBooksInstaller
              }
            }
          }
        }
      }
      
      Start-Installer .\$exe
      Invoke-PosActivation
    }
  }

  Write-Host "A QuickBooks POS installer was not found." -ForegroundColor Yellow
  Start-Sleep -Milliseconds $TIME_SLOW
  Write-SubMenu_NoInstallerFound
}

function Start-Installer {
  param ($Installer)
  # clear temporary installation files from previous 
  # installer launch and start a new installation process
  Remove-Item $intuit_temp -Recurse -Force >$null 2>&1
  Write-WaitingScreen
  
  try { Start-Process -FilePath $Installer -Wait }
  catch { Write-Error_CannotStartInstaller }
  
  foreach ($path in $qbPathList) { 
    if (Test-Path "${env:ProgramFiles(x86)}\$path\QBPOSShell.exe" -PathType Leaf) { 
      Clear-Terminal
      return
    } 
  }
  
  Write-Error_QuickBooksNotInstalled
}

function New-ActivationOnlyRequest {
  <#
  .NOTES
  Linked to Invoke-PosActivation
  #>
  Clear-Host
  Write-Host "`nGenerating activation-only request..."
  Start-Sleep -Milliseconds $TIME_NORMAL
  Write-Host "Checking for installed QuickBooks software..."

  # If nothing is found then the activation will not continue.
  switch (Get-QuickBooksShell) {
    $true { return }
    $false { Write-Error_QuickBooksNotInstalled }
  }
}

function Invoke-PosActivation {
  <#
  .NOTES
  Linked to Write-InformationToDisplay.ps1
  
  Calls:
    - New-ActivationOnlyRequest
    - Find-GenuineClientModule
    - Stop-QuickBooksProcesses
    - Repair-GenuineClientModule
    - Install-ClientModulePatch
  #>
  param ([switch]$ActivationOnly, [Switch]$GeneralActivation)
  
  if ($ActivationOnly) { New-ActivationOnlyRequest }

  Find-GenuineClientModule # will exit if missing
  Stop-QuickBooksProcesses
  Repair-GenuineClientModule -IsInstallation # automatic Lv1 repair if damaged
  Install-ClientModulePatch # inject modified client
  
  <#
    TODO: in development
    Install-ClientDataModule -Version 11
  #>
  
  # Remove-TemporaryActvationFiles

  Write-Host "Proceeding with activation..." 
  Start-Sleep -Milliseconds $TIME_SLOW
  
  if ($GeneralActivation) { exit $GENERAL_ACTIVATION }
  else { exit $OK }
}

# -------- start PowerShell execution -------- #

# if qbactivator was manually run as administrator by the user, panic

if ("C:\Windows\system32" -eq $pwd) {
  Write-Error_IsManualAdministrator
}
else {
  Write-MainMenu
}

Pause
exit
