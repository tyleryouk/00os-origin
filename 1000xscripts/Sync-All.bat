@echo off
setlocal enabledelayedexpansion

rem Check for help parameter
if /i "%~1"=="-h" goto :show_help
if /i "%~1"=="--help" goto :show_help
if /i "%~1"=="/?" goto :show_help
goto :continue

:show_help
echo.
echo Usage: Sync-All.bat [options]
echo.
echo Options:
echo   -DetectOrphans    Detect orphaned Cursor Rules (mdc files without md source)
echo   -RemoveOrphans    Remove orphaned Cursor Rules (implies -DetectOrphans)
echo   -h, --help, /?    Show this help message
echo.
exit /b 0

:continue

set DETECT_ORPHANS=false
set REMOVE_ORPHANS=false

rem Process command-line arguments
:parse_args
if "%~1"=="" goto :done_args
if /i "%~1"=="-DetectOrphans" set DETECT_ORPHANS=true
if /i "%~1"=="-RemoveOrphans" (
  set DETECT_ORPHANS=true
  set REMOVE_ORPHANS=true
)
shift
goto :parse_args
:done_args

echo.
echo ====================================================
echo 1000xbrain to Cursor Rules Synchronization
echo ====================================================
echo.

echo Running simplified synchronization with path matching...
echo This will:
echo 1. Find all markdown files in 1000xbrain (excluding README.md files)
echo 2. Update corresponding Cursor Rules with content (preserving frontmatter)
echo 3. Create new Cursor Rules for files that don't have a corresponding rule
echo 4. Generate a detailed synchronization report

if "!DETECT_ORPHANS!"=="true" (
  echo 5. Detect Cursor Rules without corresponding markdown files
  if "!REMOVE_ORPHANS!"=="true" (
    echo 6. Remove orphaned Cursor Rules
  )
)
echo.

echo Important Notes:
echo - README.md files are explicitly excluded from synchronization
echo - README.md files in 1000xbrain serve as directory navigation and documentation, not as Cursor Rules

if "!DETECT_ORPHANS!"=="true" (
  echo - Orphaned Cursor Rules detection is ENABLED
  if "!REMOVE_ORPHANS!"=="true" (
    echo - Orphaned Cursor Rules removal is ENABLED
  ) else (
    echo - Orphaned Cursor Rules removal is DISABLED
  )
)
echo.

echo.
echo Starting synchronization...
echo.

set PS_COMMAND=powershell -ExecutionPolicy Bypass -Command "& '%~dp0Sync-CursorRules.ps1'"

if "!DETECT_ORPHANS!"=="true" (
  set PS_COMMAND=!PS_COMMAND! -DetectOrphans
)

if "!REMOVE_ORPHANS!"=="true" (
  set PS_COMMAND=!PS_COMMAND! -RemoveOrphans
)

%PS_COMMAND%

echo.
echo ====================================================
echo Synchronization completed!
echo ====================================================
echo.

