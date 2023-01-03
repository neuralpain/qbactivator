# qbactivator

Activation script for QuickBooks Point Of Sale Software on Windows.

> **Note**  
This activator **requires** PowerShell 4.0 or later to be installed on your Windows machine in order to function as intended.

### A few things before you start

- There is no need for you to run the insatller manually or enter any keys into the installer. The script will take care of that part for you. All you need to do is move your mouse and click the "Next" and "Finish" buttons. Do not launch QuickBooks after installation. Uncheck the "Launch QuickBooks" box before you click Finish.

- Normally, it's recommended to avoid installing updates through the application because there's a high chance that it will be blocked in the future; but I haven't had any issues when testing with **MANUAL** updates downloaded from Intuit.

- QuickBooks is installed as Pro Multistore only. There is no support for Basic (except on POSv11) or Pro level (because why would you even want that).

> **Warning**  
> This activator was designed to work with only a single version of QuickBooks POS installed. If there are multiple versions, it will use the most recent version of the software, and that may cause unexpected results. Caution is advised. Uninstall all previous versions of QuickBooks POS.

## Downloads & Updates

Browse the [QuickBooks product download form](https://downloads.quickbooks.com/app/qbdt/products) for earlier downloads or additional QuickBooks Desktop software that isn't included here.

### Available QuickBooks POS Software from Intuit

- [QuickBooks Point Of Sale V19 (2019)](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2019/Latest/QuickBooksPOSV19.exe)
- [QuickBooks Point Of Sale V18 (2018)](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2018/Latest/QuickBooksPOSV18.exe)
- [QuickBooks Point Of Sale V12 (2015)](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2015/Latest/QuickBooksPOSV12.exe)

### *Optional updates* for QuickBooks POS Software from Intuit

- [Update for QuickBooks Point Of Sale V19 (2019)](https://qbpos.intuit.com/POS19.0/WebQBPOSPatch_V19R5.exe)
- [Update for QuickBooks Point Of Sale V18 (2018)](https://qbpos.intuit.com/POS18.0/WebQBPOSPatch_V18R14.exe)
- [Update for QuickBooks Point Of Sale V12 (2015)](https://qbpos.intuit.com/POS12.0/WebQBPOSPatch_V12R21.exe)

## The Setup (with installation)

Extract `qbactivator.cmd` and `qbpatch.dat` to the **same folder** containing the QuickBooks installer (if any). This is the main requirement. When the script is started it will look in the current location for `qbpatch.dat`. If it is not found, the activator will terminate.

Ensure that the QuickBooks installer executable has the original name from the download, e.g., `QuickBooksPOSV19.exe`, `QuickBooksPOSV12.exe` etc. If the name has changed, the installer will not be recognized by the activator.

> **Note**  
> By default, the activator will search for the installer executable and assumes that you will be installing and activating QuickBooks all at once, however, it is not a requirement for the script to continue. Without an executable present, the script assumes an `activation-only` request and ignores installation.

## Instructions for activation

1. Run `qbactivator.cmd` and allow the QuickBooks software to install completely before
   you continue.
2. Uncheck the "Launch QuickBooks" box. 
3. Click Finish and continue with the script. QuickBooks will open automatically.
4. You will be asked for Administrative privileges. Click Next.
5. Select "Open Practice Mode"
6. Click Next
7. Select "Use Sample Data..."
8. Click Next
9. Click OK

> **Warning**  
> **DO NOT** click "Register now" or press the <kbd>Enter↵</kbd> key at this point.

10. Click "Remind me later".

> **Note**  
> At this point, the software might seem frozen but just allow the UI some time to load. It will greet you with a dialog informing you that "You are in Practice Mode" when it is ready for interaction along with a yellow indicator in the top-right.

11. Click OK
12. Click the "Help" option in the menu bar
13. Select "Registration" from the drop-down
14. Click "Register by phone now"
15. Enter the code `99999930`
16. Click Next
17. Click Finish

> **Note**  
> You can end the activation here or continue on to add more users if that's something you need.

### Steps 18-23 are for adding more users. This is optional.

18. Click the "Help" option in the menu bar
19. Click "Manage My License"
20. Click "Buy Additional User License"
21. Enter the code for the number of users you want

> **Note**  
> For 5 users use `9999995`. For 30 users use `99999930`, etc.

22. Click Next
23. Click Finish
24. Exit the software

## Error Handling

If the activator closes unexpectedly or receives an error during the activation process, go to the folder below.

```
%systemroot%\Microsoft.NET\assembly\GAC_MSIL\Intuit.Spc.Map.EntitlementClient.Common\v4.0_8.0.0.0__5dc4fe72edbcacf5
```

1. Delete `Intuit.Spc.Map.EntitlementClient.Common.dll`
2. Remove the `.bak` extension from `Intuit.Spc.Map.EntitlementClient.Common.dll.bak`
3. Restart the activator

## Ongoing development

- A more comprehensive AIO to correctly embed the patch file into the script.
- Better automated error handling for any misses in the file restoration process

## License

Licensed under [MIT](./LICENSE).
