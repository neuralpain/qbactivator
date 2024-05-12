function Write-LieScolding {
  # from `Write-LieResponse`
  param($Mssg, [Switch]$ReadAKey)

  Clear-Terminal
  Write-Host "$Mssg" -ForegroundColor White -BackgroundColor DarkRed
  Write-InfoLink -NoExit

  if ($ReadAKey) { Read-Host }
  else { Start-Sleep -Milliseconds $TIME_SLOW }

  Write-Menu_Main
}

function Write-LieResponse {
  # from `Write-Menu_Main`
  Write-HeaderLabel
  Write-Host "Do you really have one?`n"
  Write-Host "1. No, I lied."
  Write-Host "2. I have a cat."
  Write-Host "3. I can't remeber it."
  Write-Host "4. My dog ate my license."
  Write-Host "5. Yes, I do."
  Write-Host "6. I just wanted to see what would happen."
  $query = Read-Host "`n#"
    
  switch ($query) {
    0 { break }
    1 { Write-LieScolding "Lying is bad." }
    2 { Write-LieScolding "Having a cat does not make you a good person." }
    3 { Write-LieScolding "It's likely you never will." }
    4 { Write-LieScolding "Ha ha... nice try." }
    5 { Get-UserOwnLicense }
    6 { Write-LieScolding "And now you've wasted both our time." -ReadAKey }
    default { Write-LieResponse }
  }
}
