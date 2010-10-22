@echo off
call rsvars.bat
C:\Windows\Microsoft.NET\Framework\v2.0.50727\MSBuild.exe Imadering.dproj
pause
del /s *.map
