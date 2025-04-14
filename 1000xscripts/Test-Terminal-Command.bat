@echo off
setlocal enabledelayedexpansion

echo ===============================================
echo 00OS Terminal Command Test
echo ===============================================
echo.

REM Check if a command was provided
if "%~1"=="" (
    echo Error: No command provided.
    echo.
    echo Usage: Test-Terminal-Command.bat "^> command"
    echo Example: Test-Terminal-Command.bat "^> help"
    echo.
    goto :end
)

REM Run the PowerShell script with the provided command
powershell.exe -ExecutionPolicy Bypass -File "%~dp0Test-Terminal-Commands.ps1" -Command "%~1"

:end
echo.
echo =============================================== 