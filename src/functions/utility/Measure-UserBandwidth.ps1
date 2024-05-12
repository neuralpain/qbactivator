function Measure-UserBandwidth {  
  <#
  .SYNOPSIS
    Measures the user's Internet bandwidth.

  .DESCRIPTION
    Measures internet bandwidth using the Ookla Speedtest CLI, which is a command-line interface to the Speedtest.net website.
    The function will download the CLI from the internet if necessary.

  .PARAMETER Type
    Specifies the type of bandwidth to measure (Download or Upload).

  .PARAMETER Unit
    Specifies the unit of measurement for the bandwidth (Bytes or Bits).

  .EXAMPLE
    Measure-UserBandwidth -Type Download -Unit Bytes

    Measures the user's download bandwidth in Bytes.

  .EXAMPLE
    Measure-UserBandwidth -Type Upload -Unit Bits

    Measures the user's upload bandwidth in Bits.

  .NOTES
    The function will write to the console when running the speed test.

  .NOTES
    Unit Bytes is not accurate at the moment.

  .NOTES
    Version: 1.0
    Author: neuralpain
    Date: 2024-03-16
  #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [ValidateSet("Download", "Upload")]
    [String]$Type,
    [Parameter(Mandatory = $true)]
    [ValidateSet("Bits", "Bytes")]
    [String]$Unit
  )
    
  $SPEEDTEST_FOLDER = "$env:APPDATA\Ookla\Speedtest CLI"
  $SPEEDTEST_LICENSE = "$SPEEDTEST_FOLDER\speedtest-cli.ini"
  $SPEEDTEST_LICENSE_TEXT = "[Settings]`r`nLicenseAccepted=604ec27f828456331ebf441826292c49276bd3c1bee1a2f65a6452f505c4061c`r`nGDPRTimeStamp=1704516852" # utf8, noBOM
  $SPEEDTEST_CLI_URL = "https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip"
  
  if ($Type -eq "Upload") {
    Write-Host "Upload speed test unavailable."
    return 0
  }

  if (-not(Test-Path "$SPEEDTEST_LICENSE" -PathType Leaf)) {
    New-Item $SPEEDTEST_FOLDER -Type Directory >$null 2>&1
    [IO.File]::WriteAllLines($SPEEDTEST_LICENSE, $SPEEDTEST_LICENSE_TEXT)
  }

  if (-not(Test-Path "$env:TEMP\speedtest.exe")) {
    if (-not(Test-Path "$env:TEMP\speedtest.zip")) {
      Start-BitsTransfer $SPEEDTEST_CLI_URL "$env:TEMP\speedtest.zip"
    }

    Add-Type -Assembly System.IO.Compression.FileSystem

    $_zip = [IO.Compression.ZipFile]::OpenRead("$env:TEMP\speedtest.zip")
    
    [System.IO.Compression.ZipFileExtensions]::ExtractToFile((
        $_zip.Entries | Where-Object { $_.Name -eq "speedtest.exe" }
      ), "$env:TEMP\speedtest.exe", $true)

    $_zip.Dispose()
  }

  try {
    Write-Host "Testing internet speed... " -NoNewline
    
    # accept CLI usage license and General Data Protection Regulation (EU) before use
    Invoke-Expression "$env:TEMP\speedtest.exe --accept-gdpr --accept-license" >$null 2>&1

    switch ($Unit) {
      'Bits' { [int]$result = ((Invoke-Expression "$env:TEMP\speedtest.exe --accept-gdpr --accept-license --format json") -replace '.*"bandwidth":(\d+).*', '$1') }
      'Bytes' { [int]$result = ((Invoke-Expression "$env:TEMP\speedtest.exe --accept-gdpr --accept-license --format json") -replace '.*"bytes":(\d+).*', '$1') }
    }

    Write-Host "Done."
  }
  catch {
    Write-Host "`nSpeed test failed."
    return $null
  }
  
  return $result
}

function Convert-UserBandwidth {
  <#
  .SYNOPSIS
    Converts user bandwidth from one unit to another.

  .DESCRIPTION
    This function converts the specified input unit of user bandwidth to the specified output unit.
    Supported input and output units are:
      - Bytes to Mbps
      - Bits to Mbps

  .PARAMETER InputUnit
    The unit of input user bandwidth.
    Must be one of: "Bits", "Bytes"

  .PARAMETER Value
    The value of the input user bandwidth.

  .PARAMETER OutputUnit
    The unit of output user bandwidth.
    Optional. If not specified, the output unit is determined by the input unit.
    Must be one of: "Kilobits", "Kilobytes", "Megabits", "Megabytes", "Gigabits", "Gigabytes"

  .EXAMPLE
    Convert-UserBandwidth -InputUnit Bytes -Value 1000000

    Converts 1000000 Bytes to Mbps (1000 Mbps).

  .EXAMPLE
    Convert-UserBandwidth -InputUnit Bits -Value 8000000000 -OutputUnit Megabits

    Converts 8000000000 Bits to Megabits (8000 Mbps).

  .OUTPUTS
    The result of the conversion, in the specified output unit.
  
  .NOTES
    Version: 1.0
    Author: neuralpain
    Date: 2024-03-16
  #>
  [CmdletBinding()]
  [OutputType([int], [double])]
  param(
    [Parameter(Position = 0, Mandatory = $true)]
    [ValidateSet("Bits", "Bytes")]
    [String]$InputUnit,
    [Parameter(Mandatory = $true)]
    [int]$Value,
    [Parameter(Mandatory = $false)]
    [ValidateSet("Bits", "Bytes", "Kilobits", "Kilobytes", "Megabits", "Megabytes", 
      "Gigabits", "Gigabytes", "Terabits", "Terabytes", "Petabits", "Petabytes", 
      "Exabits", "Exabytes", "Zetabits", "Zetabytes", "Yottabits", "Yottabytes")]
    [String]$OutputUnit
  )
  
  switch ($InputUnit) {
    'Bits' {
      # Convert Bits to Bytes
      $bytes = [math]::Round(($Value / 8), 2)
      # Convert Bits to Mbps
      if (-not $PSBoundParameters.ContainsKey('OutputUnit')) {
        $OutputUnit = 'Megabits'
      }
      switch ($OutputUnit) {
        'Bytes' { $result = $bytes }
        'Kilobits' { $result = [math]::Round(($Value / [math]::Pow(10, 3)), 2) }
        'Kilobytes' { $result = [math]::Round(($Value / (8 * [math]::Pow(10, 3))), 2) }
        'Megabits' { $result = [math]::Round(($Value / [math]::Pow(10, 6)), 2) }
        'Megabytes' { $result = [math]::Round(($Value / (8 * [math]::Pow(10, 6))), 2) }
        'Gigabits' { $result = [math]::Round(($Value / [math]::Pow(10, 9)), 2) }
        'Gigabytes' { $result = [math]::Round(($Value / (8 * [math]::Pow(10, 9))), 2) }
        # Just in case someone needs something just a bit higher than the average peasant user
        'Terabits' { $result = [math]::Round(($Value / [math]::Pow(10, 12)), 2) }
        'Terabytes' { $result = [math]::Round(($Value / (8 * [math]::Pow(10, 12))), 2) }
        'Petabits' { $result = [math]::Round(($Value / [math]::Pow(10, 15)), 2) }
        'Petabytes' { $result = [math]::Round(($Value / (8 * [math]::Pow(10, 15))), 2) }
        # And for the rare edge case of an enthusiast somewhere who drank a bit too much coffee in the morning
        'Exabits' { $result = [math]::Round(($Value / [math]::Pow(10, 18)), 2) }
        'Exabytes' { $result = [math]::Round(($Value / (8 * [math]::Pow(10, 18))), 2) }
        'Zetabits' { $result = [math]::Round(($Value / [math]::Pow(10, 21)), 2) }
        'Zetabytes' { $result = [math]::Round(($Value / (8 * [math]::Pow(10, 21))), 2) }
        'Yottabits' { $result = [math]::Round(($Value / [math]::Pow(10, 24)), 2) }
        'Yottabytes' { $result = [math]::Round(($Value / (8 * [math]::Pow(10, 24))), 2) }
      }
    }
    'Bytes' {
      # Convert Bytes to Bits
      # Bytes need to be converted to bits and then converted to the output units of Kilobits, Megabits, Gigabits, etc.
      $bits = $Value * 8
      # Convert Bytes to Mbps
      if (-not $PSBoundParameters.ContainsKey('OutputUnit')) {
        $OutputUnit = 'Megabits'
      }
      switch ($OutputUnit) {
        'Bits' { $result = $bits }
        'Kilobits' { $result = [math]::Round(($bits / [math]::Pow(10, 3)), 2) }
        'Kilobytes' { $result = [math]::Round(($Value / 1024), 2) }
        'Megabits' { $result = [math]::Round(($bits / [math]::Pow(10, 6)), 2) }
        'Megabytes' { $result = [math]::Round(($Value / [math]::Pow(1024, 2)), 2) }
        'Gigabits' { $result = [math]::Round(($bits / [math]::Pow(10, 9)), 2) }
        'Gigabytes' { $result = [math]::Round(($Value / [math]::Pow(1024, 3)), 2) }
        # Just in case someone needs something just a bit higher than the average peasant user
        'Terabits' { $result = [math]::Round(($bits / [math]::Pow(10, 12)), 2) }
        'Terabytes' { $result = [math]::Round(($Value / [math]::Pow(1024, 4)), 2) }
        'Petabits' { $result = [math]::Round(($bits / [math]::Pow(10, 15)), 2) }
        'Petabytes' { $result = [math]::Round(($Value / [math]::Pow(1024, 5)), 2) }
        # And for the rare edge case of an enthusiast somewhere who drank a bit too much coffee in the morning
        'Exabits' { $result = [math]::Round(($bits / [math]::Pow(10, 18)), 2) }
        'Exabytes' { $result = [math]::Round(($Value / [math]::Pow(1024, 6)), 2) }
        'Zetabits' { $result = [math]::Round(($bits / [math]::Pow(10, 21)), 2) }
        'Zetabytes' { $result = [math]::Round(($Value / [math]::Pow(1024, 7)), 2) }
        'Yottabits' { $result = [math]::Round(($bits / [math]::Pow(10, 24)), 2) }
        'Yottabytes' { $result = [math]::Round(($Value / [math]::Pow(1024, 8)), 2) }
      }
    }
  }

  return $result
}
