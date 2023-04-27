<p align="center">
  <picture>
    <source srcset="https://user-images.githubusercontent.com/77242216/213914139-b21538e0-05c1-4194-99bc-620f5d559fc9.svg" media="(prefers-color-scheme: dark)" height="96px" alt="qbactivator logo dark">
    <img src="https://user-images.githubusercontent.com/77242216/213914137-51bda12c-6214-44f8-bae4-e9b7e633233b.svg" height="96px" alt="qbactivator logo light">
  </picture>
</p>

Activation script for QuickBooks Point of Sale Software on Windows. — [Download Now!][download]

> **Warning**  
>
> **DO NOT** clone or download this repository in an attempt to run `qbactivator`. Downloading this repository is not necessary to run the script. The source files are not meant to be run individually and `qbactivator` will not run correctly if executed this way (Ref: [#10][issue_10]).
>
> If you are trying to run the script, please [read the Wiki to get started][getstarted] using `qbactivator` or proceed to [download the release package][release].

### Supported Operating Systems
- Windows 11
- Windows 10
- Windows 8.1
- Windows 7 SP1 (requires [Windows Management Framework 4.0][wikiwmf4])
- Windows Server 2012-2022

> **Note** `qbactivator` **requires** at least PowerShell 4.0 [or later][updatepowershell] to be installed on your Windows machine in order to function as intended. If you are using Windows 10 or above, it is likely that PowerShell 5.1 or a later version is already installed on your machine. You can check your PowerShell version by using the `$PSVersionTable` command in PowerShell if you are unsure.

### A few things before you start

- An internet connection is **required** for activation and adding users. It needs that one free phone call to let Intuit know that it's safe.

- Manually running the QuickBooks POS installer or entering any keys into the installer **is not required** as the script will handle these tasks. You only need to click on the "Next" and "Finish" buttons.

- Remember that you **should not** launch QuickBooks Point of Sale after installation. Ensure that you uncheck the "Launch QuickBooks" option before clicking on "Finish" and proceeding with the activation process. If QuickBooks is launched, the activator will close it automatically.

- It is recommended to **avoid** installing updates through the application due to the likelihood of it being blocked in the future. However, during testing, I did not encounter any problems with updates manually [downloaded from Intuit](#optional-updates-for-quickbooks-pos-software-from-intuit).

- All versions of QuickBooks Desktop Point of Sale, including v12, v18, and v19, are licensed as `Pro Multistore Level`. The only exception is POS v11, which is licensed as `Pro Level`.

- [View the instructions][instructions] to run `qbactivator` and activate QuickBooks

- [Read the FAQs](#faqs) for further information and guidance for any concerns you may have.

> **Warning** `qbactivator` is intended to operate with only one version of QuickBooks POS installed. In the event of multiple installations, the activator may encounter errors. Therefore, before executing qbactivator, it is crucial to remove all other versions of QuickBooks POS.

## Downloads & Updates

### Available QuickBooks POS Software from Intuit

- [QuickBooks Point Of Sale V19 (2019) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2019/Latest/QuickBooksPOSV19.exe)
- [QuickBooks Point Of Sale V18 (2018) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2018/Latest/QuickBooksPOSV18.exe)
- [QuickBooks Point Of Sale V12 (2015) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2015/Latest/QuickBooksPOSV12.exe)
- [QuickBooks Point Of Sale V11 (2013) ⧉](https://dlm2.download.intuit.com/akdlm/SBD/QuickBooks/2013/Latest/QuickBooksPOSV11.exe)

### Optional updates for QuickBooks POS Software from Intuit

- [Update for QuickBooks Point Of Sale V19 (2019) ⧉](https://qbpos.intuit.com/POS19.0/WebQBPOSPatch_V19R5.exe)
- [Update for QuickBooks Point Of Sale V18 (2018) ⧉](https://qbpos.intuit.com/POS18.0/WebQBPOSPatch_V18R14.exe)
- [Update for QuickBooks Point Of Sale V12 (2015) ⧉](https://qbpos.intuit.com/POS12.0/WebQBPOSPatch_V12R21.exe)
- *No update found for QuickBooks Point Of Sale V11 (2013)*

> **Note** Browse the QuickBooks [product download page](https://downloads.quickbooks.com/app/qbdt/products) for additional QuickBooks Desktop software that is not included here in this documentation.

## FAQs

### Is this activator safe?

Yes, it is.

### Why should I use this?

You don't have to, but it's the only activator that fully supports [all versions](#available-quickbooks-pos-software-from-intuit) of QuickBooks Point Of Sale.

### Can I have multiple versions installed?

I don't know why anyone would want that but refer to the second warning [above](#a-few-things-before-you-start). In short, the answer is no.

[Click to view more frequently asked questions][faqs]

## License

> THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Licensed under [BSD 2-Clause](LICENSE).

<!-- Links -->
[wiki]: https://github.com/neuralpain/qbactivator/wiki
[faqs]: https://github.com/neuralpain/qbactivator/wiki/FAQs
[getstarted]: https://github.com/neuralpain/qbactivator/wiki#getting-started
[update]: https://github.com/neuralpain/qbactivator/wiki#downloads--updates
[instructions]: https://github.com/neuralpain/qbactivator/wiki/How-to-Use
[download]: https://github.com/neuralpain/qbactivator/releases/download/v0.19.0/qbactivator-0.19.0.min.zip
[release]: https://github.com/neuralpain/qbactivator/releases/latest
[powershell]: https://github.com/PowerShell/PowerShell/releases/latest
[updatepowershell]: https://github.com/neuralpain/qbactivator/wiki/Updating-PowerShell
[wikiwmf4]: https://github.com/neuralpain/qbactivator/wiki/Updating-PowerShell#3-windows-management-framework-40

<!-- Issues -->
[issue_12]: https://github.com/neuralpain/qbactivator/issues/12#issuecomment-1478727716
[issue_10]: https://github.com/neuralpain/qbactivator/issues/10#issuecomment-1416758671
<!-- End Links -->
