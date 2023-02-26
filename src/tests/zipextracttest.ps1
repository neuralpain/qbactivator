# $speedtestarchive = "https://github.com/neuralpain/qbactivator/files/10474537/ookla-speedtest-1.2.0-win64.zip"
# Start-BitsTransfer $speedtestarchive ".\speedtest.zip"

Add-Type -Assembly System.IO.Compression.FileSystem
$zipFile = [IO.Compression.ZipFile]::OpenRead("$pwd\speedtest.zip")
[System.IO.Compression.ZipFileExtensions]::ExtractToFile(
  ($zipFile.Entries | where {$_.Name -eq "speedtest.exe"}),
  "$pwd\speedtest.exe", $true)
$zipFile.Dispose()
