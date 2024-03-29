<p align="center">
  <picture>
    <source srcset="https://user-images.githubusercontent.com/77242216/213914137-51bda12c-6214-44f8-bae4-e9b7e633233b.svg" media="(prefers-color-scheme: light)" height="96px" alt="qbactivator logo light">
    <img src="https://user-images.githubusercontent.com/77242216/213914139-b21538e0-05c1-4194-99bc-620f5d559fc9.svg" height="96px" alt="qbactivator logo dark">
  </picture>
</p>

Activation script for QuickBooks Point of Sale Software on Windows. — [Download Now!][download_min]

> [!CAUTION]  
> **Do not** clone or download this *repository* in an attempt to run `qbactivator` (ref. [#10][issue_10]). Downloading this repository is not necessary to run the script. The source files are not meant to be run individually and `qbactivator` will not run correctly if executed this way. If you want to run the script, [download the latest release][release] package and [read the Wiki][getstarted] to get started using `qbactivator`.

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
- Windows Server 2012-2022

> [!IMPORTANT]  
> `qbactivator` **requires** at least PowerShell 4.0 [or later][updatepowershell] to be installed on your Windows machine in order to function as intended. If you are using Windows 10 or above, it is likely that PowerShell 5.1 or a later version is already installed on your machine. You can check your PowerShell version by using the `$PSVersionTable` command in PowerShell if you are unsure.

### A few things before you start

- An internet connection *is not* required for activation or adding users, i.e., offline activation is available; but you can let it have that one free phone call to let Intuit know that it's safe.
- Manually running the QuickBooks POS installer or entering any keys into the installer **is not required** as the script will handle these tasks. You only need to click on the "Next" and "Finish" buttons.
- Remember that you **should not** launch QuickBooks Point of Sale after installation. Ensure that you uncheck the "Launch QuickBooks" option before clicking on "Finish" and proceeding with the activation process. If QuickBooks is launched, however, the activator should close it automatically.
- It is recommended to **avoid** installing updates through the application due to some of the features being blocked (ref. [#27][issue_27]), though they are available here if you want to [download them yourself](https://github.com/neuralpain/qbactivator/wiki#optional-updates-for-quickbooks-pos-software-from-intuit).
- All versions of QuickBooks Desktop Point of Sale, including v12, v18, and v19, are licensed as `Pro Multistore Level`. The only exception is POS v11, which is licensed as `Pro Level`.
- [View the instructions][instructions] to run `qbactivator` and activate QuickBooks
- [Read the FAQs](#faqs) for further information and guidance for any concerns you may have.

> [!WARNING]  
> `qbactivator` is intended to operate with only one version of QuickBooks POS installed. In the event of multiple installations, the activator may encounter errors. Therefore, before executing qbactivator, it is crucial to remove all other versions of QuickBooks POS.

## Downloads & Updates

> [!NOTE]
> ### Latest Release [⧉][release]
>
> **v0.21.2**
> 
> - Fix validation bug on local patch files
> - Fix bug preventing launch of QuickBooks POS application after installation

### Release Breakdown

Each qbactivator release comes with 3 packages:

- [`qbactivator-[version].zip`][download] – a regular release which contains all the files necessary to install and activate the QuickBooks POS software **offline**. Also contains the LICENSE and README.
- [`qbactivator-[version].min.zip`][download_min] – a lightweight release ZIP package (take note of the `.min` in the name) which does not contain any of the larger files which can be downloaded online, e.g. the patch file. Contains the LICENSE and README.
- [`qbactivator-[version].cmd`][download_cmd] – just the script file.

They all do the same job since they are the same single script packaged differently. The regular package is best for people who don't have access to the internet at the location of a specific workstation or prefer to activate offline. The `.min.zip` and single `.cmd` are smallest to carry around and suit people with fast internet speeds for downloads and people who just need a quick fix.

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

> THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Licensed under [BSD 2-Clause](LICENSE).

<p align='center'>
  <picture>
    <img src='https://www.websitecounterfree.com/c.php?d=9&id=48433&s=3' alt='qbactivator Visitor Count'>
  </picture>
</p>

<!-- Links -->
[wiki]: https://github.com/neuralpain/qbactivator/wiki
[faqs]: https://github.com/neuralpain/qbactivator/wiki/FAQs
[getstarted]: https://github.com/neuralpain/qbactivator/wiki#getting-started
[update]: https://github.com/neuralpain/qbactivator/wiki#downloads--updates
[instructions]: https://github.com/neuralpain/qbactivator/wiki/How-to-Use
[download_cmd]: https://github.com/neuralpain/qbactivator/releases/download/v0.21.2/qbactivator-0.21.2.cmd
[download_min]: https://github.com/neuralpain/qbactivator/releases/download/v0.21.2/qbactivator-0.21.2.min.zip
[download]: https://github.com/neuralpain/qbactivator/releases/download/v0.21.2/qbactivator-0.21.2.zip
[release]: https://github.com/neuralpain/qbactivator/releases/latest
[powershell]: https://github.com/PowerShell/PowerShell/releases/latest
[updatepowershell]: https://github.com/neuralpain/qbactivator/wiki/Updating-PowerShell
[wikiwmf4]: https://github.com/neuralpain/qbactivator/wiki/Updating-PowerShell#3-windows-management-framework-40
<!-- Issues -->
[issue_10]: https://github.com/neuralpain/qbactivator/issues/10#issuecomment-1416758671
[issue_12]: https://github.com/neuralpain/qbactivator/issues/12#issuecomment-1478727716
[issue_27]: https://github.com/neuralpain/qbactivator/issues/27#issuecomment-1913171241
<!-- End Links -->
