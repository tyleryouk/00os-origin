<#
.SYNOPSIS
    Cleans up backup files in the Cursor Rules directory.

.DESCRIPTION
    This script removes backup files created during synchronization operations from the
    Cursor Rules directory. It targets files with patterns like *.mdc.bak, *.bak, etc.

.PARAMETER WhatIf
    If specified, the script will only show what would happen without actually deleting any files.

.EXAMPLE
    .\Clean-Backups.ps1

.EXAMPLE
    .\Clean-Backups.ps1 -WhatIf

.NOTES
    Author: 1000xdev
    Version: 1.0
#>

param(
    [switch]$WhatIf
)

# Get the root directory
$rootDir = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$cursorRulesDir = Join-Path (Join-Path $rootDir ".cursor") "rules"

# Check if the Cursor Rules directory exists
if (-not (Test-Path $cursorRulesDir)) {
    Write-Host "Cursor Rules directory not found: $cursorRulesDir" -ForegroundColor Red
    exit 1
}

Write-Host "Searching for backup files in $cursorRulesDir..."

# Find all backup files
$backupFiles = @()
$backupFiles += Get-ChildItem -Path $cursorRulesDir -Recurse -File -Filter "*.mdc.bak"
$backupFiles += Get-ChildItem -Path $cursorRulesDir -Recurse -File -Filter "*.bak" | Where-Object { $_.Name -notmatch "\.mdc\.bak$" }
$backupFiles += Get-ChildItem -Path $cursorRulesDir -Recurse -File -Filter "*_backup_*"
$backupFiles += Get-ChildItem -Path $cursorRulesDir -Recurse -File -Filter "*.backup"

# Remove duplicate files (if any)
$backupFiles = $backupFiles | Sort-Object FullName -Unique

if ($backupFiles.Count -eq 0) {
    Write-Host "No backup files found." -ForegroundColor Green
    return "No backup files found."
}

Write-Host "Found $($backupFiles.Count) backup file(s):" -ForegroundColor Yellow
foreach ($file in $backupFiles) {
    $relativePath = $file.FullName.Substring($cursorRulesDir.Length).TrimStart('\', '/')
    Write-Host "- $relativePath" -ForegroundColor Yellow
}

if ($WhatIf) {
    Write-Host "`nRunning in WhatIf mode - no files will be deleted." -ForegroundColor Cyan
    return @(
        "Found $($backupFiles.Count) backup file(s) to remove.",
        "Running in WhatIf mode - no files were actually deleted."
    )
}

# Prompt for confirmation if not running in WhatIf mode
$confirmation = Read-Host "`nDelete $($backupFiles.Count) backup file(s)? (Y/N)"
if ($confirmation -ne "Y" -and $confirmation -ne "y") {
    Write-Host "Operation cancelled by user." -ForegroundColor Yellow
    return "Operation cancelled by user."
}

# Delete the backup files
$deletedCount = 0
$errorCount = 0

foreach ($file in $backupFiles) {
    try {
        $relativePath = $file.FullName.Substring($cursorRulesDir.Length).TrimStart('\', '/')
        Remove-Item -Path $file.FullName -Force
        Write-Host "Deleted: $relativePath" -ForegroundColor Green
        $deletedCount++
    }
    catch {
        Write-Host "Error deleting file $($file.FullName): $_" -ForegroundColor Red
        $errorCount++
    }
}

Write-Host "`nBackup cleanup completed." -ForegroundColor Green
Write-Host "- Files deleted: $deletedCount" -ForegroundColor Green
if ($errorCount -gt 0) {
    Write-Host "- Errors encountered: $errorCount" -ForegroundColor Red
}

return @(
    "Backup cleanup completed.",
    "Files deleted: $deletedCount",
    "Errors encountered: $errorCount"
)
