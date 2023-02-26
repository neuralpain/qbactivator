<#
  ExecutionModule.ps1, Version 3.28
  Copyright (c) 2023, neuralpain
  qbactivator verification and execution
#>

$OK = 0x0
$ERR = 0x1
$NONE = 0x2
$PAUSE = 0x3
$CANCEL = 0x4

$TIME_BLINK = 500
$TIME_SHORT = 800
$TIME_NORMAL = 1000
$TIME_SLOW = 2000

$BYTE_TO_MEGABYTE = 1048576

$global:ProgressPreference = "SilentlyContinue"

$clientfilehost = "https://github.com/neuralpain/qbactivator/files/10475450/qb.patch"

$PATCHFILE = ".\qbpatch.dat"

$CLIENT_MODULE = "$env:SystemRoot\Microsoft.NET\assembly\GAC_MSIL\Intuit.Spc.Map.EntitlementClient.Common\v4.0_8.0.0.0__5dc4fe72edbcacf5\Intuit.Spc.Map.EntitlementClient.Common.dll"

$QBPOS11 = "QuickBooksPOSV11.exe"
$QBPOS12 = "QuickBooksPOSV12.exe"
$QBPOS18 = "QuickBooksPOSV18.exe"
$QBPOS19 = "QuickBooksPOSV19.exe"

$QBHASH11 = "A1AF552A49ADFF40E6462A968DD552A4"
$QBHASH12 = "30FB99C5E98DF6874D438C478314EF9D"
$QBHASH18 = "DD45AA4EC0DF431243C9836816E2305A"
$QBHASH19 = "F5C434677270319F9A515210CA916187"

$PATCH_HASH = "1A1816C78925E734FCA16974BDBAA4AA"

$QBPATH11 = "Intuit\QuickBooks Point of Sale 11.0"
$QBPATH12 = "Intuit\QuickBooks Point of Sale 12.0"
$QBPATH18 = "Intuit\QuickBooks Desktop Point of Sale 18.0"
$QBPATH19 = "Intuit\QuickBooks Desktop Point of Sale 19.0"

$QBREGV11 = '<Registration InstallDate="" LicenseNumber="1063-0575-1585-222" ProductNumber="023-147"/>'
$QBREGV12 = '<Registration InstallDate="" LicenseNumber="6740-7656-8840-594" ProductNumber="448-229"/>'
$QBREGV18 = '<Registration InstallDate="" LicenseNumber="2421-4122-2213-596" ProductNumber="818-769"/>'
$QBREGV19 = '<Registration InstallDate="" LicenseNumber="0106-3903-4389-908" ProductNumber="595-828"/>'

# start list from most recent version first
$qbVersionList = 19, 18, 12, 11
$qbExeList = $QBPOS19, $QBPOS18, $QBPOS12, $QBPOS11
$qbHashList = $QBHASH19, $QBHASH18, $QBHASH12, $QBHASH11
$qbPathList = $QBPATH19, $QBPATH18, $QBPATH12, $QBPATH11

function Compare-Hash {
  param ($Hash, $File)
  if ((((Get-FileHash $File -Algorithm MD5 | Select-Object Hash) -split " "
  ).Trim("@{Hash=}")) -ne $Hash) { return $ERR } else { return $OK }
}

<# --- WRITE-INFO --- #>

function Write-CannotStartInstaller {
  Clear-Host
  Write-Host "`nUnable to execute the installer." -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nPlease ensure that you are using a genuine installer`ndownloaded from Intuit." -ForegroundColor White
  Write-InfoLink
}

function Write-HeaderLabel {
  param ([string]$Mssg)
  if (-not($Mssg -eq "")) { $Mssg = "| $Mssg " }
  Write-Host "`n qbactivator $Mssg" -ForegroundColor White -BackgroundColor DarkGreen
}  

function Write-InfoLink {
  Write-Host "`nFor more information, visit:" -ForegroundColor White
  Write-Host "https://github.com/neuralpain/qbactivator" -ForegroundColor Green
}      

function Write-InstallerNextOperationMenu {
  Clear-Host
  Write-HeaderLabel
  Write-Host "`nSelect next operation"
  Write-Host "---------------------"
  Write-Host "1 - Request software activation"
  Write-Host "2 - Download and install QuickBooks POS"
  Write-Host "3 - Locate installer"
  Write-Host "0 - Cancel"
  $query = Read-Host "`n#"
  
  switch ($query) {
    0 { Write-OperationCancelled; exit $NONE }
    1 { Invoke-MainActivation (New-ActivationOnlyRequest) }
    2 { Get-QuickBooksInstaller -Version (Select-QuickBooksVersion); break }
    3 { break }
    default { Write-InstallerNextOperationMenu }
  }   
  
  Invoke-QuickBooksInstaller
}  

function Write-VersionSelectionMenu {
  Clear-Host
  Write-HeaderLabel
  Write-Host "`nSelect QuickBooks POS verison"
  Write-Host "Only enter the version number" -ForegroundColor Yellow
  Write-Host "-----------------------------"
  Write-Host "v11 - QuickBooks POS 2013"
  Write-Host "v12 - QuickBooks POS 2015"
  Write-Host "v18 - QuickBooks POS 2018"
  Write-Host "v19 - QuickBooks POS 2019"
  Write-Host "0 --- Cancel"
}  

function Write-NoInternetConnectivity {
  Clear-Host
  Write-Host "`nUnable to start the download." -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nThere is no internet connectivity at this time." -ForegroundColor White
  Write-Host "Please check the connection and try again." -ForegroundColor White
  Write-InfoLink
}  

function Write-QuickBooksIsInstalled {
  Clear-Host
  Write-Host "`nA version of QuickBooks is already installed." -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nAll previous versions must be removed before installation." -ForegroundColor Yellow
  Write-Host "`nIf you are requesting activation-only, remove the installer`nfrom this location and restart the activator. The activator`nimmediately checks for a QuickBooks installation executable`nand runs it if one is available." -ForegroundColor White
  Write-InfoLink
}  

function Write-QuickBooksNotInstalled {
  Clear-Host
  Write-Host "`nQuickBooks is not installed on the system." -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nThe activation cannot be completed." -ForegroundColor Yellow
  Write-Host "`nPlease ensure that a QuickBooks product is correctly and`ncompletely installed before requesting activation." -ForegroundColor White
  Write-InfoLink
}    

function Write-OperationCancelled {
  Write-Host "---"
  Write-Host -NoNewline "Operation cancelled by user." -ForegroundColor Yellow
  Start-Sleep -Milliseconds $TIME_BLINK
}

function Write-WaitingScreen {
  Clear-Host; Write-HeaderLabel
  Write-Host "`nQuickBooks software installation in progress..." -ForegroundColor White
  Write-Host "`nPlease ensure that the QuickBooks software is completely`ninstalled on your system. Activation will proceed after`nthe installation is completed."
  Write-Host "`nIf you need to cancel the installation for any reason,`nplease close this window afterwards." -ForegroundColor Cyan
  Write-InfoLink
}

<# --- CORE FN --- #>

function Clear-IntuitData {
  # Delete Intuit junk files
  foreach ($path in $qbPathList) {
    if (Test-Path -Path ${env:ProgramFiles(x86)}\$path\QBPOSShell.exe -PathType Leaf) { 
      Write-QuickBooksIsInstalled
      exit $PAUSE
    }
  }
  
  Write-Host -NoNewLine "Removing junk files... "
  Remove-Item -Path ${env:ProgramFiles(x86)}\Intuit\* -Recurse -Force >$null 2>&1
  Remove-Item -Path $env:ProgramData\Intuit\* -Recurse -Force >$null 2>&1
  Write-Host "Done"
}

function Get-TimeToComplete {
  param ($Time)

  if ($Time -gt 60) {
    $Time = $Time / 60
    $Time = [math]::Round($Time, 2)
    return "$Time minutes"
  }
  
  [int]$Time = $Time
  return "$Time seconds"
}

function Get-SpeedTestResults {
  $speedtestfolder = "$env:APPDATA\Ookla\Speedtest CLI"
  $speedtestlicensefile = "$env:APPDATA\Ookla\Speedtest CLI\speedtest-cli.ini"
  $speedtestlicensetext = "[Settings]`r`nLicenseAccepted=604ec27f828456331ebf441826292c49276bd3c1bee1a2f65a6452f505c4061c"
  $speedtestarchive = "https://github.com/neuralpain/qbactivator/files/10474537/ookla-speedtest-1.2.0-win64.zip"

  if (-not(Test-Path -Path "$speedtestlicensefile" -PathType Leaf)) {
    mkdir $speedtestfolder >$null 2>&1
    [IO.File]::WriteAllLines("$speedtestlicensefile", $speedtestlicensetext)
  }
  
  Start-BitsTransfer $speedtestarchive "$env:TEMP\speedtest.zip"

  Add-Type -Assembly System.IO.Compression.FileSystem
  $_zip = [IO.Compression.ZipFile]::OpenRead("$env:TEMP\speedtest.zip")
  [System.IO.Compression.ZipFileExtensions]::ExtractToFile((
      $_zip.Entries | where { $_.Name -eq "speedtest.exe" }
    ), "$env:TEMP\speedtest.exe", $true)
  $_zip.Dispose()

  Remove-Item $env:TEMP\speedtest.zip
  
  Write-Host "Querying internet speed..."
  Write-Host "This may take up to a minute based on your system." -ForegroundColor Yellow
  
  $speedtestresult = [math]::Round((((Invoke-Expression "$env:TEMP\speedtest.exe --format json --progress no"
        ) -replace ".*download").Trim(':{"bandwidth":') -replace ",.*") / $BYTE_TO_MEGABYTE, 2)

  Remove-Item $env:TEMP\speedtest.exe

  return $speedtestresult
}

function Get-IntuitLicense {
  param ($Hash, $Version)

  Clear-IntuitData
  
  switch ($Hash) {
    $QBHASH19 { $Version = 19 }
    $QBHASH18 { $Version = 18 }
    $QBHASH12 { $Version = 12 }
    $QBHASH11 { $Version = 11 }
  }

  Install-IntuitLicense -Version $Version
  return
}

function Get-QuickBooksInstaller {
  param ($Version, $Target = $pwd)

  if ($Version -eq $CANCEL) { return }

  Clear-Host
  Write-Host -NoNewLine "`nTesting connectivity... "

  if (Test-Connection www.google.com -Quiet) {
    Write-Host "OK"
    Write-Host "Preparing to download..."

    $downloadspeed = (Get-SpeedTestResults)
    
    switch ($Version) {
      19 { $ReleaseYear = 2019 }
      18 { $ReleaseYear = 2018 }
      12 { $ReleaseYear = 2015 }
      11 { $ReleaseYear = 2013 }
    }
    
    Write-Host -NoNewLine "Querying download size... "
    $qbdownloadurl = "https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/${ReleaseYear}/Latest/QuickBooksPOSV${Version}.exe"
    $qbdownloadsize = [math]::Round(((Invoke-WebRequest $qbdownloadurl -UseBasicParsing -Method Head).Headers.'Content-Length') / $BYTE_TO_MEGABYTE)
    $TimeToComplete = Get-TimeToComplete ($qbdownloadsize / $downloadspeed)
    Write-Host "Done"

    Write-Host "Need to download ${qbdownloadsize}MB installer."
    $query = Read-Host "Do you want to continue? (Y/n)"
    switch ($query) {
      "n" {
        Write-OperationCancelled
        Get-QuickBooksInstaller -Version (Select-QuickBooksVersion)
      }
      default {
        if ($Version -gt 12 -and $downloadspeed -le 2) {
          Write-Host "Download may take more than 5 minutes to complete`non your current system." -ForegroundColor Yellow
          $query = Read-Host "Are you ready to start the download? (Y/n)"
          if ($query -eq "n") {
            Write-OperationCancelled
            Get-QuickBooksInstaller -Version (Select-QuickBooksVersion)
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
  } else { Write-NoInternetConnectivity; exit $PAUSE }
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
        } else { return $Version }
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
    if (Test-Path -Path ${env:ProgramFiles(x86)}\$path\QBPOSShell.exe -PathType Leaf) {
      Write-Host "Found `"$path`""
      return $OK
    }
  }

  # If nothing is found then the activation will not continue.
  Write-QuickBooksNotInstalled
  exit $PAUSE
}

function Install-IntuitLicense {
  param ($Version)
  
  Write-Host -NoNewLine "Installing registration keys... "
  
  switch ($Version) {
    19 {
      if (-not(Test-Path -Path $env:ProgramData\$QBPATH19 -PathType Leaf)) { mkdir $env:ProgramData\$QBPATH19 >$null 2>&1 }
      Out-File -FilePath $env:ProgramData\$QBPATH19\qbregistration.dat -InputObject $QBREGV19 -Encoding UTF8 -NoNewline
    }
    
    18 {
      if (-not(Test-Path -Path $env:ProgramData\$QBPATH18 -PathType Leaf)) { mkdir $env:ProgramData\$QBPATH18 >$null 2>&1 }
      Out-File -FilePath $env:ProgramData\$QBPATH18\qbregistration.dat -InputObject $QBREGV18 -Encoding UTF8 -NoNewline
    }
    
    12 {
      if (-not(Test-Path -Path $env:ProgramData\$QBPATH12 -PathType Leaf)) { mkdir $env:ProgramData\$QBPATH12 >$null 2>&1 }
      Out-File -FilePath $env:ProgramData\$QBPATH12\qbregistration.dat -InputObject $QBREGV12 -Encoding UTF8 -NoNewline
    }

    11 {
      if (-not(Test-Path -Path $env:ProgramData\$QBPATH11 -PathType Leaf)) { mkdir $env:ProgramData\$QBPATH11 >$null 2>&1 }
      Out-File -FilePath $env:ProgramData\$QBPATH11\qbregistration.dat -InputObject $QBREGV11 -Encoding UTF8 -NoNewline
    }
  }

  Write-Host "Done"
}

function Invoke-QuickBooksInstaller {
  Clear-Host
  Write-Host "`nChecking for QuickBooks installer..."
  
  # Find which installer version is available and compare 
  # known hashes against the installer for verification
  
  foreach ($exe in $qbExeList) {
    if (Test-Path -Path .\$exe -PathType Leaf) {
      Write-Host "Found `"$exe`"."
      Write-Host -NoNewLine "Verifying `"$exe`"... "

      foreach ($hash in $qbHashList) {
        $result = (Compare-Hash -Hash $hash -File .\$exe)
        if ($result -eq $OK) {
          Write-Host "OK"
          Get-IntuitLicense -Hash $hash
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
            Get-IntuitLicense -Version ($exe.Trim("QuickBooksPOSV.exe"))
            Start-Installer .\$exe >$null 2>&1 
            Invoke-MainActivation
          }

          default {
            $query = Read-Host "Do you want to download an installer? (Y/n)"
            switch ($query) {
              "n" { Write-OperationCancelled; exit $ERR }
              default {
                Get-QuickBooksInstaller -Version (Select-QuickBooksVersion)
                Invoke-QuickBooksInstaller
              }
            }
          }
        }
      }
      
      Start-Installer .\$exe
      Invoke-MainActivation
    }
  }

  Write-Host "QuickBooks installer was not found." -ForegroundColor Yellow
  Start-Sleep -Milliseconds $TIME_SLOW
  Write-InstallerNextOperationMenu
}

<# --- CLIENT MODULE FUNCTIONS --- #>

function Get-ClientModule {
  Write-Host "Requesting client module..."
  Write-Host -NoNewline "Testing connectivity... "

  if (Test-Connection www.google.com -Quiet) {
    Write-Host "OK"
    Write-Host -NoNewLine "Downloading... "
    Start-BitsTransfer $clientfilehost $CLIENT_MODULE
    Write-Host "Done"
  } else { Write-NoInternetConnectivity; exit $PAUSE }
}

function Find-GenuineClientModule {
  # Determine if the client module is present on the system. This is necessary for proper activation.
  if (-not(Test-Path $CLIENT_MODULE -PathType Leaf)) {
    Write-QuickBooksNotInstalled
    exit $PAUSE
  }
}

function Repair-GenuineClientModule {
  if (Test-Path -Path "${CLIENT_MODULE}.bak" -PathType Leaf) {
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

function Add-ClientModule {
  Write-Host -NoNewLine "Patching client module... "
  
  Rename-Item $CLIENT_MODULE "${CLIENT_MODULE}.bak" >$null 2>&1

  if (Test-Path -Path $PATCHFILE -PathType Leaf) {
    # Perform verification for file integrity on the patch file if present
    $result = Compare-Hash -Hash $PATCH_HASH -File $PATCHFILE
    if ($result -ne $ERR) { Copy-Item $PATCHFILE $CLIENT_MODULE } 
    else { 
      Write-Host "`nPatch file may be corrupted."
      Get-ClientModule
      Write-Host "Patch successful."
      return
    }
  } else { 
    Write-Host "`nLocal patch file not found."  
    Get-ClientModule
    Write-Host "Patch successful."
    return
  }

  Write-Host "Done"
}

<# --- EXECUTION --- #>

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
  Write-Host "Done"
}

function Start-Installer {
  param ($Executable)
  
  Remove-Item "$env:TEMP\Intuit" -Recurse -Force >$null 2>&1
  Write-WaitingScreen
  $Error.Clear() # reset to catch installer error, if any
  Start-Process -FilePath $Executable -Wait

  if ($Error) {
    Write-CannotStartInstaller 
    exit $PAUSE
  }

  foreach ($path in $qbPathList) {
    if (Test-Path -Path ${env:ProgramFiles(x86)}\$path\QBPOSShell.exe -PathType Leaf) { 
      Clear-Host; Write-Host; return
    }
  }

  Write-QuickBooksNotInstalled
  exit $PAUSE
}

function Invoke-MainActivation {
  param ($ActivationRequest)
  
  Stop-QuickBooksProcesses
  Repair-GenuineClientModule # if damaged
  Find-GenuineClientModule # will exit if missing
  Add-ClientModule # inject modified client
  
  Write-Host "Proceeding with activation..." 
  Start-Sleep -Milliseconds $TIME_SLOW
  exit $OK
}

# ---------------------------------- start powershell execution ---------------------------------- #

Invoke-QuickBooksInstaller
exit
