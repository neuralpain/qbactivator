function Show-WebRequestDownloadJobState {
  <#
  .SYNOPSIS
    Waits for an Invoke-WebRequest download job to complete
  
  .DESCRIPTION
    Waits for an Invoke-WebRequest download job to complete, displaying a
    progress bar while it is running. When the download is complete, the
    function will write a completion message to the console.
  
  .PARAMETER DownloadJob
    The Invoke-WebRequest download job to wait for

    Type: Invoke-WebRequest
    Parameter Sets: (All)
    Aliases:
    Dynamic: False
    
  .PARAMETER Message
    The message to display while the download is in progress

  .EXAMPLE
    PS C:\> Show-WebRequestDownloadJobState -DownloadJob $DownloadJob -Message "Downloading from host"

    Waits for the download job to complete
    
  .NOTES
    Version 1.0
    Author: neuralpain
    Date: 2024-03-16
  #>
  [CmdletBinding()]
  param(
    # The Invoke-WebRequest download job to wait for
    [Parameter(Mandatory = $true)]
    $DownloadJob,
    [Parameter(Mandatory = $true)]
    [String]$Message
  )
  
  while ($DownloadJob.State -eq 'Running') {
    Write-Host -NoNewLine "`r$($Message)*.. "
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`r$($Message).*. "
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`r$($Message)..* "
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`r$($Message)... "
    Start-Sleep -Milliseconds 100
  }
  
  switch ($DownloadJob.State) {
    'Completed' { Write-Host "`n:: Done" -ForegroundColor Green }
    'Failed' { Write-Host "`n:: Failed to download from host." -ForegroundColor Red; Pause }
    'Stopped' { Write-Host "`n:: Download was manually stopped." -ForegroundColor Red; Pause }
  }
}
