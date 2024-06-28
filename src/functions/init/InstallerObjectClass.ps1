class Installer {
  [string] $ProductName         # quickbooks product name
  [System.Object] $Object       # POS Installer Object
  [string] $Url                 # download url
  [string] $Name                # name of installer
  [string] $Flavor              # flavor of quickbooks product, i.e., pro, bel, etc.
  [string] $VerNum              # POS version number, e.g. 11
  [string] $Year                # POS release year, e.g. 2013
  [string] $Hash                # installer hash value
  [string] $Path                # insatllation path
  [string] $LNum1               # license number #1
  [string] $LNum2               # license number #2, if available
  [string] $PNum                # product number
  [string] $Validation          # validation code
  [string] $PropertyCode        # property code
  [string] $ValidationMulti     # validation for 300 users
  [int]    $XBits               # installer bit size
  [int]    $XByte               # installer byte size
  [string] $Size                # installer megabyte size
}
