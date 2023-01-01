@echo off
color 4f
@setlocal enableextensions
@cd /d "%~dp0"
ver | find "10.0" > nul
if %ERRORLEVEL% == 0 goto Win10

ver | find "6.3" > nul
if %ERRORLEVEL% == 0 goto Win8.1

ver | find "6.2" > nul
if %ERRORLEVEL% == 0 goto Win8

ver | find "6.1" > nul
if %ERRORLEVEL% == 0 goto Win7

ver | find "6.0" > nul
if %ERRORLEVEL% == 0 goto Vista

ver | find "5.2" > nul
if %ERRORLEVEL% == 0 goto 2003
 
ver | find "5.1" > nul
if %ERRORLEVEL% == 0 goto WinXP


:Win10
echo Repairing XPS driver on Windows 10 Operating System... 5 Percent Complete!
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer"
PING -n 3 127.0.0.1 >NUL
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer v3"
PING -n 3 127.0.0.1 >NUL
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer v4"
PING -n 3 127.0.0.1 >NUL
echo Installing XPS driver on Windows Windows 10 (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 10 Percent Complete!
cscript c:\windows\system32\printing_admin_scripts\en-us\prnmngr.vbs -a -p "Microsoft XPS Document Writer" -m "Microsoft XPS Document Writer v4" -r "PORTPROMPT:"
echo Ending QuickBooks Processes in the background (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 15 Percent Complete!
PING -n 3 127.0.0.1 >NUL
TASKKILL /F /IM qbw.exe
TASKKILL /F /IM qbw32.exe
TASKKILL /F /IM qbupdate.exe
TASKKILL /F /IM qbhelp.exe
TASKKILL /F /IM QBUpdateService.exe
echo Repairing QBPRINT (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 20 Percent Complete!
PING -n 3 127.0.0.1 >NUL
del "C:\ProgramData\Intuit\QuickBooks 2023\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2022\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2021\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2020\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2019\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2018\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2017\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2016\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2015\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2014\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2013\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2012\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2011\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2010\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 23.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 22.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 21.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 20.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 19.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 18.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 17.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 16.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 15.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 14.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 13.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 12.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 11.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 10.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2023\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2022\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2021\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2020\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2019\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2018\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2017\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2016\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2015\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2014\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2013\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2012\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2011\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2010\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 23.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 22.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 21.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 20.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 19.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 18.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 17.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 16.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 15.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 14.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 13.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 12.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 11.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 10.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
Echo Unregistering MSXML6 DLLs (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 25 Percent Complete!
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s msxml4.dll
regsvr32 /s msxml4.dll
regsvr32 /u /s msxml6.dll
regsvr32 /s msxml6.dll
PING -n 3 127.0.0.1 >NUL
Echo Reregistering MSXML6 DLLs (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 40 Percent Complete!
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s c:\windows\syswow64\msxml4.dll
regsvr32 /s c:\windows\syswow64\msxml4.dll
regsvr32 /u /s c:\windows\syswow64\msxml6.dll
regsvr32 /s c:\windows\syswow64\msxml6.dll
Echo Stopping Print Spooler Service (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 45 Percent Complete!
PING -n 3 127.0.0.1 >NUL
NET STOP "Spooler"
echo Clearing Temporary Printer Files (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 50 Percent Complete!
PING -n 1 127.0.0.1 >NUL
del %systemroot%\system32\spool\printers\*.shd
del %systemroot%\system32\spool\printers\*.spl
Echo Starting Print Spooler Service (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 55 Percent Complete!
PING -n 3 127.0.0.1 >NUL
NET START "Spooler"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 60 Percent Complete!
call "C:\Program Files (x86)\Intuit\QuickBooks 2023\reboot.bat"
call "C:\Program Files\Intuit\QuickBooks 2023\reboot.bat"
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 23.0\reboot.bat"
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 23.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 65 Percent Complete!
call "C:\Program Files (x86)\Intuit\QuickBooks 2022\reboot.bat"
call "C:\Program Files\Intuit\QuickBooks 2022\reboot.bat"
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 22.0\reboot.bat"
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 22.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 70 Percent Complete!
call "C:\Program Files (x86)\Intuit\QuickBooks 2021\reboot.bat"
call "C:\Program Files\Intuit\QuickBooks 2021\reboot.bat"
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 21.0\reboot.bat"
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 21.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 75 Percent Complete!
call "C:\Program Files\Intuit\QuickBooks 2020\reboot.bat"
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 20.0\reboot.bat"
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 20.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 80 Percent Complete!
call "C:\Program Files (x86)\Intuit\QuickBooks 2019\reboot.bat"
call "C:\Program Files\Intuit\QuickBooks 2019\reboot.bat"
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 85 Percent Complete!
call "C:\Program Files\Intuit\QuickBooks 2015\reboot.bat"
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 90 Percent Complete!
call "C:\Program Files\Intuit\QuickBooks 2016\reboot.bat"
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 95 Percent Complete!
call "C:\Program Files (x86)\Intuit\QuickBooks 2017\reboot.bat"
call "C:\Program Files\Intuit\QuickBooks 2017\reboot.bat"
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 100%
call "C:\Program Files (x86)\Intuit\QuickBooks 2018\reboot.bat"
call "C:\Program Files\Intuit\QuickBooks 2018\reboot.bat"
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"

goto exit

:Win8.1
echo Repairing XPS driver on Windows 8.1...
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer"
PING -n 3 127.0.0.1 >NUL
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer v3"
PING -n 3 127.0.0.1 >NUL
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer v4"
PING -n 3 127.0.0.1 >NUL
echo Installing XPS driver on Windows 8.1
cscript c:\windows\system32\printing_admin_scripts\en-us\prnmngr.vbs -a -p "Microsoft XPS Document Writer" -m "Microsoft XPS Document Writer v4" -r "PORTPROMPT:"
echo Ending QuickBooks Processes in the background...
PING -n 3 127.0.0.1 >NUL
TASKKILL /F /IM qbw32.exe
TASKKILL /F /IM qbupdate.exe
TASKKILL /F /IM qbhelp.exe
TASKKILL /F /IM QBUpdateService.exe
echo Repairing QBPRINT...
PING -n 3 127.0.0.1 >NUL
del "C:\ProgramData\Intuit\QuickBooks 2021\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2020\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2019\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2018\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2017\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2016\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2015\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2014\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2013\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2012\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2011\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2010\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 21.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 20.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 19.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 18.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 17.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 16.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 15.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 14.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 13.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 12.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 11.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 10.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2021\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2020\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2019\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2018\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2017\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2016\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2015\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2014\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2013\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2012\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2011\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2010\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 21.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 20.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 19.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 18.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 17.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 16.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 15.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 14.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 13.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 12.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 11.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 10.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
Echo Unregistering MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s msxml4.dll
regsvr32 /s msxml4.dll
regsvr32 /u /s msxml6.dll
regsvr32 /s msxml6.dll
PING -n 3 127.0.0.1 >NUL
Echo Reregistering MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s c:\windows\syswow64\msxml4.dll
regsvr32 /s c:\windows\syswow64\msxml4.dll
regsvr32 /u /s c:\windows\syswow64\msxml6.dll
regsvr32 /s c:\windows\syswow64\msxml6.dll
Echo Stopping Print Spooler Service...
PING -n 3 127.0.0.1 >NUL
NET STOP "Spooler"
echo Clearing Temporary Printer Files...
PING -n 1 127.0.0.1 >NUL
del %systemroot%\system32\spool\printers\*.shd
del %systemroot%\system32\spool\printers\*.spl
Echo Starting Print Spooler Service...
PING -n 3 127.0.0.1 >NUL
NET START "Spooler"
PING -n 3 127.0.0.1 >NUL
echo Running Reboot.bat...
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2021 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2021\reboot.bat"
echo Finding/Running 2021 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2021\reboot.bat"
echo Finding/Running Enterprise 21.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 21.0\reboot.bat"
echo Finding/Running Enterprise 21.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 21.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2020 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2020\reboot.bat"
echo Finding/Running 2020 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2020\reboot.bat"
echo Finding/Running Enterprise 20.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 20.0\reboot.bat"
echo Finding/Running Enterprise 20.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 20.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2019 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2019\reboot.bat"
echo Finding/Running 2019 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2019\reboot.bat"
echo Finding/Running Enterprise 19.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"
echo Finding/Running Enterprise 19.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2015 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2015\reboot.bat"
echo Finding/Running 2015 Reboot.bat....
call "C:\Program Files\Intuit\QuickBooks 2015\reboot.bat"
echo Finding/Running Enterprise 15.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"
echo Finding/Running Enterprise 15.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2016 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2016\reboot.bat"
echo Finding/Running 2016 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2016\reboot.bat"
echo Finding/Running Enterprise 16.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"
echo Finding/Running Enterprise 16.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2017 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2017\reboot.bat"
echo Finding/Running 2017 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2017\reboot.bat"
echo Finding/Running Enterprise 17.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"
echo Finding/Running Enterprise 17.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2018 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2018\reboot.bat"
echo Finding/Running 2018 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2018\reboot.bat"
echo Finding/Running Enterprise 18.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"
echo Finding/Running Enterprise 18.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"
goto exit

:Win8
echo Repairing XPS driver on Windows 8...
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer"
PING -n 3 127.0.0.1 >NUL
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer v3"
PING -n 3 127.0.0.1 >NUL
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer v4"
PING -n 3 127.0.0.1 >NUL
echo Installing XPS driver on Windows 8
cscript c:\windows\system32\printing_admin_scripts\en-us\prnmngr.vbs -a -p "Microsoft XPS Document Writer" -m "Microsoft XPS Document Writer v4" -r "PORTPROMPT:"
echo Ending QuickBooks Processes in the background...
PING -n 3 127.0.0.1 >NUL
TASKKILL /F /IM qbw32.exe
TASKKILL /F /IM qbupdate.exe
TASKKILL /F /IM qbhelp.exe
TASKKILL /F /IM QBUpdateService.exe
echo Repairing QBPRINT...
PING -n 3 127.0.0.1 >NUL
del "C:\ProgramData\Intuit\QuickBooks 2020\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2019\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2018\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2017\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2016\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2015\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2014\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2013\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2012\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2011\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2010\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 20.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 19.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 18.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 17.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 16.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 15.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 14.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 13.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 12.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 11.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 10.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2020\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2019\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2018\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2017\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2016\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2015\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2014\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2013\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2012\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2011\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2010\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 20.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 19.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 18.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 17.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 16.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 15.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 14.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 13.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 12.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 11.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 10.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
Echo Unregistering MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s msxml4.dll
regsvr32 /s msxml4.dll
regsvr32 /u /s msxml6.dll
regsvr32 /s msxml6.dll
PING -n 3 127.0.0.1 >NUL
Echo Reregistering MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s c:\windows\syswow64\msxml4.dll
regsvr32 /s c:\windows\syswow64\msxml4.dll
regsvr32 /u /s c:\windows\syswow64\msxml6.dll
regsvr32 /s c:\windows\syswow64\msxml6.dll
Echo Stopping Print Spooler Service...
PING -n 3 127.0.0.1 >NUL
NET STOP "Spooler"
echo Clearing Temporary Printer Files...
PING -n 1 127.0.0.1 >NUL
del %systemroot%\system32\spool\printers\*.shd
del %systemroot%\system32\spool\printers\*.spl
Echo Starting Print Spooler Service...
PING -n 3 127.0.0.1 >NUL
NET START "Spooler"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2020 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2019\reboot.bat"
echo Finding/Running 2020 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2020\reboot.bat"
echo Finding/Running Enterprise 20.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 20.0\reboot.bat"
echo Finding/Running Enterprise 20.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 20.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2019 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2019\reboot.bat"
echo Finding/Running 2019 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2019\reboot.bat"
echo Finding/Running Enterprise 19.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"
echo Finding/Running Enterprise 19.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2015 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2015\reboot.bat"
echo Finding/Running 2015 Reboot.bat....
call "C:\Program Files\Intuit\QuickBooks 2015\reboot.bat"
echo Finding/Running Enterprise 15.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"
echo Finding/Running Enterprise 15.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2016 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2016\reboot.bat"
echo Finding/Running 2016 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2016\reboot.bat"
echo Finding/Running Enterprise 16.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"
echo Finding/Running Enterprise 16.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2017 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2017\reboot.bat"
echo Finding/Running 2017 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2017\reboot.bat"
echo Finding/Running Enterprise 17.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"
echo Finding/Running Enterprise 17.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2018 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2018\reboot.bat"
echo Finding/Running 2018 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2018\reboot.bat"
echo Finding/Running Enterprise 18.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"
echo Finding/Running Enterprise 18.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"
goto exit

:Win7
echo Repairing XPS driver on Windows 7...
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer"
PING -n 3 127.0.0.1 >NUL
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer v3"
PING -n 3 127.0.0.1 >NUL
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer v4"
PING -n 3 127.0.0.1 >NUL
echo Installing XPS driver on Windows 7
cscript c:\windows\system32\printing_admin_scripts\en-us\prnmngr.vbs -a -p "Microsoft XPS Document Writer" -m "Microsoft XPS Document Writer" -r "XPSPort:"
PING -n 3 127.0.0.1 >NUL
cscript c:\windows\system32\printing_admin_scripts\en-us\prndrvr.vbs -a -m "Microsoft XPS Document Writer" -h "C:\Windows\System32\spool\tools\Microsoft XPS Document Writer\" -i "C:\Windows\System32\spool\tools\Microsoft XPS Document Writer\prnms001.INF"
echo Ending QuickBooks Processes in the background...
PING -n 3 127.0.0.1 >NUL
TASKKILL /F /IM qbw32.exe
TASKKILL /F /IM qbupdate.exe
TASKKILL /F /IM qbhelp.exe
TASKKILL /F /IM QBUpdateService.exe
echo Repairing QBPRINT...
PING -n 3 127.0.0.1 >NUL
del "C:\ProgramData\Intuit\QuickBooks 2020\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2019\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2018\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2017\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2016\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2015\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2014\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2013\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2012\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2011\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2010\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 20.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 19.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 18.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 17.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 16.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 15.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 14.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 13.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 12.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 11.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 10.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2020\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2019\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2018\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2017\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2016\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2015\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2014\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2013\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2012\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2011\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2010\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 20.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 19.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 18.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 17.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 16.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 15.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 14.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 13.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 12.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 11.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 10.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
Echo Unregistering MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s msxml4.dll
regsvr32 /s msxml4.dll
regsvr32 /u /s msxml6.dll
regsvr32 /s msxml6.dll
PING -n 3 127.0.0.1 >NUL
Echo Reregistering MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s c:\windows\syswow64\msxml4.dll
regsvr32 /s c:\windows\syswow64\msxml4.dll
regsvr32 /u /s c:\windows\syswow64\msxml6.dll
regsvr32 /s c:\windows\syswow64\msxml6.dll
Echo Stopping Print Spooler Service...
PING -n 3 127.0.0.1 >NUL
NET STOP "Spooler"
echo Clearing Temporary Printer Files...
PING -n 1 127.0.0.1 >NUL
del %systemroot%\system32\spool\printers\*.shd
del %systemroot%\system32\spool\printers\*.spl
Echo Starting Print Spooler Service...
PING -n 3 127.0.0.1 >NUL
NET START "Spooler"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2020 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2019\reboot.bat"
echo Finding/Running 2020 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2020\reboot.bat"
echo Finding/Running Enterprise 20.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 20.0\reboot.bat"
echo Finding/Running Enterprise 20.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 20.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2019 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2019\reboot.bat"
echo Finding/Running 2019 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2019\reboot.bat"
echo Finding/Running Enterprise 19.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"
echo Finding/Running Enterprise 19.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2015 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2015\reboot.bat"
echo Finding/Running 2015 Reboot.bat....
call "C:\Program Files\Intuit\QuickBooks 2015\reboot.bat"
echo Finding/Running Enterprise 15.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"
echo Finding/Running Enterprise 15.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2016 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2016\reboot.bat"
echo Finding/Running 2016 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2016\reboot.bat"
echo Finding/Running Enterprise 16.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"
echo Finding/Running Enterprise 16.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2017 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2017\reboot.bat"
echo Finding/Running 2017 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2017\reboot.bat"
echo Finding/Running Enterprise 17.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"
echo Finding/Running Enterprise 17.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2018 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2018\reboot.bat"
echo Finding/Running 2018 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2018\reboot.bat"
echo Finding/Running Enterprise 18.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"
echo Finding/Running Enterprise 18.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"
goto exit

:Vista
echo Repairing XPS driver on Windows Vista...
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer"
PING -n 3 127.0.0.1 >NUL
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer v3"
PING -n 3 127.0.0.1 >NUL
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer v4"
PING -n 3 127.0.0.1 >NUL
echo Installing XPS driver on Windows 7
cscript c:\windows\system32\printing_admin_scripts\en-us\prnmngr.vbs -a -p "Microsoft XPS Document Writer" -m "Microsoft XPS Document Writer" -r "XPSPort:"
PING -n 3 127.0.0.1 >NUL
cscript c:\windows\system32\printing_admin_scripts\en-us\prndrvr.vbs -a -m "Microsoft XPS Document Writer" -h "C:\Windows\System32\spool\tools\Microsoft XPS Document Writer\" -i "C:\Windows\System32\spool\tools\Microsoft XPS Document Writer\prnms001.INF"
echo Ending QuickBooks Processes in the background...
PING -n 3 127.0.0.1 >NUL
TASKKILL /F /IM qbw32.exe
TASKKILL /F /IM qbupdate.exe
TASKKILL /F /IM qbhelp.exe
TASKKILL /F /IM QBUpdateService.exe
echo Repairing QBPRINT...
PING -n 3 127.0.0.1 >NUL
del "C:\ProgramData\Intuit\QuickBooks 2019\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2018\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2017\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2016\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2015\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2014\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2013\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2012\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2011\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2010\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 19.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 18.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 17.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 16.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 15.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 14.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 13.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 12.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 11.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 10.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2019\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2018\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2017\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2016\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2015\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2014\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2013\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2012\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2011\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2010\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 19.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 18.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 17.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 16.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 15.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 14.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 13.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 12.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 11.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 10.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
Echo Unregistering MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s msxml4.dll
regsvr32 /s msxml4.dll
regsvr32 /u /s msxml6.dll
regsvr32 /s msxml6.dll
PING -n 3 127.0.0.1 >NUL
Echo Reregistering MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s c:\windows\syswow64\msxml4.dll
regsvr32 /s c:\windows\syswow64\msxml4.dll
regsvr32 /u /s c:\windows\syswow64\msxml6.dll
regsvr32 /s c:\windows\syswow64\msxml6.dll
Echo Stopping Print Spooler Service...
PING -n 3 127.0.0.1 >NUL
NET STOP "Spooler"
echo Clearing Temporary Printer Files...
PING -n 1 127.0.0.1 >NUL
del %systemroot%\system32\spool\printers\*.shd
del %systemroot%\system32\spool\printers\*.spl
Echo Starting Print Spooler Service...
PING -n 3 127.0.0.1 >NUL
NET START "Spooler"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2019 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2019\reboot.bat"
echo Finding/Running 2019 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2019\reboot.bat"
echo Finding/Running Enterprise 19.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"
echo Finding/Running Enterprise 19.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2015 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2015\reboot.bat"
echo Finding/Running 2015 Reboot.bat....
call "C:\Program Files\Intuit\QuickBooks 2015\reboot.bat"
echo Finding/Running Enterprise 15.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"
echo Finding/Running Enterprise 15.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2016 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2016\reboot.bat"
echo Finding/Running 2016 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2016\reboot.bat"
echo Finding/Running Enterprise 16.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"
echo Finding/Running Enterprise 16.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2017 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2017\reboot.bat"
echo Finding/Running 2017 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2017\reboot.bat"
echo Finding/Running Enterprise 17.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"
echo Finding/Running Enterprise 17.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2018 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2018\reboot.bat"
echo Finding/Running 2018 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2018\reboot.bat"
echo Finding/Running Enterprise 18.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"
echo Finding/Running Enterprise 18.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"
goto exit

:2003
echo Repairing XPS driver on Windows Server 2003...
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer"
PING -n 3 127.0.0.1 >NUL
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer v3"
PING -n 3 127.0.0.1 >NUL
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer v4"
PING -n 3 127.0.0.1 >NUL
echo Installing XPS driver on Windows 7
cscript c:\windows\system32\printing_admin_scripts\en-us\prnmngr.vbs -a -p "Microsoft XPS Document Writer" -m "Microsoft XPS Document Writer" -r "XPSPort:"
echo Ending QuickBooks Processes in the background...
PING -n 3 127.0.0.1 >NUL
TASKKILL /F /IM qbw32.exe
TASKKILL /F /IM qbupdate.exe
TASKKILL /F /IM qbhelp.exe
TASKKILL /F /IM QBUpdateService.exe
echo Repairing QBPRINT...
PING -n 3 127.0.0.1 >NUL
del "C:\ProgramData\Intuit\QuickBooks 2019\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2018\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2017\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2016\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2015\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2014\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2013\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2012\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2011\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2010\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 19.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 18.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 17.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 16.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 15.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 14.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 13.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 12.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 11.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 10.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2019\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2018\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2017\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2016\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2015\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2014\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2013\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2012\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2011\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2010\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 19.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 18.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 17.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 16.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 15.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 14.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 13.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 12.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 11.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 10.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
Echo Unregistering MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s msxml4.dll
regsvr32 /s msxml4.dll
regsvr32 /u /s msxml6.dll
regsvr32 /s msxml6.dll
PING -n 3 127.0.0.1 >NUL
Echo Reregistering MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s c:\windows\syswow64\msxml4.dll
regsvr32 /s c:\windows\syswow64\msxml4.dll
regsvr32 /u /s c:\windows\syswow64\msxml6.dll
regsvr32 /s c:\windows\syswow64\msxml6.dll
Echo Stopping Print Spooler Service...
PING -n 3 127.0.0.1 >NUL
NET STOP "Spooler"
echo Clearing Temporary Printer Files...
PING -n 1 127.0.0.1 >NUL
del %systemroot%\system32\spool\printers\*.shd
del %systemroot%\system32\spool\printers\*.spl
Echo Starting Print Spooler Service...
PING -n 3 127.0.0.1 >NUL
NET START "Spooler"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2019 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2019\reboot.bat"
echo Finding/Running 2019 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2019\reboot.bat"
echo Finding/Running Enterprise 19.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"
echo Finding/Running Enterprise 19.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2015 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2015\reboot.bat"
echo Finding/Running 2015 Reboot.bat....
call "C:\Program Files\Intuit\QuickBooks 2015\reboot.bat"
echo Finding/Running Enterprise 15.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"
echo Finding/Running Enterprise 15.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2016 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2016\reboot.bat"
echo Finding/Running 2016 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2016\reboot.bat"
echo Finding/Running Enterprise 16.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"
echo Finding/Running Enterprise 16.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2017 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2017\reboot.bat"
echo Finding/Running 2017 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2017\reboot.bat"
echo Finding/Running Enterprise 17.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"
echo Finding/Running Enterprise 17.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2018 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2018\reboot.bat"
echo Finding/Running 2018 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2018\reboot.bat"
echo Finding/Running Enterprise 18.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"
echo Finding/Running Enterprise 18.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"
goto exit
 
:WinXP
echo Repairing XPS driver on Windows XP...
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer"
PING -n 3 127.0.0.1 >NUL
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer v3"
PING -n 3 127.0.0.1 >NUL
rundll32 printui.dll,PrintUIEntry /dl /q /n "Microsoft XPS Document Writer v4"
PING -n 3 127.0.0.1 >NUL
echo Installing XPS driver on Windows XP
cscript c:\windows\system32\printing_admin_scripts\en-us\prnmngr.vbs -a -p "Microsoft XPS Document Writer" -m "Microsoft XPS Document Writer" -r "XPSPort:"
echo Ending QuickBooks Processes in the background...
PING -n 3 127.0.0.1 >NUL
TASKKILL /F /IM qbw32.exe
TASKKILL /F /IM qbupdate.exe
TASKKILL /F /IM qbhelp.exe
TASKKILL /F /IM QBUpdateService.exe
echo Repairing QBPRINT...
PING -n 3 127.0.0.1 >NUL
del "C:\ProgramData\Intuit\QuickBooks 2019\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2018\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2017\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2016\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2015\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2014\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2013\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2012\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2011\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks 2010\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 19.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 18.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 17.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 16.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 15.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 14.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 13.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 12.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 11.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\ProgramData\Intuit\QuickBooks Enterprise Solutions 10.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2019\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2018\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2017\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2016\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2015\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2014\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2013\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2012\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2011\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks 2010\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 19.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 18.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 17.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 16.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 15.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 14.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 13.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 12.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 11.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
del "C:\Documents and Settings\All Users\Application Data\Intuit\QuickBooks Enterprise Solutions 10.0\QBPRINT.QBP" "QBPRINT.QBP_%dt%"
Echo Unregistering MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s msxml4.dll
regsvr32 /s msxml4.dll
regsvr32 /u /s msxml6.dll
regsvr32 /s msxml6.dll
PING -n 3 127.0.0.1 >NUL
Echo Reregistering MSXML6 DLLs...
PING -n 3 127.0.0.1 >NUL
regsvr32 /u /s c:\windows\syswow64\msxml4.dll
regsvr32 /s c:\windows\syswow64\msxml4.dll
regsvr32 /u /s c:\windows\syswow64\msxml6.dll
regsvr32 /s c:\windows\syswow64\msxml6.dll
Echo Stopping Print Spooler Service...
PING -n 3 127.0.0.1 >NUL
NET STOP "Spooler"
echo Clearing Temporary Printer Files...
PING -n 1 127.0.0.1 >NUL
del %systemroot%\system32\spool\printers\*.shd
del %systemroot%\system32\spool\printers\*.spl
Echo Starting Print Spooler Service...
PING -n 3 127.0.0.1 >NUL
NET START "Spooler"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2019 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2019\reboot.bat"
echo Finding/Running 2019 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2019\reboot.bat"
echo Finding/Running Enterprise 19.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"
echo Finding/Running Enterprise 19.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2015 Reboot.bat....
call "C:\Program Files (x86)\Intuit\QuickBooks 2015\reboot.bat"
echo Finding/Running 2015 Reboot.bat....
call "C:\Program Files\Intuit\QuickBooks 2015\reboot.bat"
echo Finding/Running Enterprise 15.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"
echo Finding/Running Enterprise 15.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2016 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2016\reboot.bat"
echo Finding/Running 2016 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2016\reboot.bat"
echo Finding/Running Enterprise 16.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"
echo Finding/Running Enterprise 16.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2017 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2017\reboot.bat"
echo Finding/Running 2017 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2017\reboot.bat"
echo Finding/Running Enterprise 17.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"
echo Finding/Running Enterprise 17.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"
PING -n 1 127.0.0.1 >NUL
echo Finding/Running 2018 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks 2018\reboot.bat"
echo Finding/Running 2018 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks 2018\reboot.bat"
echo Finding/Running Enterprise 18.0 Reboot.bat...
call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"
echo Finding/Running Enterprise 18.0 Reboot.bat...
call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"
goto exit
:exit