<# --- CORE FN --- #>

function Set-Version($Version) { $script:QB_VERSION = $Version }
function Get-Version { return $script:QB_VERSION }


function Compare-Hash {
  param ($Hash, $File)
  if ((((Get-FileHash $File -Algorithm MD5 | Select-Object Hash) -split " "
      ).Trim("@{Hash=}")) -ne $Hash) { return $ERR } else { return $OK }
}

function Select-QuickBooksVersion {
  $Version = $null

  while ($null -eq $Version) {
    Write-VersionSelectionMenu
    $Version = Read-Host "`nVersion"

    switch ($Version) {
      0 { Write-OperationCancelled; return $CANCEL }
      "" { break }
      default {
        if ($qbVersionList -notcontains $Version) {
          Write-Host "Invalid option `"${Version}`"" -ForegroundColor Red
          Start-Sleep -Milliseconds $TIME_BLINK
          break
        }
        else {
          Set-Version $Version
          return $Version 
        }
      }
    }

    $Version = $null
  }
}


function Get-WebClientHeaderContent {
  param($URL)
  
  $Error.Clear()
  $size_header = ((Invoke-WebRequest $URL -UseBasicParsing -Method Head).Headers.'Content-Length')
  $content = [math]::Round($size_header / $BYTE_TO_MEGABYTE)
  
  if ($Error) {
    Clear-Host
    Write-Host "`nFailure retrieving headers!`n" -BackgroundColor DarkRed -ForegroundColor White
    Write-Host "Year: ${ReleaseYear}"
    Write-Host "Version: ${Version}"
    Write-Host "Byte_Size: $size_header"
    Write-Host "MB_Size: ${content}MB"
    Write-InfoLink
    exit $PAUSE
  } else { return $content }
}

function Get-QuickBooksInstaller {
  # receives version from `Select-QuickBooksVersion`
  param ($Version, $Target = $pwd)

  if ($Version -eq $CANCEL) { return }

  Clear-Host
  Write-Host -NoNewLine "`nTesting connectivity... "

  if (Test-Connection www.google.com -Quiet) {
    Write-Host "OK`nPreparing to download..."

    $downloadspeed = (Get-SpeedTestResults)
    
    switch ($Version) {
      19 { $ReleaseYear = 2019 }
      18 { $ReleaseYear = 2018 }
      12 { $ReleaseYear = 2015 }
      11 { $ReleaseYear = 2013 }
    }
    
    Write-Host -NoNewLine "Querying download size... "
    $qbdownloadurl = "https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/${ReleaseYear}/Latest/QuickBooksPOSV${Version}.exe"
    $qbdownloadsize = Get-WebClientHeaderContent -URL $qbdownloadurl
    $TimeToComplete = Get-TimeToComplete ($qbdownloadsize / $downloadspeed)
    Write-Host "Done"

    Write-Host "Need to download ${qbdownloadsize}MB installer."
    $query = Read-Host "Do you want to continue? (Y/n)"
    switch ($query) {
      "n" {
        Write-OperationCancelled
        Select-QuickBooksVersion
        Get-QuickBooksInstaller -Version (Get-Version)
      }
      default {
        if ($Version -gt 12 -and $downloadspeed -le 2) {
          Write-Host "Download may take more than 5 minutes to complete`non your current system." -ForegroundColor Yellow
          $query = Read-Host "Are you ready to start the download? (Y/n)"
          if ($query -eq "n") {
            Write-OperationCancelled
            Select-QuickBooksVersion
            Get-QuickBooksInstaller -Version (Get-Version)
          }
        }

        Clear-Host
        Write-Host "`n Downloading ${qbdownloadsize}MB... " -ForegroundColor White -BackgroundColor DarkCyan
        Write-Host "`nDST: $Target`nETC: $TimeToComplete @ $downloadspeed MB/s" -ForegroundColor White
        Write-Host "`nEstimated time is calculated from the point that your`ninternet speed was tested. This is just an estimation and`nmay not reflect the actual time that it would take for the`ndownload to complete on your system. This is subject to`nchange as your internet speed fluctuates."
        Write-Host "`nPlease wait while the installer is being downloaded." -ForegroundColor Yellow
        Start-BitsTransfer $qbdownloadurl "$Target\QuickBooksPOSV${Version}.exe"
        Write-Host "`nDownload complete."
        Start-Sleep -Milliseconds $TIME_BLINK
      }
    }
  }
  else { Write-NoInternetConnectivity; exit $PAUSE }
}

function New-ActivationOnlyRequest {
  Clear-Host
  Write-Host "`nGenerating activation-only request..."
  Start-Sleep -Milliseconds $TIME_NORMAL
  Write-Host "Checking for installed QuickBooks software..."

  foreach ($path in $qbPathList) {
    if (Test-Path "${env:ProgramFiles(x86)}\$path\QBPOSShell.exe" -PathType Leaf) { Write-Host "Found `"$path`""; return }
  }

  # If nothing is found then the activation will not continue.
  Write-QuickBooksNotInstalled
  exit $PAUSE
}

function Invoke-QuickBooksInstaller {
  param([Switch]$Server)

  Clear-Host
  Write-Host "`nChecking for QuickBooks installer..."
  
  # Find which installer version is available and compare 
  # known hashes against the installer for verification
  
  foreach ($exe in $qbExeList) {
    if (Test-Path ".\$exe" -PathType Leaf) {
      Write-Host "Found `"$exe`"."
      
      # quickbooks version retrieved here in the even that
      # the user's installer is not recognized, but the user
      # still wants to invoke it
      $script:QB_VERSION = ($exe.Trim("QuickBooksPOSV.exe"))
      
      Write-Host -NoNewLine "Verifying `"$exe`"... "

      foreach ($hash in $qbHashList) {
        $result = (Compare-Hash -Hash $hash -File .\$exe)
        if ($result -eq $OK) {
          Write-Host "OK"
          if ($Server) { Get-IntuitLicense -Hash $hash -Server } 
          else { Get-IntuitLicense -Hash $hash } 
          break 
        }
      }
      
      # if hashes do not match at any in the list
      if ($result -eq $ERR) {
        Clear-Host
        Write-Host "`nFailed to verify the installer." -ForegroundColor White -BackgroundColor DarkRed
        Write-Host "`nThe installer `"$exe`" may be corrupted." -ForegroundColor Yellow
        Write-Host "`nThis may be a false positive in some cases. Please be sure`nthat you trust the installer if you choose to use it. If`nthe installer was downloaded with this activator, or from`nIntuit, you can trust it."

        $query = Read-Host "`nDo you trust this installer? (y/N)"
        switch ($query) {
          "y" { 
            Write-Host
            if ($Server) { Get-IntuitLicense -Version $QB_VERSION -Server }
            else { Get-IntuitLicense -Version $QB_VERSION }
            Start-Installer .\$exe >$null 2>&1
            Invoke-Activation
          }

          default {
            $query = Read-Host "Do you want to download an installer? (Y/n)"
            switch ($query) {
              "n" { Write-OperationCancelled; exit $ERR }
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

  Write-Host "QuickBooks installer was not found." -ForegroundColor Yellow
  Start-Sleep -Milliseconds $TIME_SLOW
  Write-NextOperationMenu
}

<# --- EXECUTION --- #>

function Start-Installer {
  param ($PosInstaller)
  
  Remove-Item $intuit_temp -Recurse -Force >$null 2>&1
  Write-WaitingScreen
  $Error.Clear() # reset to catch installer error, if any
  Start-Process -FilePath $PosInstaller -Wait

  if ($Error) { Write-CannotStartInstaller; exit $PAUSE }
  foreach ($path in $qbPathList) { if (Test-Path "${env:ProgramFiles(x86)}\$path\QBPOSShell.exe" -PathType Leaf) { Clear-Host; Write-Host; return } }
  
  Write-QuickBooksNotInstalled
  exit $PAUSE
}
