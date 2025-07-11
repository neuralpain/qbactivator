<p align="center">
  <picture>
    <source srcset="https://user-images.githubusercontent.com/77242216/213914137-51bda12c-6214-44f8-bae4-e9b7e633233b.svg" media="(prefers-color-scheme: light)" height="96px" alt="qbactivator logo light">
    <img src="https://user-images.githubusercontent.com/77242216/213914139-b21538e0-05c1-4194-99bc-620f5d559fc9.svg" height="96px" alt="qbactivator logo dark">
  </picture><br/>
  <a href="https://ko-fi.com/s/529011e010"><img src="https://img.shields.io/github/v/release/neuralpain/qbactivator?label=Latest%20Release&labelColor=123311&color=3fab05"></a>
  <a href="https://ko-fi.com/s/529011e010"><img src="https://img.shields.io/github/downloads/neuralpain/qbactivator/total?style=social"></a>
</p>
<p align="center">Activation script for QuickBooks Point of Sale Software on Windows</p>
<p align="center"><a href="https://ko-fi.com/s/529011e010"><img src="./assets/images/download_btn.svg" style="height: 64px;"></a></p>

> [!CAUTION]  
> **Do not** clone or download this *repository* or the *source code* to run qbactivator. The compiled script **is not** contained within the source (ref. [#10][issue_10]). Use the download button **above** to get the latest version of the script and [read the Wiki][getstarted] to get started using qbactivator.

### Features

- Permanent activation
- Automatic licensing
- Multi-Store support
- Optional downloader for installer packages
- Protection against compromised packages

> [!NOTE]  
> Protection involves comparing hashes of verified installer packages against the hash of the installer that the user has downloaded or transferred from another location. If an installer package has been flagged as compromised but the user trusts the installer (or is too lazy to download an official installer), the user can decide to ignore the warning and use their current installer package.

### Supported Operating Systems
- Windows 11
- Windows 10
- Windows 8.1
- Windows 7 SP1 (requires [Windows Management Framework 4.0][wikiwmf4])
- Windows Server 2012-2022 (ref. [#44][issue_44])

> [!IMPORTANT]  
> `qbactivator` **requires** at least PowerShell 4.0 [or later][updatepowershell] to be installed on your Windows machine in order to function as intended. If you are using Windows 10 or above, it is likely that PowerShell 5.1 or a later version is already installed on your machine. You can check your PowerShell version by using the `$PSVersionTable` command in PowerShell if you are unsure.

### A few things before you start

- An internet connection **is not** required for activation or adding users, i.e., you are able to activate offline; but you can let it have that one free phone call to let Intuit know that it's safe.
- QuickBooks POS should be installed before other QuickBooks Desktop products.
- Manually running the QuickBooks POS installer or entering any keys into the installer **is not required** as the script will handle these tasks. You only need to navigate through the buttons and options.
- Remember that you **should not** launch QuickBooks Point of Sale after installation. Ensure that you uncheck the "Launch QuickBooks Point Of Sale" option before clicking on "Finish" and proceeding with the activation process.
- It is recommended to **avoid** installing updates through the application due to some of the features being blocked (ref. [#27][issue_27]), but they are available [here](https://github.com/neuralpain/qbactivator/wiki#optional-updates-for-quickbooks-pos-software-from-intuit) if you want to download them yourself.
- All versions of QuickBooks Desktop Point of Sale, including v12, v18, and v19, are licensed as `Pro Multistore Level`. The only exception is POS v11, which is licensed as `Pro Level`.
- [Read the instructions][instructions] to run `qbactivator` and activate QuickBooks.
- [Read the FAQs](#faqs) for further information and guidance for any concerns you may have.

> [!WARNING]  
> `qbactivator` is intended to operate with only one version of QuickBooks POS installed. In the event of multiple installations, the activator may encounter errors. Therefore, before executing qbactivator, it is crucial to remove all other versions of QuickBooks POS.

## Downloads & Updates

> [!NOTE]
> ### Latest Release [⧉][release]
>
> **v0.24.0**
> - Fix critical bug affecting additional Client licenses
> - Add Toast notifications
> - TLS security improvements
> - Bug fixes and improvements
>
> *v0.23.0*
> - Add manual refresh option to update menu head information
> - Fix issue [#43](https://github.com/neuralpain/qbactivator/issues/43) where `qba-22` ignored local available POS installers
> - Minor improvements
>
> *v0.22.0*
> - Add new Troubleshooting menu
> - Add option `Lv3` in troubleshooting to potentially fix "Invalid Product Code" error
> - Add 16 more licenses for each version of POS, a total of 64 new licenses; available for client activation
> - Add links to qbactivator wiki, etc. in Troubleshooting Menu
> - Add indicators for installation & activation status
> - Fix instructions not being exported before activation
> - Fix edge-case loop error scenario when refusing to proceed to download an installer
> - Enabled transcript log to trace errors encountered during the runtime of the activator
> - Disabled bandwidth calculation
> - Code refactoring, minor bug fixes and improvements

### Release Breakdown

Each release of qbactivator comes with 3 packages:

- <code>**qbactivator-[version].zip**</code>: the complete release which contains all the files necessary to activate the QuickBooks POS software **offline**. It also includes the LICENSE and README.
- <code>**qbactivator-[version].min.zip**</code>: a lightweight release ZIP package (take note of the `.min` in the name) which excludes larger files that can be downloaded online, such as the patch file. It also includes the LICENSE and README.
- <code>**qbactivator-[version].cmd**</code>: just the script file with no other files.

All packages perform the same function as they are derived from a single script, merely packaged in different formats. The regular package is ideal for users who either lack internet access at a specific workstation or prefer to activate the software offline. 

On the other hand, the `.min.zip` package and the single `.cmd` file are smaller and more portable. These formats are perfect for users with fast internet connections who can quickly download the files, or for those who need a swift, on-the-go solution.

> [!TIP]  
> If you encouner an issue where the QuickBooks installer performs a rollback during setup, this may be a driver issue. Download this [Visual C++ redistributable repack](https://github.com/abbodi1406/vcredist/releases/download/v0.82.0/VisualCppRedist_AIO_x86_x64.exe) and run it to install the Microsoft Visual C++ Redistributable packages for 2005-2022.
>
>Check for any updates to this repack [here](https://github.com/abbodi1406/vcredist/releases).

### Available QuickBooks POS Software from Intuit

- [QuickBooks Point Of Sale V19 (2019) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2019/Latest/QuickBooksPOSV19.exe)
- [QuickBooks Point Of Sale V18 (2018) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2018/Latest/QuickBooksPOSV18.exe)
- [QuickBooks Point Of Sale V12 (2015) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2015/Latest/QuickBooksPOSV12.exe)
- [QuickBooks Point Of Sale V11 (2013) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2013/Latest/QuickBooksPOSV11.exe)

> [!TIP]  
> Browse the QuickBooks [product download page](https://downloads.quickbooks.com/app/qbdt/products) for additional QuickBooks Desktop software that is not included here in this documentation.

## FAQs

### Is this activator safe?

Yes, it is.

### Why should I use this?

You don't have to, but it's the only activator that fully supports [all versions](#available-quickbooks-pos-software-from-intuit) of QuickBooks Point Of Sale.

### Where are the license keys?

License keys are not provided to the user beforehand. `qbactivator` will automatically install the appropriate license keys for the version of QuickBooks Point of Sale being installed on the system. This is to ensure stability during activation and avoid any potential issues that may arise from using invalid or incorrect license keys. However, if you have your own license keys, you are able to use them with `qbactivator` through the "I have my own license" menu option.

License keys are reviewed regularly to keep `qbactivator` functioning as intended.

[Click to view more frequently asked questions][faqs]

## License

```
BSD 2-Clause License

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

See LICENSE for details.
```

<!-- Links -->
[wiki]: https://github.com/neuralpain/qbactivator/wiki
[faqs]: https://github.com/neuralpain/qbactivator/wiki/FAQs
[getstarted]: https://github.com/neuralpain/qbactivator/wiki#getting-started
[update]: https://github.com/neuralpain/qbactivator/wiki#downloads--updates
[instructions]: https://github.com/neuralpain/qbactivator/wiki/How-to-Use
[download_cmd]: https://github.com/neuralpain/qbactivator/releases/latest/download/qbactivator-0.24.0.cmd
[download_min]: https://github.com/neuralpain/qbactivator/releases/latest/download/qbactivator-0.24.0.min.zip
[download]: https://github.com/neuralpain/qbactivator/releases/latest/download/qbactivator-0.24.0.zip
[release]: https://github.com/neuralpain/qbactivator/releases/latest
[powershell]: https://github.com/PowerShell/PowerShell/releases/latest
[updatepowershell]: https://github.com/neuralpain/qbactivator/wiki/Updating-PowerShell
[wikiwmf4]: https://github.com/neuralpain/qbactivator/wiki/Updating-PowerShell#3-windows-management-framework-40
<!-- Issues -->
[issue_10]: https://github.com/neuralpain/qbactivator/issues/10#issuecomment-1416758671
[issue_12]: https://github.com/neuralpain/qbactivator/issues/12#issuecomment-1478727716
[issue_27]: https://github.com/neuralpain/qbactivator/issues/27#issuecomment-1913171241
[issue_44]: https://github.com/neuralpain/qbactivator/issues/44
<!-- End Links -->
