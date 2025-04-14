@echo off
setlocal enabledelayedexpansion

echo ======================================================
echo 00OS to Cursor Rules Enhanced Synchronization
echo ======================================================
echo.
echo This script will:
echo 1. Run the main Sync-00OS.bat script to synchronize files
echo 2. Apply custom frontmatter fixes for special files
echo.

rem Get script directory
set SCRIPT_DIR=%~dp0

rem Run the main sync script with all arguments passed through
call "%SCRIPT_DIR%Sync-00OS.bat" %*

echo.
echo ======================================================
echo Running frontmatter fixes...
echo ======================================================
echo.

rem Run the frontmatter fix script
powershell -ExecutionPolicy Bypass -Command "& '%SCRIPT_DIR%Sync-00OS-Fix.ps1'"

echo.
echo ======================================================
echo Enhanced synchronization complete!
echo ======================================================
echo.

exit /b 0 