function Start-Installer {
  param ($Executable)
  Write-Host "Starting installer..."
  Remove-Item "$env:TEMP\Intuit" -Recurse -Force >$null 2>&1
  Start-Process -FilePath $Executable
  Write-WaitingScreen
  Wait-Process ($Executable.Trim(".\exe"))
}

Start-Installer ".\QuickBooksPOSV11.exe"