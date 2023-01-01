@echo off
color 2f
@setlocal enableextensions
@cd /d "%~dp0"
echo Ending QuickBooks Processes in the background (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 5% Percent Complete!
PING -n 3 127.0.0.1 >NUL
TASKKILL /F /IM qbw.exe
TASKKILL /F /IM qbw32.exe
TASKKILL /F /IM qbupdate.exe
TASKKILL /F /IM qbhelp.exe
TASKKILL /F /IM QBUpdateService.exe
TASKKILL /F /IM QBFDT.exe
PING -n 3 127.0.0.1 >NUL
echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 10% Percent Complete!
call "C:\Program Files (x86)\Intuit\QuickBooks 2023\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks 2023\reboot.bat"

call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 23.0\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 23.0\reboot.bat"

echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 25% Percent Complete!
call "C:\Program Files (x86)\Intuit\QuickBooks 2022\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks 2022\reboot.bat"

call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 22.0\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 22.0\reboot.bat"

echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 40% Percent Complete!
call "C:\Program Files (x86)\Intuit\QuickBooks 2021\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks 2021\reboot.bat"

call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 21.0\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 21.0\reboot.bat"

echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 50% Percent Complete!

call "C:\Program Files (x86)\Intuit\QuickBooks 2020\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks 2020\reboot.bat"

call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 20.0\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 20.0\reboot.bat"

echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 65% Percent Complete!

call "C:\Program Files (x86)\Intuit\QuickBooks 2019\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks 2019\reboot.bat"

call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 19.0\reboot.bat"

call "C:\Program Files (x86)\Intuit\QuickBooks 2015\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks 2015\reboot.bat"

call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 15.0\reboot.bat"

echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 75% Percent Complete!

call "C:\Program Files (x86)\Intuit\QuickBooks 2016\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks 2016\reboot.bat"

call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 16.0\reboot.bat"

echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 85% Percent Complete!

call "C:\Program Files (x86)\Intuit\QuickBooks 2017\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks 2017\reboot.bat"

call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 17.0\reboot.bat"

echo Finding/Running Reboot.bat (Ignore any errors reported here, it's just Microsoft command line language and nothing specific to your QuickBooks)... 100% Percent Complete!
call "C:\Program Files (x86)\Intuit\QuickBooks 2018\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks 2018\reboot.bat"

call "C:\Program Files (x86)\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"

call "C:\Program Files\Intuit\QuickBooks Enterprise Solutions 18.0\reboot.bat"