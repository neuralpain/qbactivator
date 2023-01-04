@echo off
title qbpurge
set uivr=0.1.0
set "pwsh=PowerShell -NoP -C"

:: check admin permissions
cls & echo.
echo Please wait . . .
fsutil dirty query %systemdrive% >nul
:: if error, we do not have admin.
cls & echo.
if %ERRORLEVEL% NEQ 0 (
  echo Requesting administrative priviledges.
  echo Attempting to elevate...
  goto UAC_Prompt
) else ( goto :DeleteIntuitFiles )

:UAC_Prompt
set n=%0 %*
set n=%n:"=" ^& Chr(34) ^& "%
echo Set objShell = CreateObject("Shell.Application")>"%tmp%\cmdUAC.vbs"
echo objShell.ShellExecute "cmd.exe", "/c start " ^& Chr(34) ^& "." ^& Chr(34) ^& " /d " ^& Chr(34) ^& "%CD%" ^& Chr(34) ^& " cmd /c %n%", "", "runas", ^1>>"%tmp%\cmdUAC.vbs"
cscript "%tmp%\cmdUAC.vbs" //Nologo
del "%tmp%\cmdUAC.vbs"
goto :eof

:DeleteIntuitFiles
%pwsh% "Remove-Item -Path C:\ProgramData\Intuit -Recurse -Force >$null 2>&1"
%pwsh% "Remove-Item -Path 'C:\Program Files (x86)\Intuit' -Recurse -Force >$null 2>&1"
%pwsh% "Remove-Item -Path 'C:\Program Files (x86)\Common Files\Intuit' -Recurse -Force >$null 2>&1"

cls & echo.
echo Intuit purge complete.
ping -n 3 127.0.0.1 >nul
