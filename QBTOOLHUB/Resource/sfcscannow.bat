@ECHO OFF
@setlocal enableextensions
@cd /d "%~dp0"

echo Running Microsoft SFC Scannow (Please Wait- DO NOT CLOSE THIS WINDOW!!!)...
C:\windows\sysnative\sfc /scannow
pause
Dism /Online /Cleanup-Image /RestoreHealth
pause