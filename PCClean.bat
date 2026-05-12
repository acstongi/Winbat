@echo off
title PC Fast Booster
echo Cleaning System Junk...
del /s /f /q %temp%\*.*
rd /s /q %temp%
mkdir %temp%
del /s /f /q C:\Windows\Temp\*.*
rd /s /q C:\Windows\Temp
mkdir C:\Windows\Temp
del /s /f /q C:\Windows\Prefetch\*.*
echo Optimizing Boot Services...
sc config "SysMain" start= disabled
sc config "WSearch" start= disabled
echo Flushing DNS...
ipconfig /flushdns
echo.
echo ====================================
echo PC Optimization Done! Fast hobe ekhon.
echo ====================================
pause
