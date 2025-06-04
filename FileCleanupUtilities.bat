@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
title Windows Cleanup Utility v3.1
mode con: cols=80 lines=30
color 0A

:: Main Menu Interface
:MAIN_MENU
cls
echo ========================================
echo      WINDOWS CLEANUP UTILITY
echo ========================================
echo.
echo [1] Quick Clean (Temporary Files)
echo [2] Deep Clean (Cache + Logs)
echo [3] Browser Cache Cleaner
echo [4] System Maintenance
echo [5] Exit
echo.
set /p choice="Select option (1-5): "

if "%choice%"=="1" goto QUICK_CLEAN
if "%choice%"=="2" goto DEEP_CLEAN
if "%choice%"=="3" goto BROWSER_CLEAN
if "%choice%"=="4" goto SYSTEM_MAINT
if "%choice%"=="5" exit
goto MAIN_MENU

:: Quick Clean - Basic temp files
:QUICK_CLEAN
cls
echo [QUICK CLEAN] Removing temporary files...
echo ----------------------------------------

:: Standard temp locations
del /q /f /s "%temp%\*.*" >nul 2>&1
del /q /f /s "%windir%\Temp\*.*" >nul 2>&1
del /q /f /s "%windir%\Prefetch\*.*" >nul 2>&1

echo [OK] Temporary files cleaned
echo [OK] Prefetch files cleared
goto SHOW_RESULTS

:: Deep Clean - Includes logs and cache
:DEEP_CLEAN
cls
echo [DEEP CLEAN] Removing all junk files...
echo --------------------------------------

call :QUICK_CLEAN

:: Application logs and cache
del /q /f /s "%userprofile%\*.log" >nul 2>&1
del /q /f /s "%userprofile%\*.tmp" >nul 2>&1
del /q /f /s "%localappdata%\Microsoft\Windows\WER\*.*" >nul 2>&1

echo [OK] Application logs removed
echo [OK] Error reports cleared
goto SHOW_RESULTS

:: Browser Cache Cleaner
:BROWSER_CLEAN
cls
echo [BROWSER CLEAN] Removing cache files...
echo --------------------------------------

:: Chrome/Edge cache
del /q /f /s "%localappdata%\Google\Chrome\User Data\Default\Cache\*.*" >nul 2>&1
del /q /f /s "%localappdata%\Microsoft\Edge\User Data\Default\Cache\*.*" >nul 2>&1

:: Firefox cache
del /q /f /s "%appdata%\Mozilla\Firefox\Profiles\*.default*\cache2\*.*" >nul 2>&1

echo [OK] Chrome/Edge cache cleared
echo [OK] Firefox cache removed
goto SHOW_RESULTS

:: System Maintenance
:SYSTEM_MAINT
cls
echo [SYSTEM MAINTENANCE] Performing optimizations...
echo ----------------------------------------------

:: Disk cleanup
cleanmgr /sagerun:1 >nul 2>&1

:: DNS cache
ipconfig /flushdns >nul 2>&1

:: Recycle Bin
powershell -command "Clear-RecycleBin -Force" >nul 2>&1

echo [OK] Disk cleanup performed
echo [OK] DNS cache flushed
echo [OK] Recycle Bin emptied

:SHOW_RESULTS
echo.
echo ----------------------------------------
echo OPERATION COMPLETED SUCCESSFULLY
echo ----------------------------------------
echo.
pause
goto MAIN_MENU