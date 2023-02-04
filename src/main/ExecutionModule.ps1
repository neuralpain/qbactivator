<#
ExecutionModule.ps1, Version 3.19
  Copyright (c) 2023, neuralpain
  qbactivator verification and execution
#>

$OK = 0x0
$ERR = 0x1
# $SKIP_START = 0x2
$PAUSE = 0x3
$CANCEL = 0x4

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
$qbExeList = @($QBPOS19, $QBPOS18, $QBPOS12, $QBPOS11)
$qbHashList = @($QBHASH19, $QBHASH18, $QBHASH12, $QBHASH11)
$qbPathList = @($QBPATH19, $QBPATH18, $QBPATH12, $QBPATH11)

function Compare-Hash {
  param ( $Hash, $File )
  if ((((Get-FileHash $File -Algorithm MD5 | Select-Object Hash) -split " "
      ).Trim("@{Hash=}")) -ne $Hash) { return $ERR } else { return $OK }
}

function Write-WaitingScreen {
  Clear-Host
  Write-Host "`n=== qbactivator ==="
  Write-Host "`nActivation script for QuickBooks POS."
  Write-Host "`nPlease ensure that the QuickBooks software is completely"
  Write-Host "installed before you continue. Continue when ready.`n"
  Pause
}

function Write-HelpLink {
  Write-Host "`nFor more information, visit:" -ForegroundColor White
  Write-Host "https://github.com/neuralpain/qbactivator" -ForegroundColor Green
}

function Write-NoInternetConnectivity {
  Clear-Host; Write-Host "`nUnable to start download." -ForegroundColor White -BackgroundColor DarkRed
  Write-Host "`nThere is no internet connectivity at this time." -ForegroundColor White
  Write-Host "Please check the connection and try again." -ForegroundColor White
  Write-HelpLink
}

function Write-OperationCancelled {
  Write-Host "---"
  Write-Host "Operation cancelled by user." -ForegroundColor Yellow
  Start-Sleep -Milliseconds 500
}

function Clear-IntuitData {
  # Delete Intuit junk files
  foreach ($path in $qbPathList) {
    if (Test-Path -Path ${env:ProgramFiles(x86)}\$path\QBPOSShell.exe -PathType Leaf) { 
      Clear-Host
      Write-Host "`nA version of QuickBooks is already installed." -ForegroundColor White -BackgroundColor DarkRed
      Write-Host "`nAll previous versions must be removed before installation." -ForegroundColor Yellow
      Write-Host "`nIf you are requesting activation-only, remove the installer from this location and restart the activator. The activator immediately checks for a QuickBooks installation executable and runs it if one is available." -ForegroundColor White
      Write-HelpLink
      exit $PAUSE
    }
  }

  Remove-Item -Path ${env:ProgramFiles(x86)}\Intuit\* -Recurse -Force >$null 2>&1
  Remove-Item -Path $env:ProgramData\Intuit\* -Recurse -Force >$null 2>&1
}

function Install-IntuitLicense {
  param ( $Hash )
  
  <#
    Compare the hash received against the known hashes of the current QB installers available.
    If the hashes match any of these, the appropriate license will be added for that version
    of QuickBooks.
  #>
  
  switch ($Hash) {
    $QBHASH11 {
      Clear-IntuitData
      if (-not(Test-Path -Path $env:ProgramData\$QBPATH11 -PathType Leaf)) { mkdir $env:ProgramData\$QBPATH11 >$null 2>&1 }
      Out-File -FilePath $env:ProgramData\$QBPATH11\qbregistration.dat -InputObject $QBREGV11 -Encoding UTF8 -NoNewline
    }
    
    $QBHASH12 {
      Clear-IntuitData
      if (-not(Test-Path -Path $env:ProgramData\$QBPATH12 -PathType Leaf)) { mkdir $env:ProgramData\$QBPATH12 >$null 2>&1 }
      Out-File -FilePath $env:ProgramData\$QBPATH12\qbregistration.dat -InputObject $QBREGV12 -Encoding UTF8 -NoNewline
    }
    
    $QBHASH18 {
      Clear-IntuitData
      if (-not(Test-Path -Path $env:ProgramData\$QBPATH18 -PathType Leaf)) { mkdir $env:ProgramData\$QBPATH18 >$null 2>&1 }
      Out-File -FilePath $env:ProgramData\$QBPATH18\qbregistration.dat -InputObject $QBREGV18 -Encoding UTF8 -NoNewline
    }
    
    $QBHASH19 {
      Clear-IntuitData
      if (-not(Test-Path -Path $env:ProgramData\$QBPATH19 -PathType Leaf)) { mkdir $env:ProgramData\$QBPATH19 >$null 2>&1 }
      Out-File -FilePath $env:ProgramData\$QBPATH19\qbregistration.dat -InputObject $QBREGV19 -Encoding UTF8 -NoNewline
    }
    
    <#
      If a hash was not provided for this function, the default case will assume an activation-only 
      request and begin searching for installed QuickBooks software on the current system.
    #>

    default {
      Clear-Host; Write-Host "`nChecking for installed QuickBooks software..."

      <#
        Intuit leaves some junk files after you uninstall QuickBooks so to accurately determine if an 
        installation exists without the registry, this block will search for the launch executable of
        QuickBooks which should be present on complete installations.
      #>

      foreach ($path in $qbPathList) {
        if (Test-Path -Path ${env:ProgramFiles(x86)}\$path\QBPOSShell.exe -PathType Leaf) { 
          Write-Host "Found `"$path`""
          Start-Sleep -Milliseconds 2000
          return $OK
        }
      }

      # If nothing is found then the activation will not continue.
      Clear-Host
      Write-Host "`nQuickBooks is not installed on the system."  -ForegroundColor White -BackgroundColor DarkRed
      Write-Host "`nPlease ensure that a QuickBooks software is completely `ninstalled before you continue." -ForegroundColor White
      Write-HelpLink
      exit $PAUSE
    }
  } return $OK
}

function Get-TimeToComplete {
  param ( $Time )

  if ($Time -gt 60) {
    $Time = $Time / 60
    $Time = [math]::Round($Time, 2)
    return "$Time minutes"
  }
  
  [int]$Time = $Time
  return "$Time seconds"
}

function Get-QuickBooksInstaller {
  param ( $Version, $Target = $pwd )

  if ($Version -eq $CANCEL) { return }

  $BYTE_CONVERT = 1048576
  $speedtestclifolder = "$env:APPDATA\Ookla\Speedtest CLI"
  $speedtestclilicense = "[Settings]`r`nLicenseAccepted=604ec27f828456331ebf441826292c49276bd3c1bee1a2f65a6452f505c4061c"
  $speedtestarchive = "https://github.com/neuralpain/qbactivator/files/10474537/ookla-speedtest-1.2.0-win64.zip"

  if (-not(Test-Path -Path "$speedtestclifolder\speedtest-cli.ini" -PathType Leaf)) {
    mkdir $speedtestclifolder >$null 2>&1
    [IO.File]::WriteAllLines("$speedtestclifolder\speedtest-cli.ini", $speedtestclilicense)
  }

  Clear-Host; Write-Host "`nTesting connection..."
  if (Test-Connection www.google.com -Quiet) {
    Write-Host "Connection established."
    Start-Sleep -Milliseconds 800
    Write-Host "Preparing to download..."
    Start-BitsTransfer $speedtestarchive "$Target\speedtest.zip"

    Add-Type -Assembly System.IO.Compression.FileSystem
    $_zip = [IO.Compression.ZipFile]::OpenRead("$pwd\speedtest.zip")
    [System.IO.Compression.ZipFileExtensions]::ExtractToFile((
        $_zip.Entries | where { $_.Name -eq "speedtest.exe" }), 
        "$pwd\speedtest.exe", $true)
    $_zip.Dispose()

    Remove-Item .\speedtest.zip
    
    Write-Host "Querying internet speed..."
    Start-Sleep -Milliseconds 1000
    Write-Host "This may take up to a minute based on your system." -ForegroundColor Yellow
    $downloadspeed = .\speedtest.exe --format json --progress no
    $downloadspeed = $downloadspeed -replace ".*download"
    $downloadspeed = $downloadspeed.Trim(':{"bandwidth":') -replace ",.*"
    $downloadspeed = [math]::Round($downloadspeed / $BYTE_CONVERT, 2)
    Remove-Item .\speedtest.exe

    switch ($Version) {
      19 { $ReleaseYear = 2019 }
      18 { $ReleaseYear = 2018 }
      12 { $ReleaseYear = 2015 }
      11 { $ReleaseYear = 2013 }
    }
    
    Write-Host "Querying download size..."
    $qbdownloadurl = "https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/${ReleaseYear}/Latest/QuickBooksPOSV${Version}.exe"
    $qbdownloadsize = ((Invoke-WebRequest $qbdownloadurl -UseBasicParsing -Method Head).Headers.'Content-Length')
    $qbdownloadsize = [math]::Round($qbdownloadsize / $BYTE_CONVERT)
    
    Write-Host "`nNeed to download ${qbdownloadsize}MB installer."
    $query = Read-Host "Do you want to continue? [Y/n]"
    
    switch ($query) {
      "n" {
        Write-OperationCancelled
        Get-QuickBooksInstaller -Version (Select-QuickBooksVersion)
      }
      default {
        Clear-Host; Write-Host "`nDownloading ${qbdownloadsize}MB to `n`"$Target`""
        $TimeToComplete = Get-TimeToComplete ($qbdownloadsize / $downloadspeed)
        Write-Host "Estimated $TimeToComplete to download @ $downloadspeed MB/s"
        Start-Sleep -Milliseconds 1000
        Write-Host "`nPlease wait while the installer is being downloaded..." -ForegroundColor Yellow
        Start-BitsTransfer $qbdownloadurl $Target\QuickBooksPOSV${Version}.exe
        Write-Host "Download complete." -ForegroundColor Green
      }
    }
  }
  else { Write-NoInternetConnectivity; exit $PAUSE }
}

function Select-QuickBooksVersion {
  $Version = $null

  while ($null -eq $Version) {
    Clear-Host; Write-Host "`nSelect QuickBooks POS verison to download"
    Write-Host "Only enter the version number" -ForegroundColor Yellow
    Write-Host "-----------------------------"
    Write-Host "11 - QuickBooks POS 2013"
    Write-Host "12 - QuickBooks POS 2015"
    Write-Host "18 - QuickBooks POS 2018"
    Write-Host "19 - QuickBooks POS 2019"
    Write-Host "0  - Cancel"
    $Version = Read-Host "`nVersion"

    switch ($Version) {
      0 { Write-OperationCancelled; return $CANCEL }
      Default {
        if ($Version.Length -eq 0) { $Version = $null }
        elseif ($qbVersionList -notcontains $Version) {
          Write-Host "Invalid option `"${Version}`"" -ForegroundColor Red
          Start-Sleep -Milliseconds 500
          $Version = $null
        }
      }
    }
  } return $Version
}

function Start-Installer {
  param ( $Path )
  Clear-Host; Write-Host "`nStarting installer..."
  Start-Process -FilePath $Path
}

function Invoke-QuickBooksInstaller {  
  Clear-Host; Write-Host "`nChecking for QuickBooks installer..."
  # Find which installer version is available and compare known hashes against the installer for verification
  foreach ($exe in $qbExeList) {
    if (Test-Path -Path .\$exe -PathType Leaf) {
      Write-Host "Found `"$exe`"." -ForegroundColor Green
      Start-Sleep -Milliseconds 500

      Clear-Host; Write-Host "`nVerifying `"$exe`"..."
      foreach ($hash in $qbHashList) {
        $result = (Compare-Hash -Hash $hash -File .\$exe)
        if ($result -eq $OK) {
          Write-Host "Installer is OK." -ForegroundColor Green
          Start-Sleep -Milliseconds 500
          Install-IntuitLicense -Hash $hash
          break
        }
      }
      
      if ($result -eq $ERR) {
        Clear-Host; Write-Host "`nVerification failed." -ForegroundColor White -BackgroundColor DarkRed
        Write-Host "`nThe installer `"$exe`" may be corrupted."
        $query = Read-Host "Do you trust this installer? [Y/n]"
        switch ($query) {
          "n" {
            Clear-Host; Write-Host "`nVerification failed." -ForegroundColor White -BackgroundColor DarkRed
            Write-Host "`nThe installer `"$exe`" may be corrupted."
            $query = Read-Host "Do you want to download an installer? [Y/n]"
            switch ($query) {
              "n" { exit $ERR }
              default {
                Get-QuickBooksInstaller -Version (Select-QuickBooksVersion)
                Invoke-QuickBooksInstaller
              }
            }
          }
          default {
            Start-Installer .\$exe
            if ($LASTEXITCODE -ne 0) { exit $ERR } 
            else { 
              Start-Sleep -Seconds 2
              Write-WaitingScreen
              Add-ClientModule
              return
            }
          }
        }
      }

      Start-Installer .\$exe
      Start-Sleep -Seconds 2
      Write-WaitingScreen
      Add-ClientModule
      return
    }
  }

  Write-Host "QuickBooks installer was not found." -ForegroundColor Yellow
  $query = Read-Host "Do you need to install QB POS? [Y/n]"

  switch ($query) {
    "n" { Write-OperationCancelled; return }
    default {
      Get-QuickBooksInstaller -Version (Select-QuickBooksVersion)
      Invoke-QuickBooksInstaller
    }
  }
}

function Get-ClientModule {
  Write-Host "Requesting client module..."
  Start-Sleep -Milliseconds 800
  Write-Host "Testing connection..."
  if (Test-Connection www.google.com -Quiet) {
    Write-Host "Connection established."
    Start-Sleep -Milliseconds 800
    Write-Host "Downloading..."
    Start-BitsTransfer $clientfilehost $CLIENT_MODULE
    Write-Host "Download complete." -ForegroundColor Green
  }
  else { Write-NoInternetConnectivity; exit $PAUSE }
}

function Find-GenuineClientModule {
  # Determine if the client module is present on the system. This is necessary for proper activation.
  if (-not(Test-Path $CLIENT_MODULE -PathType Leaf)) {
    Clear-Host
    Write-Host "`nClient module could not be located." -ForegroundColor White -BackgroundColor DarkRed
    Write-Host "`nThe activation cannot be completed." -ForegroundColor Yellow
    Write-Host "`nPlease ensure that a QuickBooks product is correctly and `ncompletely installed before requesting activation-only." -ForegroundColor White
    Write-HelpLink
    exit $PAUSE
  }
}

function Add-ClientModule {
  Clear-Host
  Write-Host "`nProceeding with activation..." 
  Start-Sleep -Milliseconds 800

  Write-Host "Terminating QB processes..."
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

  if (Test-Path -Path $CLIENT_MODULE -PathType Leaf) {
    Rename-Item $CLIENT_MODULE "${CLIENT_MODULE}.bak" >$null 2>&1  
    # Perform verification for file integrity on the patch file
    if (-not(Test-Path -Path $PATCHFILE -PathType Leaf)) { Get-ClientModule } 
    else { 
      $result = Compare-Hash -Hash $PATCH_HASH -File $PATCHFILE
      if ($result -ne $ERR) { Copy-Item $PATCHFILE $CLIENT_MODULE } 
      else { Get-ClientModule }
    } exit $OK
  }
  else {
    Clear-Host
    Write-Host "`nQuickBooks was not found on the system." -ForegroundColor White -BackgroundColor DarkRed
    Write-HelpLink
    exit $PAUSE
  }
}

# ---------------------------------- start powershell execution ---------------------------------- # 

Invoke-QuickBooksInstaller
# if installation is cancelled:
Clear-Host
Write-Host "`nAssuming activation-only request."

if ((Install-IntuitLicense) -eq $OK) {
  Find-GenuineClientModule # will exit if missing
  Add-ClientModule # inject modified client
}

exit