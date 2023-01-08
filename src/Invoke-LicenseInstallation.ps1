<#
  Name: Invoke-LicenseInstallation.ps1
  Author: neuralpain
  Version: 3.12
  Description: qbactivator powershell verification and execution script
#>

$OK = 0    # GOOD
$ERR = 1   # BAD
$PAUSE = 3 # UGLY

# available installation executables
$QBPOSV11 = "QuickBooksPOSV11.exe" # POS v11 (2013)
$QBPOSV12 = "QuickBooksPOSV12.exe" # POS v12 (2015)
$QBPOSV18 = "QuickBooksPOSV18.exe" # POS v18 (2018)
$QBPOSV19 = "QuickBooksPOSV19.exe" # POS v19 (2019)
 
# hash values of installation executables
$QBHASH11 = "A1AF552A49ADFF40E6462A968DD552A4" # POS v11 (2013)
$QBHASH12 = "30FB99C5E98DF6874D438C478314EF9D" # POS v12 (2015)
$QBHASH18 = "DD45AA4EC0DF431243C9836816E2305A" # POS v18 (2018)
$QBHASH19 = "bd83235f86d879d2d67d05b978a6a316" # POS v19 (2019)

# hash value of patch file
$PATCH_HASH = "1A1816C78925E734FCA16974BDBAA4AA"

# directory locations for available POS software
$QBPATH11 = "Intuit\QuickBooks Point of Sale 11.0"
$QBPATH12 = "Intuit\QuickBooks Point of Sale 12.0"
$QBPATH18 = "Intuit\QuickBooks Desktop Point of Sale 18.0"
$QBPATH19 = "Intuit\QuickBooks Desktop Point of Sale 19.0"

$CLIENT_MODULE = "$env:SystemRoot\Microsoft.NET\assembly\GAC_MSIL\Intuit.Spc.Map.EntitlementClient.Common\v4.0_8.0.0.0__5dc4fe72edbcacf5\Intuit.Spc.Map.EntitlementClient.Common.dll"

$QBREGV11 = '<Registration InstallDate="" LicenseNumber="1063-0575-1585-222" ProductNumber="023-147"/>' # POS v11 (2013)
$QBREGV12 = '<Registration InstallDate="" LicenseNumber="6740-7656-8840-594" ProductNumber="448-229"/>' # POS v12 (2015)
$QBREGV18 = '<Registration InstallDate="" LicenseNumber="2421-4122-2213-596" ProductNumber="818-769"/>' # POS v18 (2018)
$QBREGV19 = '<Registration InstallDate="" LicenseNumber="0106-3903-4389-908" ProductNumber="595-828"/>' # POS v19 (2019)

# start list from most recent version first
$qbExeList = @($QBPOSV19,$QBPOSV18,$QBPOSV12,$QBPOSV11)
$qbHashList = @($QBHASH19,$QBHASH18,$QBHASH12,$QBHASH11)
$qbPathList = @($QBPATH19,$QBPATH18,$QBPATH12,$QBPATH11)

function Compare-Hash {
  param ( $Hash, $File )
  $_hash = Get-FileHash $File -Algorithm MD5 | Select-Object Hash
  $_hash = $_hash -split " "
  $_hash = $_hash.Trim("@{Hash=}")
  if ($_hash -ne $Hash) { return $ERR }
  else { return $OK }
}

function Write-HelpLink {
  Write-Host; Write-Host "For more information, visit:" -ForegroundColor White
  Write-Host "https://github.com/neuralpain/qbactivator" -ForegroundColor Green
}

function Clear-IntuitData {
  # Delete Intuit junk files
  foreach ($path in $qbPathList) {
    if (Test-Path -Path ${env:ProgramFiles(x86)}\$path\QBPOSShell.exe -PathType Leaf) { 
      Clear-Host
      Write-Host; Write-Host "ERROR: A version of QuickBooks is already installed." -ForegroundColor White -BackgroundColor DarkRed
      Write-Host; Write-Host "All previous versions must be removed before installation." -ForegroundColor Yellow
      Write-Host; Write-Host "If you are requesting activation-only, remove the installer from this location and restart the activator. The activator immediately checks for a QuickBooks installation executable and runs it if one is available." -ForegroundColor White
      Write-HelpLink
      exit $PAUSE
    }
  }

  Remove-Item -Path ${env:ProgramFiles(x86)}\Intuit\* -Recurse -Force >$null 2>&1
  Remove-Item -Path $env:ProgramData\Intuit\* -Recurse -Force >$null 2>&1
}

function Find-PatchFile {
  # Perform verification for file integrity on the patch file
  # If the patch file is unavailable, the script will not throw an error
  if (-not(Test-Path -Path .\qbpatch.dat -PathType Leaf)) {
    Clear-Host
    Write-Host; Write-Host "ERROR: Patch file not found." -ForegroundColor White -BackgroundColor DarkRed
    Write-Host; Write-Host "Redownload activator ZIP and try again." -ForegroundColor Yellow
    Write-HelpLink
    exit $PAUSE
  } else {
    $result = Compare-Hash -Hash $PATCH_HASH -File .\qbpatch.dat
    if ($result -eq $ERR) {
      Clear-Host
      Write-Host; Write-Host "ERROR: Patch file is corrupted." -ForegroundColor White -BackgroundColor DarkRed
      Write-Host; Write-Host "Redownload activator ZIP and try again." -ForegroundColor Yellow
      Write-HelpLink
      exit $PAUSE
    }
  }
}

function Find-ClientModule {
  # Determine if the client module is present on the system. This is necessary for proper activation.
  if (-not(Test-Path $CLIENT_MODULE -PathType Leaf)) {
    Clear-Host
    Write-Host; Write-Host "ERROR: Client module could not be located." -ForegroundColor White -BackgroundColor DarkRed
    Write-Host; Write-Host "The activation cannot be completed." -ForegroundColor Yellow
    Write-Host; Write-Host "Please ensure that a QuickBooks product is correctly and `ncompletely installed before requesting activation-only." -ForegroundColor White
    Write-HelpLink
    exit $PAUSE
  }
}

function Install-IntuitLicense {
  param( $Hash )
  
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
      return
    }
    
    $QBHASH12 {
      Clear-IntuitData
      if (-not(Test-Path -Path $env:ProgramData\$QBPATH12 -PathType Leaf)) { mkdir $env:ProgramData\$QBPATH12 >$null 2>&1 }
      Out-File -FilePath $env:ProgramData\$QBPATH12\qbregistration.dat -InputObject $QBREGV12 -Encoding UTF8 -NoNewline
      return
    }
    
    $QBHASH18 {
      Clear-IntuitData
      if (-not(Test-Path -Path $env:ProgramData\$QBPATH18 -PathType Leaf)) { mkdir $env:ProgramData\$QBPATH18 >$null 2>&1 }
      Out-File -FilePath $env:ProgramData\$QBPATH18\qbregistration.dat -InputObject $QBREGV18 -Encoding UTF8 -NoNewline
      return
    }
    
    $QBHASH19 {
      Clear-IntuitData
      if (-not(Test-Path -Path $env:ProgramData\$QBPATH19 -PathType Leaf)) { mkdir $env:ProgramData\$QBPATH19 >$null 2>&1 }
      Out-File -FilePath $env:ProgramData\$QBPATH19\qbregistration.dat -InputObject $QBREGV19 -Encoding UTF8 -NoNewline
      return
    }
    
    <#
      If a hash was not provided for this function, the default case will assume an activation-only 
      request and begin searching for installed QuickBooks software on the current system.
    #>

    default {
      Clear-Host; Write-Host
      Write-Host "Checking for installed QuickBooks software..."
      Start-Sleep -Seconds 1

      <#
        Intuit leaves some junk files after you uninstall QuickBooks so to accurately determine if an 
        installation exists without the registry, this block was designed to search for the main executable
        of QuickBooks which should be present on complete installations.
      #>

      foreach ($path in $qbPathList) {
        if (Test-Path -Path ${env:ProgramFiles(x86)}\$path\QBPOSShell.exe -PathType Leaf) { 
          Write-Host "Found `"$path`""
          Start-Sleep -Seconds 2
          return $OK
        }
      }

      # If nothing is found then the activation will not continue.
      Clear-Host
      Write-Host; Write-Host "ERROR: QuickBooks is not installed on the system."  -ForegroundColor White -BackgroundColor DarkRed
      Write-Host; Write-Host "Please ensure that a QuickBooks software is completely `ninstalled before you continue." -ForegroundColor White
      Write-HelpLink
      exit $PAUSE
    }
  }
}

function Invoke-QuickBooksInstaller {
  # Checks if the POS installer is available and perform verification for file integrity
  Clear-Host; Write-Host
  Write-Host "Checking for QuickBooks installer..."
  Start-Sleep -Seconds 1
  # Find which installer version is available and compare known hashes against the installer for verification
  foreach ($exe in $qbExeList) {
    if (Test-Path -Path .\$exe -PathType Leaf) {
      Write-Host "Found `"$exe`""
      Start-Sleep -Seconds 1
      Clear-Host; Write-Host
      Write-Host "Verifying installer..."
      Start-Sleep -Seconds 1
      # Compare known hashes against installer if the hash matches correctly, then add the appropriate license for that version of the software
      foreach ($hash in $qbHashList) {
        $result = (Compare-Hash -Hash $hash -File .\$exe)
        if ($result -eq $OK) { 
          Write-Host "Installer is OK." -ForegroundColor Green
          Start-Sleep -Seconds 1
          Install-IntuitLicense -Hash $hash
          Start-Sleep -Seconds 2
          break
        }
      }
      
      # if hashes do not match, the installer may be compromised will and exit with an error screen
      if ($result -eq $ERR) {
        Clear-Host; Write-Host
        Write-Host "ERROR: Installer is corrupted." -ForegroundColor White -BackgroundColor DarkRed
        Write-Host; Write-Host "Redownload installer and try again." -ForegroundColor Yellow
        Write-HelpLink
        exit $PAUSE
      }

      # start the installation
      Clear-Host; Write-Host
      Write-Host "Starting installer..."
      Start-Process -FilePath .\$exe
      Start-Sleep -Seconds 2; exit $OK
    }
  }
}

# ---------------------------------- start powershell execution ---------------------------------- # 

Find-PatchFile
Invoke-QuickBooksInstaller
Write-Host "QuickBooks installer was not found." -ForegroundColor Yellow
Start-Sleep -Seconds 1
Write-Host "Assuming activation-only request."
Start-Sleep -Seconds 2
$exitcode = (Install-IntuitLicense)
Find-ClientModule
Write-Host "Proceeding with activation..." -ForegroundColor Green
Start-Sleep -Seconds 2
exit $exitcode
