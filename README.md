# qbactivator

Activation script for QuickBooks Point Of Sale Software (and more) on Windows. Originally created for Point of Sale 2013/v11 and Point of Sale 2013/v11 Multistore but has proven to work on other versions of the QuickBooks software.

### A few things before you start
- QuickBooks software **must** be opened as administrator, which is done by right-clicking the shortcut and click "Run as administrator". To make that action permanent, right click the shortcut, click the "Compatibility" tab, check the box that says "Run this program as an administrator" and click OK.
- To upgrade to Multistore if you have already activated it, jump to step 24.
- Normally, it's recommended to avoid installing updates because Intuit will probably block this in the future, but I've never had any issues with updates when testing.
- If installing QuickBooks for the first time, do not launch QuickBooks after installation. Uncheck the "Launch QuickBooks" box and click Finish.

> **Note**  
> `qbactivator.cmd` and `qbpatch.dat` are both required for proper activation. You should have these files extracted to the same location and run the activation script. When the script is started it will look in the current location for `qbpatch.dat`. If it is not found, the patch will not continue.

## Downloads & Updates

Look at the [QuickBooks product download form](https://downloads.quickbooks.com/app/qbdt/products) for earlier downloads or additional QuickBooks Desktop software that isn't included in this document.

Available QuickBooks POS Software from Intuit

- [QuickBooks Point Of Sale V19 (2019)](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2019/Latest/QuickBooksPOSV19.exe)
- [QuickBooks Point Of Sale V18 (2018)](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2018/Latest/QuickBooksPOSV18.exe)
- [QuickBooks Point Of Sale V12 (2015)](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2015/Latest/QuickBooksPOSV12.exe)

*Optional updates* for QuickBooks POS Software from Intuit

- [Update for QuickBooks Point Of Sale V19 (2019)](https://qbpos.intuit.com/POS19.0/WebQBPOSPatch_V19R5.exe)
- [Update for QuickBooks Point Of Sale V18 (2018)](https://qbpos.intuit.com/POS18.0/WebQBPOSPatch_V18R14.exe)
- [Update for QuickBooks Point Of Sale V12 (2015)](https://qbpos.intuit.com/POS12.0/WebQBPOSPatch_V12R21.exe)

## Instructions for activation

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
> **DO NOT** click "Register now" or press the <kbd>Enter↵</kbd> key at this point.

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

## Ongoing development

- A more comprehensive AIO to correctly embed the patch file into the script. I encountered some issues with AveYo's [Compressed2Text](https://github.com/AveYo/Compressed2TXT) script that I am currently trying to work around.
- Better automated error handling for any misses in the file restoration process

## Credits

Thanks to Beast_iND (the original author), microbolt and dechronic for their work in previous versions of this activation script up to `v0.15`.

## License

Licensed under [MIT](./LICENSE).
