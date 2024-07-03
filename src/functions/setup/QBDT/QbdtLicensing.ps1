function Write-License-QBDT {
  # param([String]$LicenseNumber, [String]$ProductNumber, [String]$Version, [String]$ProductType)
  return '<?xml version="1.0"?><QBREG><QUICKBOOKSREGISTRATION><VERSION number="', $Script:SELECTED_QB_OBJECT.VerNum, '"><FLAVOR name="', $Script:SELECTED_QB_OBJECT.Flavor, '"><InstallNumber></InstallNumber><SerialNumber></SerialNumber><RegistrationNumber></RegistrationNumber><LA>YES</LA><InstallID>', $Script:SELECTED_QB_OBJECT.PNum, '</InstallID><LicenseNumber>', $Script:SELECTED_QB_OBJECT.LNum1, '</LicenseNumber><QBMode1></QBMode1><QBMode2></QBMode2><QBMode>0000f19c3276</QBMode><VersionNumber></VersionNumber><ActivatedProduct>', $Script:SELECTED_QB_OBJECT.Flavor,'</ActivatedProduct><PPRA></PPRA><NFVN></NFVN><NFEV></NFEV><NFLN></NFLN><NFID></NFID></FLAVOR></VERSION></QUICKBOOKSREGISTRATION></QBREG>' -join ''
}

function Get-IntuitLicense_QBDT {

}

function Install-IntuitLicense_QBDT {

}
