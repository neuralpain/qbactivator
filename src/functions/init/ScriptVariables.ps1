$OK = 0x0000
$ERR = 0x0001
$EXIT_QBA = 0x0002 # no action; complete exit
$PAUSE = 0x0003

$TIME_BLINK = 500
$TIME_SHORT = 800
$TIME_NORMAL = 1000
$TIME_SLOW = 2000

<# unused but kept for reference
enum QbaStatus {
  SUCCESS
  FAILURE
  NONE
  PAUSED
  CANCELLED
  INVALID
  BAD_HASH
  BAD_LICENSE
  BAD_VERIFICATION
  OPTION_UNAVAILABLE 
  QUICKBOOKS_NOT_INSTALLED
}
#>

# THIS! ...because Enums in PowerShell don't work how I want them to
$PROC_INSTALL = 0x208a
$PROC_ACTIVATE = 0x208b
$PROC_WRITE_LIES = 0x208c
$PROC_LICENSE = 0x208d
$PROC_TROUBLESHOOT = 0x208e
$PROC_EXIT = 0x208f
$PROC_EMPTY = 0x2090
$PROC_COMPLETE_EXIT = 0x2091
$PROC_NEXT_STAGE = 0x2092
$PROC_DOWNLOAD = 0x2093
$PROC_RETURN_MAIN = 0x2094

# MISCELLANEOUS
$Script:LICENSE_KEY = ""                          # quickbooks license key
$Script:QB_VERSION = $null                        # version of quickbooks (to be) installed
$Script:SELECTED_QB_OBJECT = $null               # quickbooks object selected to be installed
$Script:TARGET_LOCATION = "$pwd"                  # directory where files will be downloaded
$Script:RUN_NEXT_PROCEDURE = $null                # WAS UNUSED, FOUND A USE FOR IT; contains the next step to be run
$Script:ACTIVATION_ONLY = $false                  # indicate whether or not the script should only activate quickbooks

# IF QUICKBOOKS IS INSTALLED
[bool]$Script:QUICKBOOKS_IS_INSTALLED = $false    # indicate whether or not quickbooks is installed
$Script:QUICKBOOKS_INSTALLED_PATH = $null         # path where quickbooks is installed
$Script:QUICKBOOKS_INSTALLED_VERSION = $null      # version of quickbooks installed
$Script:QUICKBOOKS_INSTALL_ONLY = $false          # indicate whether or not the script should only install quickbooks

# INSTALLER RELATED
$Script:INSTALLER_SIZE = 0                        # size of installer
[int]$Script:INSTALLER_BITS = 0                   # bit size of installer
[int]$Script:INSTALLER_BYTES = 0                  # byte size of installer
$Script:INSTALLER_OBJECT = $null                  # the installer, the `.exe` object
$Script:INSTALLER_PATH = $null                    # path to the installer
$Script:INSTALLER_HASH = $null                    # hash of the installer
$Script:INSTALLER_IS_VALID = $false               # indicate whether or not the installer is valid for use
[bool]$Script:INSTALLER_AVAILABLE = $false        # indicate whether or not the installer is available on the user's system
[bool]$Script:INSTALLER_DOWNLOAD_ONLY = $false    # indicate whether or not the script should only download the installer

# BANDWIDTH RELATED
[int]$Script:BANDWIDTH_BITS = 0                   # bit size of bandwidth
[int]$Script:RAW_DOWNLOAD_TIME = 0                # raw download time
[int]$Script:BANDWIDTH_BYTES = 0                  # byte size of bandwidth
# [bool]$Script:DOWNLOAD_PATCH = $false           # UNUSED
[bool]$Script:BANDWIDTH_UNKNOWN = $true           # indicate whether or not bandwidth is unknown; bandwidth text successful or failed
[double]$Script:BANDWIDTH = 0                     # bandwidth size

# STORE RELATED
[bool]$Script:SECOND_STORE = $false               # indicate whether or not there is a second store
[bool]$Script:CUSTOM_LICENSING = $false           # indicate whether or not the user added a custom license
[bool]$Script:ADDITIONAL_CLIENTS = $false         # indicate whether or not the user wants to activate additional clients

# download and security level preferences
$global:ProgressPreference = "SilentlyContinue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
