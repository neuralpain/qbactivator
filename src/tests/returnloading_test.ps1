for ($a=0; $a -le 100; $a++) {
  Write-Host -NoNewLine "`r$a% complete"
  Start-Sleep -Milliseconds 10
}