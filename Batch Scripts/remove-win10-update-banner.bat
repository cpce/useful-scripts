echo
REM This script disables the updates are available banner you see in windows 10, server 2016, and server 2019. This will not work in windows 8.1 and server 2012.
cd /d %windir%/system32
takeown /f musnotification.exe
icacls musnotification.exe /deny Everyone:(X)
takeown /f musnotificationux.exe
icacls musnotificationux.exe /deny Everyone:(X)
pause