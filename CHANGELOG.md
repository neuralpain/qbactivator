# Changelog

## v0.18.0

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
