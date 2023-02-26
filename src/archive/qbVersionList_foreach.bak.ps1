foreach ($item in $qbVersionList) {
  if ($Version -ne $item) { 
    $loopcount += 1
    continue
  } else { break }
}

if ($loopcount -eq $qbVersionList.Count) { 
  Write-Host "Invalid option `"${Version}`"" -ForegroundColor Red
  Start-Sleep -Milliseconds 500
  $loopcount = 0
  $Version = $null 
}
