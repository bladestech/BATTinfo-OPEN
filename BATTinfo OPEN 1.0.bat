@echo off
title BATTinfo OPEN

echo   accessible-available-unrestricted-unlimited-unlocked-unhindered-exposed-unconstrained
echo  X BBBBB  AAAAA TTTTTT TTTTTT III  N   N  FFFFF  OOO        OOO   PPPPP  EEEEE  N   N  X
echo  X B   B  A   A   TT     TT    I   NN  N  F     O   O      O   O  P   P  E      NN  N  X
echo  X BBBBB  AAAAA   TT     TT    I   N N N  FFFF  O   O      O   O  PPPPP  EEE    N N N  X
echo  X B   B  A   A   TT     TT    I   N  NN  F     O   O      O   O  P      E      N  NN  X
echo  X BBBBB  A   A   TT     TT   III  N   N  F      OOO        OOO   P      EEEEE  N   N  X
echo   accessible-available-unrestricted-unlimited-unlocked-unhindered-exposed-unconstrained
echo.
setlocal EnableDelayedExpansion

>nul 2>&1 net session
if %errorLevel% neq 0 (
    echo Administrator permissions are required in order to get accurate results. Please run as administrator.
    pause
    goto :eof
)

for /f "tokens=2 delims==" %%I in ('wmic path Win32_Battery get BatteryStatus /value') do (
    set BatteryStatus=%%I
)

if "%BatteryStatus%" equ "2" (
    set BatteryStatus=Charging
) else (
    set BatteryStatus=Discharging
)

for /f "tokens=2 delims==" %%I in ('wmic path Win32_Battery get EstimatedChargeRemaining /value') do (
    set BatteryLevel=%%I
)

for /f "tokens=2 delims==" %%I in ('wmic path Win32_Battery get EstimatedRunTime /value') do (
    set EstimatedTime=%%I
)

echo openopenopenopenopenopenopenopenopenopenopenopenopenopenopenopenopen
echo Battery Status: %BatteryStatus%
echo Battery Level: %BatteryLevel%%% (%EstimatedTime% minutes remaining)
echo openopenopenopenopenopenopenopenopenopenopenopenopenopenopenopenopen
echo.

set /p Confirm=Do you want to generate a battery report? (Y/N): 
if /i "!Confirm!" neq "Y" goto :eof

set /p SaveDir=Enter the directory to save the report (leave blank for C:): 

if "!SaveDir!"=="" set SaveDir=C:

powercfg /batteryreport /output "%SaveDir%\battery_report.html"

echo ~~~~~~~
echo D O N E
echo ~~~~~~~

set /p ConfirmLocation=Do you want to open the directory of the saved report? (Y/N): 
if /i "!ConfirmLocation!" equ "Y" (
    start explorer "%SaveDir%"
)

echo.
echo Thanks for using BATTinfo OPEN 1.0!

pause
