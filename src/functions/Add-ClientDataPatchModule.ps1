<#--- DATA MODULE ---#>

# $EDS19 = "https://github.com/neuralpain/qbactivator/files/11451420/EDS19.zip"
# $EDS18 = "https://github.com/neuralpain/qbactivator/files/11451419/EDS18.zip"
# $EDS12 = "https://github.com/neuralpain/qbactivator/files/11451418/EDS12.zip"
# $EDS11 = "https://github.com/neuralpain/qbactivator/files/11451417/EDS11.zip"

function Remove-ClientDataModulePatch {
  if (Test-Path "${CLIENT_MODULE_DATA}.bak" -PathType Leaf) {
    Write-Host -NoNewline "Removing previous data patch... "
    Copy-Item "${CLIENT_MODULE_DATA}.bak" $CLIENT_MODULE_DATA
    Remove-Item "${CLIENT_MODULE_DATA}.bak"
    Write-Host "Done."
    Start-Sleep -Milliseconds $TIME_NORMAL
  } else {
    Write-Host "No data patch found. Client data module was not modified."
    Start-Sleep -Milliseconds $TIME_NORMAL
  }
  
  Write-Menu_SubMenu
}

<#
  # `Install-ClientDataModule` is still in development and is not 
  # functional enough to be included in an official release

  function Install-ClientDataModule {
    param ($Version)
    
      
      Remove-ClientDataModulePatch # if previously patched
      
      if (Test-Path $CLIENT_MODULE_DATA -PathType Leaf) { 
        Copy-Item $CLIENT_MODULE_DATA "${CLIENT_MODULE_DATA}.bak" 
      }
      
      Write-Host -NoNewline "Testing connectivity... "
      if (Test-Connection www.google.com -Quiet) {
        Write-Host "OK"
        Write-Host -NoNewLine "Installing data module... "
        if (-not(Test-Path -Path "$CLIENT_MODULE_DATA_PATH" -PathType Leaf)) { mkdir "$CLIENT_MODULE_DATA_PATH" >$null 2>&1 }
        
        switch ($Version) {
          19 { Start-BitsTransfer $EDS19 $CLIENT_MODULE_DATA }
          18 { Start-BitsTransfer $EDS18 $CLIENT_MODULE_DATA }
          12 { Start-BitsTransfer $EDS12 $CLIENT_MODULE_DATA }
          11 { Start-BitsTransfer $EDS11 $CLIENT_MODULE_DATA }
        }
        
        Write-Host "Done"
      } else { 
        Write-Error_NoInternetConnectivity 
      }
    }
  }
#>
