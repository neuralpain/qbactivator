$speedtestclifolder = "$env:APPDATA\Ookla\Speedtest CLI"
$speedtestclilicense = "[Settings]`r`nLicenseAccepted=604ec27f828456331ebf441826292c49276bd3c1bee1a2f65a6452f505c4061c"

if (-not(Test-Path -Path "$speedtestclifolder\speedtest-cli.ini" -PathType Leaf)) {
  mkdir $speedtestclifolder >$null 2>&1
  [IO.File]::WriteAllLines("$speedtestclifolder\speedtest-cli.ini",$speedtestclilicense)
}
