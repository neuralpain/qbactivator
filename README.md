<p align="center">
  <picture>
    <source srcset="https://user-images.githubusercontent.com/77242216/213914139-b21538e0-05c1-4194-99bc-620f5d559fc9.svg" media="(prefers-color-scheme: dark)" height="96px" alt="qbactivator logo dark">
    <img src="https://user-images.githubusercontent.com/77242216/213914137-51bda12c-6214-44f8-bae4-e9b7e633233b.svg" height="96px" alt="qbactivator logo light">
  </picture>
</p>

Activation script for QuickBooks Point of Sale Software on Windows. — [Jump to installation](#the-setup-with-installation)

> **Note** `qbactivator` **requires** at least PowerShell 4.0 [or later](#how-do-i-update-powershell) to be installed on your Windows machine in order to function as intended. If installing on Windows 10/11, you should already have Powershell 5.1 installed on your machine. Use `$PSVersionTable` to check your version of PowerShell if you are unsure.

## A few things before you start

- An internet connection is **required** for activation and [adding users](#steps-18-23-are-for-adding-more-users-this-is-optional). It needs that one free phone call to tell daddy you're not a threat while being held hostage.

- There is no need for you to manually run the QuickBooks installer or enter any keys into the installer. The script will take care of that. You just need click the "Next" and "Finish" buttons.

- Remember that you **should not** launch the QuickBooks software after installation: uncheck the "Launch QuickBooks" box before you click "Finish" then continue activation. If QuickBooks is launched, it will be closed by the activator anyway.

- Normally, it _is_ recommended to avoid installing updates through the application because there is a high chance that it will be blocked in the future; but I haven't had any issues when testing with [updates downloaded **manually** from Intuit](#optional-updates-for-quickbooks-pos-software-from-intuit).

- All POS products, i.e., `v12`, `v18`, `v19`; are licensed as `Pro Multistore` Level except for POS `v11` which is licensed as `Pro` only.

- Do yourself a favor and [read the FAQs](#faqs).

> **Note** Keys are updated as soon as they are made available and will be published in the following release to keep up the functionality of this activator.

> **Warning** `qbactivator` was designed to work with only a single version of QuickBooks POS installed. If there are multiple versions installed, the activator may throw an error. Ensure to remove all other versions of QuickBooks POS before running this activator.

## Building from source

Provide the script with executable permissions.

``` bash
cd path/to/folder
chmod +x ./compile
```

Run the compiler with the `--test` or `-t` flag to build multiple unit tests. Each test will be marked with a unique build number and stored in the `build` folder.

```
./compile --test "new feature test"
```

Optionally, anything entered after the `--test` flag will be used as a description for the unit test. The quotes are ignored.

> **Note** The compiler requires the `zip` package to be installed for archiving the compiled script with the `--release` flag. The `-o` flag in combination with `--release` prevents archiving and only outputs the compiled script to the `dist` folder.


## Downloads & Updates

### Available QuickBooks POS Software from Intuit

- [QuickBooks Point Of Sale V19 (2019) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2019/Latest/QuickBooksPOSV19.exe)
- [QuickBooks Point Of Sale V18 (2018) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2018/Latest/QuickBooksPOSV18.exe)
- [QuickBooks Point Of Sale V12 (2015) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2015/Latest/QuickBooksPOSV12.exe)
- [QuickBooks Point Of Sale V11 (2013) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2013/Latest/QuickBooksPOSV11.exe)

### *Optional* updates for QuickBooks POS Software from Intuit

- [Update for QuickBooks Point Of Sale V19 (2019) ⧉](https://qbpos.intuit.com/POS19.0/WebQBPOSPatch_V19R5.exe)
- [Update for QuickBooks Point Of Sale V18 (2018) ⧉](https://qbpos.intuit.com/POS18.0/WebQBPOSPatch_V18R14.exe)
- [Update for QuickBooks Point Of Sale V12 (2015) ⧉](https://qbpos.intuit.com/POS12.0/WebQBPOSPatch_V12R21.exe)

> **Note** Browse the QuickBooks [product download page](https://downloads.quickbooks.com/app/qbdt/products) for earlier and additional QuickBooks Desktop software that isn't included here in this documentation.

## The Setup (with installation)

Go to the [latest release](https://github.com/neuralpain/qbactivator/releases/latest) of `qbactivator` and download either one of the attached files. Extract the contents (if downloaded a ZIP) to the **same location** together with the QuickBooks installer (if any).

> **Note** Download the `*.min.zip` archive for a lightweight, portable script (~28KB in size).

### Installation

Backup (and archive) any existing company data in `C:\Users\Public\Documents\Intuit\QuickBooks Point of Sale XX.0\Data` (if available) and uninstall any previous versions of QuickBooks.

Before you install QuickBooks Point of Sale, please ensure that you are using a proper, working copy of the installer on hand, and the installer has the original name from the download, e.g., `QuickBooksPOSV19.exe` or `QuickBooksPOSV12.exe` etc. If the name has changed, the installer will not be recognized by the activator. The option to [download an installer](#downloads--updates) is always available.

> **Note** By default, the activator will search for the installer executable first and assumes that you will be installing and activating QuickBooks all at once. However, it is not a requirement for the script to continue: without an executable present, the script assumes an `activation-only` request and ignores installation.

## Instructions for activation

The following instructions are included in the activator and will be provided to you when the script is ready for activation. — [Add more users](#steps-18-23-are-for-adding-more-users-this-is-optional)

1. Run `qbactivator.cmd` and allow the QuickBooks software to install completely before you continue the activation.
2. Uncheck the "Launch QuickBooks" box.
3. Click Finish and continue with the script. QuickBooks will open automatically.
4. You will be asked for Administrative privileges. Click Next.
5. Select "Open Practice Mode"
6. Click Next
7. Select "Use Sample Data..."
8. Click Next
9. Click OK
10. Click "Register by phone now"
11. Enter the code `999999`
12. Click Next
13. Click Finish

> **Note** The software may appear frozen while the UI is being loaded. It will greet you with a dialog informing you that "You are in Practice Mode" when it is ready for interaction along with a yellow indicator in the top-right.

> **Note** You can end the activation here or continue to add more users if that's something you need.

### Steps 14-19 are for adding more users. (This is optional.)

14. Click the "Help" option in the menu bar
15. Click "Manage My License"
16. Click "Buy Additional User License"
17. Enter the code for the number of users you want

> **Note** For 5 users use `9999995`. For 30 users use `99999930`, etc.

18. Click Next
19. Click Finish
20. Exit the software
21. Continue the script

## Planned features/enhancements

- Silent installation and activation
- Activation support for other QuickBooks Desktop products, i.e., QuickBooks Desktop Pro, QuickBooks Desktop Premier, QuickBooks Desktop Accountant and QuickBooks Desktop Enterprise

## FAQs

### Is this activator safe?

Yes, it is.

### Why should I use this?

Because you should (and it's the only activator that supports [QB POS 2019](#downloads--updates)).

### Can I have multiple versions installed?

I don't know why anyone would want that but refer to the first warning [above](#a-few-things-before-you-start). TLDR: No.

### Where are the license keys?

License keys are not provided. Entering the keys manually have proven to cause issues in the activation. As such, the available keys have been sifted through and only the ones which work are being installed by the activation script.

### Should I run this activator with PowerShell?

While the script incorporates PowerShell code, it is not necessary to run the script with PowerShell since it can be run as a regular batch script with the command prompt (`cmd.exe`).

### How do I update PowerShell?

> **Note** This is only necessary if you have a version of PowerShell lower than `4.0`.

Download one of the following ZIP archives for the [latest release](https://github.com/PowerShell/PowerShell/releases/latest) of PowerShell based on your CPU architecture.

- 64bit - [PowerShell-7.3.2-win-x64.zip ⧉](https://github.com/PowerShell/PowerShell/releases/download/v7.3.2/PowerShell-7.3.2-win-x64.zip)
- 32bit - [PowerShell-7.3.2-win-x86.zip ⧉](https://github.com/PowerShell/PowerShell/releases/download/v7.3.2/PowerShell-7.3.2-win-x86.zip)
- ARM64 - [PowerShell-7.3.2-win-arm64.zip ⧉](https://github.com/PowerShell/PowerShell/releases/download/v7.3.2/PowerShell-7.3.2-win-arm64.zip)

### The script was closed during activation or ran into a problem while attempting to restore the client

1. Restart `qbactivator`.
2. Create an activation request.
3. Allow the error to be resolved automatically.
4. Choose whether or not to proceed with activation afterwards.

### [INFO] QuickBooks Point of Sale is already running

This is a very rare case where there may have been an attempt to launch multiple instances of QuickBooks Point of Sale. This happens because the software was not properly terminated before restarting.

- Restart your system and start `qbactivator`.

### [Warning] QuickBooks Point of Sale was unable to activate the product

This warning is normally shown when the registration code is rejected. However, this is a very rare case if you c&p.

1. Check that you entered the registration code correctly.
2. Enter the registration code again.
3. If error persists, restart QuickBooks POS and enter again.
4. Reinstall QuickBooks Point of Sale.

## License

Licensed under [BSD 2-Clause](./LICENSE).
