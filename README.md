<p align="center">
  <picture>
    <source srcset="https://user-images.githubusercontent.com/77242216/213914139-b21538e0-05c1-4194-99bc-620f5d559fc9.svg" media="(prefers-color-scheme: dark)" height="96px" alt="qbactivator logo dark">
    <img src="https://user-images.githubusercontent.com/77242216/213914137-51bda12c-6214-44f8-bae4-e9b7e633233b.svg" height="96px" alt="qbactivator logo light">
  </picture>
</p>

Activation script for QuickBooks Point of Sale Software on Windows. — [Jump to installation](#the-setup-with-installation)

> **Note** `qbactivator` **requires** at least PowerShell 4.0 [or later](#how-do-i-update-powershell) to be installed on your Windows machine in order to function as intended. If you are using Windows 10 or above, it is likely that PowerShell 5.1 or a later version is already installed on your machine. You can check your PowerShell version by using the `$PSVersionTable` command in PowerShell if you are unsure.

### A few things before you start

- An internet connection is **mandatory** for both the activation process and the [addition of users](#steps-14-19-are-for-adding-more-users-this-is-optional). It needs that one free phone call to let Intuit know that it's safe.

- Manually running the QuickBooks installer or entering any keys into the installer is not required as the script will handle these tasks. You only need to click on the "Next" and "Finish" buttons.

- It is important to remember not to launch the QuickBooks software after installation. Ensure that you uncheck the "Launch QuickBooks" option before clicking on "Finish" and proceeding with the activation process. In the event that QuickBooks is launched, the activator will close it automatically.

- Usually, it is recommended to avoid installing updates through the application due to the likelihood of it being blocked in the future. However, during testing, I did not encounter any problems with [updates that were downloaded manually from Intuit](#optional-updates-for-quickbooks-pos-software-from-intuit).

- All versions of QuickBooks Point of Sale products, including v12, v18, and v19, are licensed as `Pro Multistore Level`. The only exception is POS v11, which is licensed as `Pro Level` only.

- I recommend that you take time to [read the FAQs](#faqs) for further information and guidance for any concerns you may have.

> **Note** To maintain the activator's functionality, any available keys are updated promptly and will be disclosed in the subsequent release.

> **Warning** It is important to note that `qbactivator` is intended to operate with only one instance of QuickBooks POS installed. In the event of multiple installations, the activator may encounter errors. Therefore, before executing qbactivator, it is crucial to remove all other versions of QuickBooks POS.

## The Setup (with installation)

To begin the activation process, navigate to the [most recent release](https://github.com/neuralpain/qbactivator/releases/latest) of `qbactivator` and download one of the attached files. If the download is a ZIP file, extract its contents to the same location as the QuickBooks installer (if applicable).

> **Note** For a compact, portable package (~8KB in size), it is recommended to download the `*.min.zip` archive.

### Installing the software

Prior to the installation of QuickBooks, it is recommended that you take the necessary precautions to safeguard any existing company data in `C:\Users\Public\Documents\Intuit\QuickBooks Point of Sale XX.0\Data` (if present) by creating a backup and archive. Additionally, ensure that any prior versions of QuickBooks are uninstalled before proceeding with the new installation.

Additionally, it is crucial to confirm that you possess a legitimate copy of the software installer package and that the installer bears the original name from the download, such as `QuickBooksPOSV19.exe` or `QuickBooksPOSV12.exe`, etc. In the event that the name has been altered, the activator will not be able to recognize the installer. The option to [download an installer](#downloads--updates) is always available.

The activator will initially look for the installer executable as the default setting, assuming that the user requires installation **and** activation of QuickBooks POS. If the executable is not found, you will receive a prompt for the subsequent course of action, which will allow you to decide whether you want to download an installer package or proceed with activation if you have already installed QuickBooks POS.

> **Note** If an internet connection is available, `qbactivator` can download the necessary patch file and installer for activation when they are not present. However, the download duration may differ depending on the speed of the internet.

## Instructions for activation

The following instructions are included in the activator and will be provided to you when the script is ready for activation. — [Add more users](#steps-14-19-are-for-adding-more-users-this-is-optional)

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

> **Note** You can end the activation here (skip to step 20) or continue to add more users if that's something you need.

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

## Downloads & Updates

#### Available QuickBooks POS Software from Intuit

- [QuickBooks Point Of Sale V19 (2019) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2019/Latest/QuickBooksPOSV19.exe)
- [QuickBooks Point Of Sale V18 (2018) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2018/Latest/QuickBooksPOSV18.exe)
- [QuickBooks Point Of Sale V12 (2015) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2015/Latest/QuickBooksPOSV12.exe)
- [QuickBooks Point Of Sale V11 (2013) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2013/Latest/QuickBooksPOSV11.exe)

#### *Optional* updates for QuickBooks POS Software from Intuit

- [Update for QuickBooks Point Of Sale V19 (2019) ⧉](https://qbpos.intuit.com/POS19.0/WebQBPOSPatch_V19R5.exe)
- [Update for QuickBooks Point Of Sale V18 (2018) ⧉](https://qbpos.intuit.com/POS18.0/WebQBPOSPatch_V18R14.exe)
- [Update for QuickBooks Point Of Sale V12 (2015) ⧉](https://qbpos.intuit.com/POS12.0/WebQBPOSPatch_V12R21.exe)

> **Note** Browse the QuickBooks [product download page](https://downloads.quickbooks.com/app/qbdt/products) for earlier and additional QuickBooks Desktop software that isn't included here in this documentation.

---

## Building from source

If you need to build this project from source, you will need to run the `compile` script. If you encounter any issues running the script, ensure that you have the necessary permissions by providing executable permissions.

``` bash
cd path/to/folder
chmod +x ./compile
```

To build multiple unit tests, run the compiler with the `--test` or `-t` flag. Each test will be assigned a unique build number and stored in the `build` folder.

```
./compile --test "new feature test"
```

Optionally, anything entered after the `--test` flag will be used as a description for the unit test. The quotes are ignored and are therefore unnecessary.

> **Note** To archive the compiled script using the `-i` flag, you need to have the `zip` package installed. If you don't want to archive the script and only want to output it to the `dist` folder, you can use the `-o` flag in combination with `-i`.

## FAQs

### Is this activator safe?

Yes, it is.

### Why should I use this?

Because you should (and it's the only activator that supports [POS 2019](#downloads--updates)).

### Can I have multiple versions installed?

I don't know why anyone would want that but refer to the first warning [above](#a-few-things-before-you-start). In short, the answer is no.

### Where are the license keys?

License keys are not provided. The qbactivator script will automatically install the [appropriate license keys](#a-few-things-before-you-start) for the version of QuickBooks software (being) installed on the system. This is to ensure stability during activation and avoid any potential issues that may arise from using invalid or incorrect license keys.

### Should I run this activator with PowerShell?

While the script incorporates PowerShell code, it is not necessary to run the script with PowerShell since it can be run as a regular batch script with Command Prompt (`cmd.exe`). Also note that `qbactivator` was ~5% faster when executed with CMD due to the smaller overhead compared to PowerShell. However, the script can be run with both interfaces, and users can choose the one that best fits their needs.

### How do I update PowerShell?

> **Note** This is only necessary if you have a version of PowerShell lower than `4.0`.

Download one of the following ZIP archives for a recent release of PowerShell based on your CPU architecture.

- 64bit - [PowerShell-7.3.3-win-x64.zip ⧉](https://github.com/PowerShell/PowerShell/releases/download/v7.3.3/PowerShell-7.3.3-win-x64.zip)
- 32bit - [PowerShell-7.3.3-win-x86.zip ⧉](https://github.com/PowerShell/PowerShell/releases/download/v7.3.3/PowerShell-7.3.3-win-x86.zip)
- ARM64 - [PowerShell-7.3.3-win-arm64.zip ⧉](https://github.com/PowerShell/PowerShell/releases/download/v7.3.3/PowerShell-7.3.3-win-arm64.zip)

> **Note** New packages maybe be released so check out the [releases page](https://github.com/PowerShell/PowerShell/releases/latest) for the latest release of PowerShell.

### The script was closed during activation or ran into a problem while attempting to restore the client

1. Restart `qbactivator`
2. Request software activation
3. Allow the error to be resolved automatically
4. Choose whether or not to proceed with activation afterwards

### (Dialog) QuickBooks Point of Sale is already running

This occurs when there is an attempt to launch multiple instances of QuickBooks Point of Sale, which typically happens when the software was not properly terminated before restarting.

- Restart your system and start `qbactivator`

### (Dialog) QuickBooks Point of Sale was unable to activate the product

This warning is typically displayed when the registration code is not accepted, but it is unlikely to occur when copying and pasting the code.

1. Check that you entered the registration code correctly
2. Enter the registration code again
3. If error persists, restart QuickBooks POS and enter again
4. Reinstall QuickBooks Point of Sale

### Will this activator only work for QuickBooks POS?

Yes, this activator was specifically designed for QuickBooks POS and is not intended to be used with other QuickBooks Desktop products. There is a possibility that activation support for other QuickBooks Desktop products may be added in future releases, but it is not currently planned.

## License

Licensed under [BSD 2-Clause](./LICENSE).
