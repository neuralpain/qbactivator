function Show-WebRequestDownloadJobState {
  <#
  .SYNOPSIS
    Display a simple animation while waiting for a download job to complete.
  
  .DESCRIPTION
    Waits for a download job to complete, displaying a
    progress bar while it is running. When the download is complete, the
    function will write a completion message to the console.
  
  .PARAMETER DownloadJob
    The download job to wait for
    
  .PARAMETER Message
    The message to display while the download is in progress

  .EXAMPLE
    Show-WebRequestDownloadJobState -DownloadJob $DownloadJob -Message "Downloading from host"

    Waits for the download job to complete
  
  .EXAMPLE
    $Job = Start-Job -ScriptBlock { Invoke-WebRequest -Uri "https://www.gutenberg.org/cache/epub/1184/pg1184.txt" -OutFile "TheRoadNotTaken.txt" }
    Show-WebRequestDownloadJobState -DownloadJob $Job  -Message "Downloading from host"

    Waits for the download job to complete

  .EXAMPLE
    Start-Job -ScriptBlock {
      Invoke-WebRequest -Uri "https://www.gutenberg.org/cache/epub/1184/pg1184.txt" -OutFile "TheRoadNotTaken.txt"
    } | Show-WebRequestDownloadJobState -Message "Downloading from host"

    Waits for the download job to complete

  .NOTES
    Filename: Show-WebRequestDownloadJobState.ps1
    Version 1.2
    Author: neuralpain
    Created: 2024-03-16
    Updated: 2024-03-19

    Version history:
  
    1.0  -  Initial release with basic functionality
  
    1.1  -  Bug fixes
  
    1.2  -  Change text color
  #>
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    $DownloadJob,
    [Parameter(Mandatory = $true)]
    [String]$Message,
    [scriptblock]$CompleteScript,
    [scriptblock]$FailedScript,
    [scriptblock]$StoppedScript
  )
  
  $Padding = " " * ($Message.Length + 12)

  while ($DownloadJob.State -eq 'Running') {
    Write-Host -NoNewLine "`r[*....] $($Message)..." -ForegroundColor White
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`r[.*...] $($Message)..." -ForegroundColor White
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`r[..*..] $($Message)..." -ForegroundColor White
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`r[...*.] $($Message)..." -ForegroundColor White
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`r[....*] $($Message)..." -ForegroundColor White
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`r[.....] $($Message)..." -ForegroundColor White
    Start-Sleep -Milliseconds 100
  }

  # Clear the progress bar
  Write-Host -NoNewLine "`r${Padding}`r"
  
  # if the variable contains a script block, execute it
  switch ($DownloadJob.State) {
    'Completed' { 
      if ($CompleteScript -eq $null) { Write-Host ":: Download completed successfully.${Padding}" -ForegroundColor Green; break } 
      # if not, write a success message
      else { &$CompleteScript }
    }
    'Failed' { 
      if ($FailedScript -eq $null) { Write-Host ":: Failed to download from host.${Padding}" -ForegroundColor Red; break }
      # if not, write a failure message
      else { &$FailedScript }
    }
    'Stopped' { 
      if ($StoppedScript -eq $null) { Write-Host ":: Download was manually stopped.${Padding}" -ForegroundColor Red; break }
      # if not, write a failure message
      else { &$StoppedScript }
    }
  }
}
