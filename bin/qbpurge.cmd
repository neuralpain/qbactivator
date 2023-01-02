@echo off
title qbpurge
set uivr=0.1.0

:: check admin permissions
cls & echo.
echo Please wait . . .
fsutil dirty query %systemdrive% >nul
:: if error, we do not have admin.
if %ERRORLEVEL% NEQ 0 (
  cls & echo.
  echo Requesting administrative priviledges.
  echo Attempting to elevate...
  goto UAC_Prompt
) else ( goto :startQBA )

:UAC_Prompt
set n=%0 %*
set n=%n:"=" ^& Chr(34) ^& "%
echo Set objShell = CreateObject("Shell.Application")>"%tmp%\cmdUAC.vbs"
echo objShell.ShellExecute "cmd.exe", "/c start " ^& Chr(34) ^& "." ^& Chr(34) ^& " /d " ^& Chr(34) ^& "%CD%" ^& Chr(34) ^& " cmd /c %n%", "", "runas", ^1>>"%tmp%\cmdUAC.vbs"
cscript "%tmp%\cmdUAC.vbs" //Nologo
del "%tmp%\cmdUAC.vbs"
goto :eof

:DeleteIntuitFiles
rd /s /q %programdata%\Intuit
rd /s /q %programfiles(x86)%\Intuit
rd /s /q %programfiles(x86)%\Common Files\Intuit