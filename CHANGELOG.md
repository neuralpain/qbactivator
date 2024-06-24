# Changelog

## v0.24.0

- Fix critical bug affecting additional Client licenses
- Add Toast notifications
- TLS security improvements
- Bug fixes and improvements

#### v0.23.0

- Add manual refresh option to update menu head information
- Fix issue [#43](https://github.com/neuralpain/qbactivator/issues/43) where `qba-22` ignored local available POS installers
- Minor improvements

#### v0.22.0

- Add new Troubleshooting menu
- Add option `Lv3` in troubleshooting to potentially fix "Invalid Product Code" error
- Add 16 more licenses for each version of POS, a total of 64 new licenses; available for client activation
- Add links to qbactivator wiki, etc. in Troubleshooting Menu
- Add indicators for installation & activation status
- Fix instructions not being exported before activation
- Fix edge-case loop error scenario when refusing to proceed to download an installer
- Enabled transcript log to trace errors encountered during the runtime of the activator
- Disabled bandwidth calculation
<!-- - Fix internet bandwidth calculation with updated `Measure-UserBandwidth` utility -->
- Code refactoring, minor bug fixes and improvements

#### v0.21.2

- Fix validation bug on local patch files
- Fix bug preventing launch of QuickBooks POS application after installation
- Minor bug fixes

#### v0.21.1

- Fix licensing issues for POS v19 ([#30](https://github.com/neuralpain/qbactivator/issues/30)) and custom licenses ([#31](https://github.com/neuralpain/qbactivator/issues/31))
- Code refactoring

#### v0.21.0

- Add progress bar for Point of Sale installer while downloading ✨
- Add option to install custom licenses from the user
- Add preventative measure for users who manually run qbactivator as administrator
- Temporarily drop support for activation of other QuickBooks Desktop products
- Code refactoring
- Minor bug fixes

#### v0.20.3

- Minor bug fix in deleting items from `C:\ProgramData\Intuit`

#### v0.20.2

- Fix error requesting network information
- Add support for multi-store licensing with help from @Navish360 (removed split store-client licenses)
- Other bug fixes and improvements

#### v0.20.1

- Add licenses for server and client workstations
- Bug fixes and improvements

#### v0.20.0

- Fix error fetching headers from the web on certain Windows installations 
- Now deletes specific Point of Sale installation folder instead of entire Intuit directory
- Bug fixes and improvements

#### v0.19.0

- Previous client errors are fixed during activation request
- Add menu to download POS software if unavailable locally
- Add bypass for installer verification if user trusts their own installer
- Add automatic download of patch if unavailable or an error occurred with local copy
- Removed 4 steps from instructions
- Code optimization and error handling improvements

#### v0.18.1

- Fix POS v19 installer being recognized as corrupted when downloaded from official server ([#6](https://github.com/neuralpain/qbactivator/issues/6))
- Update build script with archive functionality (requires zip to be installed)

#### v0.18.0

- Fix non-verification of installed QuickBooks software for activation-only requests ([#4](https://github.com/neuralpain/qbactivator/issues/4))
- Improved error screens to provide helpful information
- Update hash values from SHA1 to MD5 for faster verification
- Add function `Clear-IntuitData` for clean up of leftover files from previous installation of QuickBooks after uninstall
- Add function `Install-IntuitLicense` for proper licensing and improved error checking
- Add function `Invoke-QuickBooksInstaller` to perform file integrity check and run the available installer while also checking for conflicts before installation
- Add function `Find-PatchFile` to contain patch file verification
- Modified `Compare-Hash` function to work with new changes
- Code optimization and improvements

#### v0.17.1

- Update license keys for POS v11 and v12

#### v0.17.0

- Implement a more robust method of activation ([#1](https://github.com/neuralpain/qbactivator/issues/1))
- Add automatic run of qb installer
- Minor bug fixes and improvements

#### v0.16.1

- Minor bug fixes and improvements

#### v0.16.0

- Add UAC prompt before script is run
- Embed instructions and keys into script
- Add integrity check for patch file
- Code optimization and improvements
