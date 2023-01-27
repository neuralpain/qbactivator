<p align="center">
  <picture>
    <source srcset="https://user-images.githubusercontent.com/77242216/213914139-b21538e0-05c1-4194-99bc-620f5d559fc9.svg" media="(prefers-color-scheme: dark)" height="96px" alt="qbactivator logo dark">
    <img src="https://user-images.githubusercontent.com/77242216/213914137-51bda12c-6214-44f8-bae4-e9b7e633233b.svg" height="96px" alt="qbactivator logo light">
  </picture>
</p>

Activation script for QuickBooks Point of Sale Software on Windows. — [Jump to installation](#the-setup-with-installation)

> **Note** `qbactivator` **requires** at least PowerShell 4.0 [or later](#how-do-i-update-powershell) to be installed on your Windows machine in order to function as intended. If installing on Windows 10/11, you should be equipped with a suitable version of PowerShell. Use `$PSVersionTable` to check your version of PowerShell if you are unsure.

## A few things before you start

- An internet connection is **required** for activation and [modifying users](#steps-18-23-are-for-adding-more-users-this-is-optional). It needs that one free phone call to tell daddy you're not a threat while being held hostage.

- There is no need for you to manually run the QuickBooks installer or enter any keys into the installer. The script will take care of that part for you. All you need to do is move your mouse and click the "Next" and "Finish" buttons.

- Remember that you **should not** launch the QuickBooks software after installation: uncheck the "Launch QuickBooks" box before you click "Finish" and continue on the script to proceed with the activation.

- Normally, it _is_ recommended to avoid installing updates through the application because there is a high chance that it will be blocked in the future; but I haven't had any issues when testing with [updates downloaded **manually** from Intuit](#optional-updates-for-quickbooks-pos-software-from-intuit).

- If you ever need to cancel the installation for whatever reason, you can close the activator after cancelling and start it again. It has not started any additional processes during that time so it will be fine.

- All POS products, i.e., `v12`, `v18`, `v19`; are licensed as `Pro Multistore` Level except for POS `v11` which is licensed as `Pro` only.

> **Note** Keys are updated as soon as they are made available and will be published in the following release to keep up the functionality of this activator.

> **Warning** `qbactivator` was designed to work with only a single version of QuickBooks POS installed. If there are multiple versions installed, the activator will throw an error at your face (if only literally); otherwise, unexpected results may occur. Uninstall all other versions of QuickBooks POS before running this activator.

## Building from source
    
``` bash
chmod +x ./build.sh && ./build.sh -i
```

The build script requires the `zip` package to be installed for archiving the compiled script. You should get this response if successful.

```
Build complete.
Archived to "dist/qbactivator-x.x.x.zip"
```

Otherwise, the build will complete but you will receive a "failed to archive files" message.

> **Note** Run `./build.sh` without the `-i` flag to build unit tests. Each test will be marked with a unique build number and stored in the `build` folder.

## Downloads & Updates

### Available QuickBooks POS Software from Intuit

- [QuickBooks Point Of Sale V19 (2019)](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2019/Latest/QuickBooksPOSV19.exe)
- [QuickBooks Point Of Sale V18 (2018)](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2018/Latest/QuickBooksPOSV18.exe)
- [QuickBooks Point Of Sale V12 (2015)](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2015/Latest/QuickBooksPOSV12.exe)
- [QuickBooks Point Of Sale V11 (2013)](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2013/Latest/QuickBooksPOSV11.exe)

### *Optional* updates for QuickBooks POS Software from Intuit

- [Update for QuickBooks Point Of Sale V19 (2019)](https://qbpos.intuit.com/POS19.0/WebQBPOSPatch_V19R5.exe)
- [Update for QuickBooks Point Of Sale V18 (2018)](https://qbpos.intuit.com/POS18.0/WebQBPOSPatch_V18R14.exe)
- [Update for QuickBooks Point Of Sale V12 (2015)](https://qbpos.intuit.com/POS12.0/WebQBPOSPatch_V12R21.exe)

> **Note** Browse the QuickBooks [product download page](https://downloads.quickbooks.com/app/qbdt/products) for earlier downloads or additional QuickBooks Desktop software that isn't included here in this documentation.

## The Setup (with installation)

Download the [latest release](https://github.com/neuralpain/qbactivator/releases/download/v0.18.1/qbactivator-0.18.1.zip) of the activator and extract the files to the **same location** together with the QuickBooks installer (if any). When the script is started it will look in the current location for `qbpatch.dat`. If it is not found, the activator will throw an error.

Backup (and archive) any existing company data in `C:\Users\Public\Documents\Intuit\QuickBooks Point of Sale XX.0\Data` (if any) and uninstall any previous versions of QuickBooks. Ensure that the QuickBooks installer executable has the original name from the download, e.g., `QuickBooksPOSV19.exe` or `QuickBooksPOSV12.exe` etc; before you run the activation script. If the name has changed, the installer will not be recognized by the activator.

> **Note** By default, the activator will search for the installer executable and assumes that you will be installing and activating QuickBooks all at once, however, it is not a requirement for the script to continue. Without an executable present, the script assumes an `activation-only` request and ignores installation.

## Instructions for activation

The following instructions are included in the activator and will be provided to you when the script is ready for activation. — [Add more users](#steps-18-23-are-for-adding-more-users-this-is-optional)

1. Run `qbactivator.cmd` and allow the QuickBooks software to install completely before you continue.
2. Uncheck the "Launch QuickBooks" box.
3. Click Finish and continue with the script. QuickBooks will open automatically.
4. You will be asked for Administrative privileges. Click Next.
5. Select "Open Practice Mode"
6. Click Next
7. Select "Use Sample Data..."
8. Click Next
9. Click OK

> **Warning** **Do not** click "Register now" or press the <kbd>Enter↵</kbd> key at this point.

10. Click "Remind me later".

> **Note** The software may appear frozen while the UI is being loaded. It will greet you with a dialog informing you that "You are in Practice Mode" when it is ready for interaction along with a yellow indicator in the top-right.

11. Click OK
12. Click the "Help" option in the menu bar
13. Select "Registration" from the drop-down
14. Click "Register by phone now"
15. Enter the code `999999`
16. Click Next
17. Click Finish

> **Note** You can end the activation here or continue to add more users if that's something you need.

### Steps 18-23 are for adding more users. This is optional.

18. Click the "Help" option in the menu bar
19. Click "Manage My License"
20. Click "Buy Additional User License"
21. Enter the code for the number of users you want

> **Note** For 5 users use `9999995`. For 30 users use `99999930`, etc.

22. Click Next
23. Click Finish
24. Exit the software

## Planned features/enhancements

- Fully automated installation and activation
- AIO compilation to eliminate the need of a the extra `qbpatch.dat` file for activation
- Activation support for other QuickBooks Desktop products, i.e., QuickBooks Desktop Pro, QuickBooks Desktop Premier, QuickBooks Desktop Accountant and QuickBooks Desktop Enterprise

## FAQs

### Is this activator safe?

Yes, it is.

### Why should I use this?

Because you should (and it's the only activator that supports [QB POS 2019](#downloads--updates)).

### Can I have multiple versions installed?

I don't know why anyone would want that but refer to the first warning [above](#a-few-things-before-you-start).

### Where are the license keys?

License keys are not provided. Entering the keys manually have proven to cause issues in the activation. As such, the available keys have been sifted through and only the ones which work are being installed by the activation script.

### Should I run this activator with PowerShell?

While the script incorporates PowerShell code, it is not necessary to run the script with PowerShell since it can be run as a regular batch script with the command prompt (`cmd.exe`).

### How do I update PowerShell?

Download one of the following ZIP archives for the latest release of `PowerShell` based on your CPU architecture.

- 64bit - [PowerShell-7.3.1-win-x64.zip ⧉](https://github.com/PowerShell/PowerShell/releases/download/v7.3.1/PowerShell-7.3.1-win-x64.zip)
- 32bit - [PowerShell-7.3.1-win-x86.zip ⧉](https://github.com/PowerShell/PowerShell/releases/download/v7.3.1/PowerShell-7.3.1-win-x86.zip)
- ARM64 - [PowerShell-7.3.1-win-arm64.zip ⧉](https://github.com/PowerShell/PowerShell/releases/download/v7.3.1/PowerShell-7.3.1-win-arm64.zip)

### The activator was closed while QuickBooks is open

- For new installations, reinstall QuickBooks entirely (recommended).
- For installations on current working environments, go to the folder below:

  ```
  %systemroot%\Microsoft.NET\assembly\GAC_MSIL\Intuit.Spc.Map.EntitlementClient.Common\v4.0_8.0.0.0__5dc4fe72edbcacf5
  ```

  1. Delete `Intuit.Spc.Map.EntitlementClient.Common.dll`
  2. Remove the `.bak` extension from `Intuit.Spc.Map.EntitlementClient.Common.dll.bak`
  3. Restart the activator

## License

Licensed under [BSD 2-Clause](./LICENSE).
