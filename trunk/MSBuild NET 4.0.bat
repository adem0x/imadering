@echo off
call rsvars.bat
C:\Windows\Microsoft.NET\Framework\v4.0.30128\MSBuild.exe Imadering.dproj
pause
del /s *.map
