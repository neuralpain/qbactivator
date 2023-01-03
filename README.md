# qbactivator

Activation script for QuickBooks Point Of Sale Software on Windows.

### A few things before you start

- There is no need for you to run the insatller manually or enter any keys into the installer. The script will take care of that part for you. All you need to do is click "Next" and "Finish".

- If installing QuickBooks for the first time, do not launch QuickBooks after installation. Uncheck the "Launch QuickBooks" box and click Finish.

- Normally, it's recommended to avoid installing updates through the application because it will probably be blocked in the future; but I've never had any issues when testing with **MANUAL** updates downloaded from Intuit.

- To upgrade to Multistore if you have already activated it, jump to step 24.

> **Warning**  
> This activator was designed to work with only one version of QuickBooks installed. If there are multiple versions, it will use the most recent version of the software.

## The Setup

Extract `qbactivator.cmd` and `qbpatch.dat` to the **same folder** containing the QuickBooks installer (if any). This is the main requirement. When the script is started it will look in the current location for `qbpatch.dat`. If it is not found, the activator will terminate.

Ensure that the QuickBooks installer executable has the original name from the download, e.g., `QuickBooksPOSV19.exe`, `QuickBooksPOSV12.exe` etc. If the name has changed, the installer will not be recognized by the activator.

> **Note**  
> By default, the activator will also search for the installer executable and assumes that you will be installing and activating QuickBooks all at once, however it is not a requirement for the script to continue. Without an executable present, the script assumes an `activation-only` request and ignores installation.

## Instructions for Activation

1. Run `qbactivator.cmd` and ensure that a QuickBooks software is installed before you continue
2. Open the installed QuickBooks software. You will be prompted about the need for Administrator access
3. Click Next
4. Approve the prompt by clicking "Yes" or "Continue", if the prompt appears
5. Click "Open Practice Mode"
6. Click Next
7. Use Sample Data
8. Click Next
9. Click OK

> **Warning**  
> **Do not** click "Register now" or press the <kbd>Enter↵</kbd> key at this point.

10. Click "Remind me later"
11. Click "Help" in the menu bar
12. Click "Registration"
13. Click "Register by phone now"
14. Enter the code `99999930`
15. Click Next
16. Click Finish

> **Note**  
> The following steps (17-23 is optional)

17. To add more users, click "Help"
18. Click "Manage My License"
19. Click "Buy Additional User License"
20. Enter the code for the number of users you want

> **Note**  
> For 5 users use `9999995`; For 30 users use `99999930`, etc.

21. Click Next
22. Click Finish
23. Follow the remaining instructions in the activator (if any) to finish the activation.

### To upgrade to Multistore - Optional but recommended

24. With the activator still running, Click Help
25. Click "Try Point of Sale Multistore FREE"
26. Click Next
27. Click Continue
28. After a few moments, click Finish
29. Click Help
30. Click Buy Now
31. Enter new product number for Multistore as provided in the [qbLicense.key] file for the relative software.
32. Enter the validation code as `99999930`
33. Click Next
34. Click Next
35. Click Continue
36. A message "Welcome to Point of Sale ProMS Level" (or similar) will appear
37. Click Finish
38. Exit the software

> **Note**  
> To add users to Multistore, repeat steps 17-22.

## Error Handling

If the activator closes unexpectedly during the activation process (after you continue Step 2):
1. Go to the folder below
   ```
   %systemroot%\Microsoft.NET\assembly\GAC_MSIL\Intuit.Spc.Map.EntitlementClient.Common\v4.0_8.0.0.0__5dc4fe72edbcacf5
   ```
2. Delete `Intuit.Spc.Map.EntitlementClient.Common.dll`
3. Remove the `.bak` extension from `Intuit.Spc.Map.EntitlementClient.Common.dll.bak`
4. Restart the activator

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

## Ongoing development

- A more comprehensive AIO to correctly embed the patch file into the script.
- Better automated error handling for any misses in the file restoration process

## License

Licensed under [MIT](./LICENSE).
