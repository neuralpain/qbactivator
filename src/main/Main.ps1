function Compare-Hash {
  param ($Hash, $File)

  $_hash = ((
    Get-FileHash $File -Algorithm MD5 | `
    Select-Object Hash) -split " "
  ).Trim("@{Hash=}")
  
  if ($_hash -ne $Hash) { return $ERR }
  else { return $OK }
}

function Select-QuickBooksVersion {
  $Version = $null

  while ($null -eq $Version) {
    Write-VersionSelectionMenu
    $Version = Read-Host "`nVersion"

    switch ($Version) {
      0 { 
        Write-Action_OperationCancelled
        Set-Version $CANCEL
        return 
      }
      "" { break }
      default {
        if ($qbVersionList -notcontains $Version) {
          Write-Host "Invalid option `"${Version}`"" -ForegroundColor Red
          Start-Sleep -Milliseconds $TIME_BLINK
          break
        }
        else {
          Set-Version $Version 
          return
        }
      }
    }

    $Version = $null
  }
}

function New-ActivationOnlyRequest {
  Clear-Host
  Write-Host "`nGenerating activation-only request..."
  Start-Sleep -Milliseconds $TIME_NORMAL
  Write-Host "Checking for installed QuickBooks software..."

  foreach ($path in $qbPathList) {
    if (Test-Path "${env:ProgramFiles(x86)}\$path\QBPOSShell.exe" -PathType Leaf) { 
      Write-Host "Found `"$path`""
      return 
    }
  }

  # If nothing is found then the activation will not continue.
  Write-Error_QuickBooksNotInstalled
}

function Invoke-QuickBooksInstaller {
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
        $result = (Compare-Hash -Hash $hash -File .\$exe)
        if ($result -eq $OK) {
          Write-Host "OK"
          Get-IntuitLicense -Hash $hash
          break 
        }
      }
      
      # throw error if hashes do not match at any in the list
      if ($result -eq $ERR) {
        Clear-Host
        Write-Host "`nFailed to verify the installer." -ForegroundColor White -BackgroundColor DarkRed
        Write-Host "`nThe installer `"$exe`" may be corrupted." -ForegroundColor Yellow
        Write-Host "`nThis may be a false positive in some cases. Please be sure`nthat you trust the installer if you choose to use it. If`nthe installer was downloaded with this activator, or from`nIntuit, you can trust it."

        $query = Read-Host "`nDo you trust this installer? (y/N)"
        switch ($query) {
          "y" { 
            Write-Host
            Get-IntuitLicense
            Start-Installer .\$exe >$null 2>&1
            Invoke-Activation
          }

          default {
            $query = Read-Host "Do you want to download an installer? (Y/n)"
            switch ($query) {
              "n" { Write-Action_OperationCancelled; exit $ERR }
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
      Invoke-Activation
    }
  }

  Write-Host "A QuickBooks POS installer was not found." -ForegroundColor Yellow
  Start-Sleep -Milliseconds $TIME_SLOW
  
  Write-MainMenu_NoInstaller
}

function Start-Installer {
  param ($Installer)
  # clear temporary installation files from previous 
  # installer launch and start a new installation process
  Remove-Item $intuit_temp -Recurse -Force >$null 2>&1
  Write-WaitingScreen
  $Error.Clear() # reset to catch installer errors, if any
  Start-Process -FilePath $Installer -Wait
  
  if ($Error) { Write-Error_CannotStartInstaller }
  
  foreach ($path in $qbPathList) { 
    if (Test-Path "${env:ProgramFiles(x86)}\$path\QBPOSShell.exe" -PathType Leaf) { 
      Clear-Host; Write-Host
      return 
    } 
  }
  
  Write-Error_QuickBooksNotInstalled
}

function Stop-QuickBooksProcesses {
  Write-Host -NoNewLine "Terminating QuickBooks processes... "
  taskkill.exe /fi "imagename eq qb*" /f /t >$null 2>&1
  taskkill.exe /fi "imagename eq intuit*" /f /t >$null 2>&1
  taskkill.exe /f /im qbw.exe >$null 2>&1
  taskkill.exe /f /im qbw32.exe >$null 2>&1
  taskkill.exe /f /im qbupdate.exe >$null 2>&1
  taskkill.exe /f /im qbhelp.exe >$null 2>&1
  taskkill.exe /f /im QBCFMonitorService.exe >$null 2>&1
  taskkill.exe /f /im QBUpdateService.exe >$null 2>&1
  taskkill.exe /f /im IBuEngHost.exe >$null 2>&1
  taskkill.exe /f /im msiexec.exe >$null 2>&1
  taskkill.exe /f /im mscorsvw.exe >$null 2>&1
  taskkill.exe /f /im QBWebConnector.exe >$null 2>&1
  taskkill.exe /f /im QBDBMgr9.exe >$null 2>&1
  taskkill.exe /f /im QBDBMgr.exe >$null 2>&1
  taskkill.exe /f /im QBDBMgrN.exe >$null 2>&1
  taskkill.exe /f /im QuickBooksMessaging.exe >$null 2>&1
  
  # if (Test-Path $CLIENT_MODULE_DATA) { Remove-Item $CLIENT_MODULE_DATA -Force }
  
  Write-Host "Done"
}

function Remove-TemporaryActvationFiles {
  if (Test-Path "$qbactivator_temp") { 
    Remove-Item $qbactivator_temp -Recurse -Force
  }
}

function Invoke-Activation {
  param ([switch]$ActivationOnly, [Switch]$GeneralActivation)
  
  if ($ActivationOnly) { New-ActivationOnlyRequest }

  Stop-QuickBooksProcesses
  Repair-GenuineClientModule # if damaged
  Find-GenuineClientModule # will exit if missing
  Install-ClientModule # inject modified client
  
  <#
    currently in development
    Install-ClientDataModule -Version 11
  #>
  
  Remove-TemporaryActvationFiles

  Write-Host "Proceeding with activation..." 
  Start-Sleep -Milliseconds $TIME_SLOW
  
  if ($GeneralActivation) { exit $GENERAL_ACTIVATION }
  else { exit $OK }
}

# ---------------------------------- start powershell execution ---------------------------------- #

Write-MainMenu
Remove-TemporaryActvationFiles
exit
